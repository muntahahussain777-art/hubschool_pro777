import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../config/supabase_config.dart';
import '../../data/repositories/database_provider.dart';
import 'supabase_service.dart';

/// Maps entity name → Supabase table name
const _entityToTable = {
  'student':            SupabaseConfig.tStudents,
  'fee_payment':        SupabaseConfig.tFeePayments,
  'fee_invoice':        SupabaseConfig.tFeeInvoices,
  'attendance':         SupabaseConfig.tStaffAttendance,
  'marks':              SupabaseConfig.tExamMarks,
  'expense':            SupabaseConfig.tExpenses,
  'staff':              SupabaseConfig.tStaff,
  'payroll_line':       SupabaseConfig.tPayrollLines,
  'salary_advance':     SupabaseConfig.tSalaryAdvances,
};

class SupabaseSyncService {
  final Ref _ref;
  SupabaseSyncService(this._ref);

  /// Call this whenever internet becomes available
  Future<SyncResult> syncAll() async {
    final conn = await Connectivity().checkConnectivity();
    if (conn.contains(ConnectivityResult.none) && conn.length == 1) {
      return const SyncResult(synced: 0, failed: 0, skipped: true);
    }

    final syncDao = _ref.read(syncDaoProvider);
    final pending = await syncDao.getPending();

    if (pending.isEmpty) return SyncResult(synced: 0, failed: 0);

    int synced = 0;
    int failed = 0;

    for (final item in pending) {
      try {
        final payload = jsonDecode(item.payloadJson) as Map<String, dynamic>;
        final table = _entityToTable[item.entity];

        if (table == null) {
          await syncDao.markSynced(item.id);
          synced++;
          continue;
        }

        switch (item.operation) {
          case 'insert':
            await supabase.from(table).upsert(payload);
            break;
          case 'update':
            final id = payload['id'];
            await supabase.from(table).update(payload).eq('id', id);
            break;
          case 'delete':
            final id = payload['id'];
            await supabase.from(table).delete().eq('id', id);
            break;
        }

        await syncDao.markSynced(item.id);
        synced++;
      } catch (e) {
        await syncDao.markFailed(item.id, item.retryCount + 1);
        failed++;
      }
    }

    return SyncResult(synced: synced, failed: failed);
  }

  // ── Individual sync helpers ──────────────────────────────

  Future<void> upsertStudent(Map<String, dynamic> data) async {
    await supabase.from(SupabaseConfig.tStudents).upsert(data);
  }

  Future<void> recordPayment(Map<String, dynamic> data) async {
    await supabase.from(SupabaseConfig.tFeePayments).insert(data);
  }

  Future<void> updateInvoice(int id, Map<String, dynamic> data) async {
    await supabase.from(SupabaseConfig.tFeeInvoices).update(data).eq('id', id);
  }

  Future<void> markStaffAttendance(Map<String, dynamic> data) async {
    await supabase
        .from(SupabaseConfig.tStaffAttendance)
        .upsert(data, onConflict: 'staff_id,date');
  }

  Future<void> upsertMarks(Map<String, dynamic> data) async {
    await supabase
        .from(SupabaseConfig.tExamMarks)
        .upsert(data, onConflict: 'exam_id,student_id,component_id');
  }

  Future<void> addExpense(Map<String, dynamic> data) async {
    await supabase.from(SupabaseConfig.tExpenses).insert(data);
  }

  // ── Pull (Download from Supabase to local) ───────────────

  Future<List<Map<String, dynamic>>> pullStudents() async {
    final res = await supabase
        .from(SupabaseConfig.tStudents)
        .select()
        .eq('is_active', true)
        .order('full_name');
    return List<Map<String, dynamic>>.from(res);
  }

  Future<List<Map<String, dynamic>>> pullFeeInvoices(int studentId) async {
    final res = await supabase
        .from(SupabaseConfig.tFeeInvoices)
        .select()
        .eq('student_id', studentId)
        .order('created_at', ascending: false);
    return List<Map<String, dynamic>>.from(res);
  }

  Future<List<Map<String, dynamic>>> pullStaff() async {
    final res = await supabase
        .from(SupabaseConfig.tStaff)
        .select()
        .eq('is_active', true)
        .order('full_name');
    return List<Map<String, dynamic>>.from(res);
  }

  Future<Map<String, dynamic>> pullDashboardStats() async {
    final now = DateTime.now();
    final monthKey =
        '${now.year}-${now.month.toString().padLeft(2, '0')}';

    final invoicesRes = await supabase
        .from(SupabaseConfig.tFeeInvoices)
        .select('paid_amount, due_amount, status')
        .eq('month_key', monthKey);

    final invoices = List<Map<String, dynamic>>.from(invoicesRes);
    final monthlyRevenue =
        invoices.fold<int>(0, (s, i) => s + (i['paid_amount'] as int? ?? 0));
    final pendingDues =
        invoices.fold<int>(0, (s, i) => s + (i['due_amount'] as int? ?? 0));

    final studentsRes = await supabase
        .from(SupabaseConfig.tStudents)
        .select('id')
        .eq('is_active', true);
    final totalStudents = (studentsRes as List).length;

    final staffRes = await supabase
        .from(SupabaseConfig.tStaff)
        .select('id')
        .eq('is_active', true);
    final totalStaff = (staffRes as List).length;

    return {
      'monthly_revenue': monthlyRevenue,
      'pending_dues': pendingDues,
      'total_students': totalStudents,
      'total_staff': totalStaff,
    };
  }
}

class SyncResult {
  final int synced;
  final int failed;
  final bool skipped;
  const SyncResult({required this.synced, required this.failed, this.skipped = false});
  // ignore: prefer_const_constructors_in_immutables

  @override
  String toString() =>
      skipped ? 'Skipped (offline)' : 'Synced: $synced | Failed: $failed';
}

final supabaseSyncProvider = Provider((ref) => SupabaseSyncService(ref));

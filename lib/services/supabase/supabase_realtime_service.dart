import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../config/supabase_config.dart';
import 'supabase_service.dart';

/// Listens to Supabase Realtime changes on key tables.
/// Use this to reflect cloud changes instantly in UI.
class SupabaseRealtimeService {
  RealtimeChannel? _feeChannel;
  RealtimeChannel? _studentChannel;
  RealtimeChannel? _attendanceChannel;

  void subscribeToFeeUpdates({
    required void Function(Map<String, dynamic> payload) onUpdate,
  }) {
    _feeChannel = supabase
        .channel('fee_invoices_changes')
        .onPostgresChanges(
          event: PostgresChangeEvent.all,
          schema: 'public',
          table: SupabaseConfig.tFeeInvoices,
          callback: (payload) => onUpdate(payload.newRecord),
        )
        .subscribe();
  }

  void subscribeToStudents({
    required void Function(Map<String, dynamic> payload) onInsert,
  }) {
    _studentChannel = supabase
        .channel('students_changes')
        .onPostgresChanges(
          event: PostgresChangeEvent.insert,
          schema: 'public',
          table: SupabaseConfig.tStudents,
          callback: (payload) => onInsert(payload.newRecord),
        )
        .subscribe();
  }

  void subscribeToAttendance({
    required void Function(Map<String, dynamic> payload) onChange,
  }) {
    _attendanceChannel = supabase
        .channel('attendance_changes')
        .onPostgresChanges(
          event: PostgresChangeEvent.all,
          schema: 'public',
          table: SupabaseConfig.tStaffAttendance,
          callback: (payload) => onChange(payload.newRecord),
        )
        .subscribe();
  }

  void dispose() {
    _feeChannel?.unsubscribe();
    _studentChannel?.unsubscribe();
    _attendanceChannel?.unsubscribe();
  }
}

final realtimeServiceProvider =
    Provider((_) => SupabaseRealtimeService());

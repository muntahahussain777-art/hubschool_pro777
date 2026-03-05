import 'package:drift/drift.dart' hide Column;
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/glass_card.dart';
import '../../../data/local/school_database.dart';
import '../../../data/repositories/database_provider.dart';
import '../application/staff_controller.dart';

class StaffScreen extends ConsumerStatefulWidget {
  const StaffScreen({super.key});

  @override
  ConsumerState<StaffScreen> createState() => _StaffScreenState();
}

class _StaffScreenState extends ConsumerState<StaffScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabCtrl;

  @override
  void initState() {
    super.initState();
    _tabCtrl = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Staff & Payroll'),
        bottom: TabBar(
          controller: _tabCtrl,
          indicatorColor: AppColors.primary,
          labelColor: AppColors.primary,
          unselectedLabelColor: AppColors.textMuted,
          tabs: const [
            Tab(text: 'Attendance'),
            Tab(text: 'Payroll'),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.person_add_rounded, color: AppColors.primary),
            onPressed: () => _addStaffDialog(context, ref),
          ),
        ],
      ),
      body: TabBarView(
        controller: _tabCtrl,
        children: const [
          _AttendanceTab(),
          _PayrollTab(),
        ],
      ),
    );
  }

  void _addStaffDialog(BuildContext context, WidgetRef ref) {
    final nameCtrl = TextEditingController();
    final codeCtrl = TextEditingController();
    final salaryCtrl = TextEditingController();

    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.surface,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => Padding(
        padding: EdgeInsets.only(
          left: 20, right: 20, top: 20,
          bottom: MediaQuery.of(context).viewInsets.bottom + 20,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Add Staff Member',
                style: TextStyle(color: AppColors.textPrimary, fontSize: 16, fontWeight: FontWeight.w700)),
            const SizedBox(height: 16),
            TextField(controller: nameCtrl,
                style: const TextStyle(color: AppColors.textPrimary),
                decoration: const InputDecoration(labelText: 'Full Name')),
            const SizedBox(height: 12),
            TextField(controller: codeCtrl,
                style: const TextStyle(color: AppColors.textPrimary),
                decoration: const InputDecoration(labelText: 'Employee Code')),
            const SizedBox(height: 12),
            TextField(
              controller: salaryCtrl,
              keyboardType: TextInputType.number,
              style: const TextStyle(color: AppColors.textPrimary),
              decoration: const InputDecoration(labelText: 'Base Salary (Rs)'),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: () async {
                  final dao = ref.read(staffDaoProvider);
                  await dao.insertStaff(StaffCompanion(
                    fullName: Value(nameCtrl.text.trim()),
                    employeeCode: Value(codeCtrl.text.trim()),
                    baseSalary: Value((int.tryParse(salaryCtrl.text) ?? 0) * 100),
                  ));
                  if (context.mounted) Navigator.pop(context);
                },
                child: const Text('Add Staff'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AttendanceTab extends ConsumerWidget {
  const _AttendanceTab();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final staffAsync = ref.watch(staffListProvider);
    final todayAsync = ref.watch(todayAttendanceProvider);

    return staffAsync.when(
      loading: () => const Center(child: CircularProgressIndicator(color: AppColors.primary)),
      error: (e, _) => Center(child: Text('Error: $e')),
      data: (staffList) {
        final todayMap = todayAsync.maybeWhen(
          data: (records) => {for (final r in records) r.staffId: r},
          orElse: () => <int, StaffAttendanceData>{},
        );

        return Column(
          children: [
            Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppColors.primary, AppColors.primaryLight],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Row(
                children: [
                  const Icon(Icons.people_rounded, color: Colors.white, size: 20),
                  const SizedBox(width: 10),
                  Text(
                    '${todayMap.values.where((r) => r.status == 'present').length} / ${staffList.length} Present Today',
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: () => _markAllPresent(ref, staffList),
                    child: const Text('Mark All', style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: staffList.length,
                itemBuilder: (_, i) {
                  final member = staffList[i];
                  final record = todayMap[member.id];
                  return _StaffAttendanceTile(
                    staff: member,
                    record: record,
                    index: i,
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }

  void _markAllPresent(WidgetRef ref, List<StaffData> staffList) {
    final ctrl = ref.read(staffAttendanceControllerProvider.notifier);
    for (final s in staffList) {
      ctrl.markPresent(s.id);
    }
  }
}

class _StaffAttendanceTile extends ConsumerWidget {
  final StaffData staff;
  final StaffAttendanceData? record;
  final int index;

  const _StaffAttendanceTile({required this.staff, this.record, required this.index});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final status = record?.status ?? 'not_marked';
    final statusColor = {
      'present': AppColors.success,
      'absent': AppColors.error,
      'leave': AppColors.warning,
    }[status] ?? AppColors.textMuted;

    return GlassCard(
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text(
                staff.fullName.substring(0, 1).toUpperCase(),
                style: const TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(staff.fullName,
                    style: const TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.w600, fontSize: 14)),
                Text(staff.designation,
                    style: const TextStyle(color: AppColors.textMuted, fontSize: 11)),
              ],
            ),
          ),
          Row(
            children: [
              _AttBtn(
                label: 'P',
                color: AppColors.success,
                active: status == 'present',
                onTap: () => ref.read(staffAttendanceControllerProvider.notifier).markPresent(staff.id),
              ),
              const SizedBox(width: 6),
              _AttBtn(
                label: 'A',
                color: AppColors.error,
                active: status == 'absent',
                onTap: () => ref.read(staffAttendanceControllerProvider.notifier).markAbsent(staff.id),
              ),
            ],
          ),
        ],
      ),
    )
        .animate(delay: Duration(milliseconds: index * 40))
        .fadeIn(duration: 250.ms)
        .slideX(begin: -0.04);
  }
}

class _AttBtn extends StatelessWidget {
  final String label;
  final Color color;
  final bool active;
  final VoidCallback onTap;

  const _AttBtn({required this.label, required this.color, required this.active, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 34,
        height: 34,
        decoration: BoxDecoration(
          color: active ? color : color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: color.withOpacity(active ? 1 : 0.3)),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              color: active ? Colors.white : color,
              fontWeight: FontWeight.w700,
              fontSize: 13,
            ),
          ),
        ),
      ),
    );
  }
}

class _PayrollTab extends ConsumerWidget {
  const _PayrollTab();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final staffAsync = ref.watch(staffListProvider);

    return staffAsync.when(
      loading: () => const Center(child: CircularProgressIndicator(color: AppColors.primary)),
      error: (e, _) => Center(child: Text('Error: $e')),
      data: (staffList) => Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: ElevatedButton.icon(
              onPressed: () => _generatePayroll(context, ref),
              icon: const Icon(Icons.calculate_rounded, size: 18),
              label: const Text('Generate This Month\'s Payroll'),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 48),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: staffList.length,
              itemBuilder: (_, i) => _PayrollTile(staff: staffList[i], index: i),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _generatePayroll(BuildContext context, WidgetRef ref) async {
    try {
      final dao = ref.read(staffDaoProvider);
      final db = ref.read(schoolDatabaseProvider);
      final staffList = await dao.watchActiveStaff().first;
      if (staffList.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('No staff found')));
        return;
      }
      final now = DateTime.now();
      final monthKey = '${now.year}-${now.month.toString().padLeft(2, '0')}';
      final existing = await (db.select(db.payrollRuns)..where((r) => r.monthKey.equals(monthKey))).get();
      if (existing.isNotEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('This month payroll already generated'), backgroundColor: AppColors.warning));
        return;
      }
      final runId = await dao.createPayrollRun(PayrollRunsCompanion.insert(monthKey: monthKey, generatedBy: 1));
      for (final s in staffList) {
        final advanceTotal = await dao.getPendingAdvanceTotal(s.id);
        final net = s.baseSalary - advanceTotal;
        await dao.insertPayrollLine(PayrollLinesCompanion.insert(
          payrollRunId: runId,
          staffId: s.id,
          grossPay: s.baseSalary,
          advanceDeduction: Value(advanceTotal),
          absentDeduction: const Value(0),
          netPay: net > 0 ? net : 0,
        ));
      }
      if (context.mounted) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Payroll generated!'), backgroundColor: AppColors.success, behavior: SnackBarBehavior.floating));
    } catch (e) {
      if (context.mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e'), backgroundColor: AppColors.error));
    }
  }
}

class _PayrollTile extends ConsumerWidget {
  final StaffData staff;
  final int index;

  const _PayrollTile({required this.staff, required this.index});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gross = staff.baseSalary;
    return GlassCard(
      padding: const EdgeInsets.all(14),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.success.withOpacity(0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.account_balance_wallet_rounded, color: AppColors.success, size: 20),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(staff.fullName,
                    style: const TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.w600)),
                Text(staff.designation, style: const TextStyle(color: AppColors.textMuted, fontSize: 11)),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text('Rs ${(gross ~/ 100).toString()}', style: const TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.w700, fontSize: 15)),
              const Text('Gross', style: TextStyle(color: AppColors.textMuted, fontSize: 10)),
            ],
          ),
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert, color: AppColors.textMuted, size: 20),
            color: AppColors.card,
            onSelected: (v) {
              if (v == 'edit') _editStaff(context, ref);
              else if (v == 'delete') _deleteStaff(context, ref);
            },
            itemBuilder: (_) => [
              const PopupMenuItem(value: 'edit', child: Text('Edit', style: TextStyle(color: AppColors.textPrimary))),
              const PopupMenuItem(value: 'delete', child: Text('Delete', style: TextStyle(color: AppColors.error))),
            ],
          ),
        ],
      ),
    )
        .animate(delay: Duration(milliseconds: index * 40))
        .fadeIn(duration: 250.ms);
  }

  void _editStaff(BuildContext context, WidgetRef ref) {
    final nameCtrl = TextEditingController(text: staff.fullName);
    final codeCtrl = TextEditingController(text: staff.employeeCode);
    final salaryCtrl = TextEditingController(text: (staff.baseSalary ~/ 100).toString());
    String designation = staff.designation;
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.surface,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (_) => StatefulBuilder(builder: (ctx, setS) => Padding(
        padding: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          const Text('Edit Staff', style: TextStyle(color: AppColors.textPrimary, fontSize: 16, fontWeight: FontWeight.w700)),
          const SizedBox(height: 16),
          TextField(controller: nameCtrl, style: const TextStyle(color: AppColors.textPrimary), decoration: const InputDecoration(labelText: 'Full Name')),
          const SizedBox(height: 12),
          TextField(controller: codeCtrl, style: const TextStyle(color: AppColors.textPrimary), decoration: const InputDecoration(labelText: 'Employee Code')),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            decoration: BoxDecoration(color: AppColors.card, borderRadius: BorderRadius.circular(12), border: Border.all(color: AppColors.cardBorder)),
            child: DropdownButtonHideUnderline(child: DropdownButton<String>(
              value: designation, isExpanded: true, dropdownColor: AppColors.card,
              style: const TextStyle(color: AppColors.textPrimary, fontSize: 13),
              items: AppConstants.designations.map((d) => DropdownMenuItem(value: d, child: Text(d))).toList(),
              onChanged: (v) => setS(() => designation = v ?? designation),
            )),
          ),
          const SizedBox(height: 12),
          TextField(controller: salaryCtrl, keyboardType: TextInputType.number, style: const TextStyle(color: AppColors.textPrimary), decoration: const InputDecoration(labelText: 'Base Salary (Rs)')),
          const SizedBox(height: 20),
          SizedBox(width: double.infinity, height: 48, child: ElevatedButton(
            onPressed: () async {
              await ref.read(staffDaoProvider).updateStaff(staff.toCompanion(true).copyWith(
                fullName: Value(nameCtrl.text.trim()),
                employeeCode: Value(codeCtrl.text.trim()),
                designation: Value(designation),
                baseSalary: Value((int.tryParse(salaryCtrl.text) ?? 0) * 100),
              ));
              if (ctx.mounted) Navigator.pop(ctx);
            },
            child: const Text('Update'),
          )),
        ]),
      )),
    );
  }

  void _deleteStaff(BuildContext context, WidgetRef ref) async {
    final ok = await showDialog<bool>(context: context, builder: (_) => AlertDialog(
      backgroundColor: AppColors.card,
      title: const Text('Delete Staff?', style: TextStyle(color: AppColors.textPrimary)),
      content: Text('${staff.fullName} ko delete karein?', style: const TextStyle(color: AppColors.textSecondary)),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancel')),
        TextButton(onPressed: () => Navigator.pop(context, true), child: const Text('Delete', style: TextStyle(color: AppColors.error))),
      ],
    ));
    if (ok == true) {
      await ref.read(staffDaoProvider).updateStaff(StaffCompanion(id: Value(staff.id), isActive: Value(false)));
      if (context.mounted) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Staff deleted'), backgroundColor: AppColors.success, behavior: SnackBarBehavior.floating));
    }
  }
}

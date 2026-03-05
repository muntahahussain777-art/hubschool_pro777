import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/widgets/glass_card.dart';
import '../../../core/widgets/stat_tile.dart';
import '../application/dashboard_provider.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final statsAsync = ref.watch(dashboardStatsProvider);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _buildAppBar(context),
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                statsAsync.when(
                  loading: () => _buildShimmerStats(),
                  error: (e, _) => _buildError(e),
                  data: (stats) => _buildStats(stats),
                ),
                const SizedBox(height: 20),
                _buildRevenueChart(ref),
                const SizedBox(height: 20),
                _buildQuickActions(context),
                const SizedBox(height: 20),
                _buildRecentActivity(ref),
                const SizedBox(height: 80),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  SliverAppBar _buildAppBar(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 120,
      pinned: true,
      backgroundColor: AppColors.bg,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [AppColors.bg, Color(0xFF0D1630)],
            ),
          ),
          padding: const EdgeInsets.fromLTRB(20, 50, 20, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'HubSchool Pro',
                          style: TextStyle(
                            color: AppColors.textPrimary,
                            fontSize: 24,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        Text(
                          'Dashboard',
                          style: TextStyle(
                            color: AppColors.primary,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.primary.withOpacity(0.3)),
                    ),
                    child: const Icon(Icons.notifications_outlined, color: AppColors.primary, size: 22),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStats(stats) {
    return Column(
      children: [
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 1.4,
          children: [
            StatTile(
              label: 'Total Students',
              value: stats.totalStudents.toString(),
              icon: Icons.school_rounded,
              color: AppColors.primary,
              subtitle: 'Active',
              animIndex: 0,
            ),
            StatTile(
              label: 'Monthly Revenue',
              value: Fmt.moneyInt(stats.monthlyRevenue ~/ 100),
              icon: Icons.payments_rounded,
              color: AppColors.success,
              subtitle: '+12%',
              animIndex: 1,
            ),
            StatTile(
              label: 'Staff Present',
              value: stats.presentToday.toString(),
              icon: Icons.badge_rounded,
              color: AppColors.secondary,
              animIndex: 2,
            ),
            StatTile(
              label: 'Pending Dues',
              value: Fmt.moneyInt(stats.pendingDues ~/ 100),
              icon: Icons.warning_amber_rounded,
              color: AppColors.warning,
              animIndex: 3,
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: StatTile(
                label: 'Monthly Expenses',
                value: Fmt.moneyInt(stats.monthlyExpenses ~/ 100),
                icon: Icons.receipt_long_rounded,
                color: AppColors.accent,
                animIndex: 4,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: StatTile(
                label: 'Total Staff',
                value: stats.totalStaff.toString(),
                icon: Icons.people_rounded,
                color: Color(0xFFFF63B8),
                animIndex: 5,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildRevenueChart(WidgetRef ref) {
    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text(
                'Revenue Overview',
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  'This Year',
                  style: TextStyle(color: AppColors.primary, fontSize: 11, fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 180,
            child: LineChart(
              LineChartData(
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  getDrawingHorizontalLine: (_) => FlLine(
                    color: AppColors.cardBorder,
                    strokeWidth: 1,
                  ),
                ),
                titlesData: FlTitlesData(
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 40,
                      getTitlesWidget: (v, _) => Text(
                        '${(v / 1000).toStringAsFixed(0)}K',
                        style: const TextStyle(color: AppColors.textMuted, fontSize: 10),
                      ),
                    ),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (v, _) {
                        const months = ['J', 'F', 'M', 'A', 'M', 'J', 'J', 'A', 'S', 'O', 'N', 'D'];
                        if (v.toInt() >= 0 && v.toInt() < months.length) {
                          return Text(months[v.toInt()], style: const TextStyle(color: AppColors.textMuted, fontSize: 10));
                        }
                        return const SizedBox();
                      },
                    ),
                  ),
                  rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                ),
                borderData: FlBorderData(show: false),
                lineBarsData: [
                  LineChartBarData(
                    spots: const [
                      FlSpot(0, 45000), FlSpot(1, 52000), FlSpot(2, 48000),
                      FlSpot(3, 65000), FlSpot(4, 61000), FlSpot(5, 75000),
                      FlSpot(6, 72000), FlSpot(7, 80000), FlSpot(8, 90000),
                      FlSpot(9, 85000), FlSpot(10, 95000), FlSpot(11, 100000),
                    ],
                    isCurved: true,
                    color: AppColors.primary,
                    barWidth: 2.5,
                    dotData: const FlDotData(show: false),
                    belowBarData: BarAreaData(
                      show: true,
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          AppColors.primary.withOpacity(0.3),
                          AppColors.primary.withOpacity(0),
                        ],
                      ),
                    ),
                  ),
                  LineChartBarData(
                    spots: const [
                      FlSpot(0, 20000), FlSpot(1, 25000), FlSpot(2, 22000),
                      FlSpot(3, 30000), FlSpot(4, 28000), FlSpot(5, 35000),
                      FlSpot(6, 32000), FlSpot(7, 38000), FlSpot(8, 42000),
                      FlSpot(9, 40000), FlSpot(10, 45000), FlSpot(11, 48000),
                    ],
                    isCurved: true,
                    color: AppColors.accent,
                    barWidth: 2,
                    dotData: const FlDotData(show: false),
                    dashArray: [5, 3],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              _legendDot(AppColors.primary, 'Revenue'),
              const SizedBox(width: 16),
              _legendDot(AppColors.accent, 'Expenses'),
            ],
          ),
        ],
      ),
    )
        .animate(delay: 200.ms)
        .fadeIn(duration: 400.ms)
        .slideY(begin: 0.1, end: 0, duration: 400.ms);
  }

  Widget _legendDot(Color color, String label) {
    return Row(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 6),
        Text(label, style: const TextStyle(color: AppColors.textSecondary, fontSize: 12)),
      ],
    );
  }

  Widget _buildQuickActions(BuildContext context) {
    final actions = [
      _QuickAction('Add\nStudent', Icons.person_add_rounded, AppColors.primary, '/students/add'),
      _QuickAction('Collect\nFee', Icons.payments_rounded, AppColors.success, '/fees'),
      _QuickAction('Exams &\nMarksheet', Icons.assignment_rounded, AppColors.accent, '/exams'),
      _QuickAction('Expenses', Icons.receipt_long_rounded, AppColors.accent, '/expenses'),
      _QuickAction('Student\nAttend.', Icons.how_to_reg_rounded, AppColors.secondary, '/student-attendance'),
      _QuickAction('Voice\nAttend.', Icons.mic_rounded, AppColors.secondary, '/voice-attendance'),
      _QuickAction('Reports', Icons.summarize_rounded, AppColors.accent, '/reports'),
      _QuickAction('Settings', Icons.settings_rounded, AppColors.warning, '/settings'),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Quick Actions',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 12),
        GridView.count(
          crossAxisCount: 3,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: 0.9,
          children: actions.asMap().entries.map((e) => _buildActionButton(context, e.value, e.key)).toList(),
        ),
      ],
    );
  }

  Widget _buildActionButton(BuildContext context, _QuickAction action, int index) {
    return GestureDetector(
      onTap: () => context.push(action.route),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [action.color.withOpacity(0.2), action.color.withOpacity(0.05)],
          ),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: action.color.withOpacity(0.3)),
        ),
        child: Column(
          children: [
            Icon(action.icon, color: action.color, size: 26),
            const SizedBox(height: 6),
            Text(
              action.label,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 10,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      )
          .animate(delay: Duration(milliseconds: 300 + index * 80))
          .fadeIn(duration: 350.ms)
          .scale(begin: const Offset(0.8, 0.8), end: const Offset(1, 1)),
    );
  }

  Widget _buildRecentActivity(WidgetRef ref) {
    final invoicesAsync = ref.watch(recentInvoicesProvider);
    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Recent Fee Activity',
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 12),
          invoicesAsync.when(
            loading: () => const Center(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: CircularProgressIndicator(color: AppColors.primary, strokeWidth: 2),
              ),
            ),
            error: (e, _) => Text('Error: $e', style: const TextStyle(color: AppColors.error)),
            data: (invoices) {
              if (invoices.isEmpty) {
                return const Padding(
                  padding: EdgeInsets.all(20),
                  child: Center(
                    child: Text(
                      'No invoices yet',
                      style: TextStyle(color: AppColors.textMuted),
                    ),
                  ),
                );
              }
              return Column(
                children: invoices
                    .take(5)
                    .map((inv) => _buildInvoiceRow(inv))
                    .toList(),
              );
            },
          ),
        ],
      ),
    ).animate(delay: 500.ms).fadeIn(duration: 400.ms);
  }

  Widget _buildInvoiceRow(invoice) {
    final statusColor = {
      'paid': AppColors.success,
      'partial': AppColors.warning,
      'unpaid': AppColors.error,
    }[invoice.status] ?? AppColors.textMuted;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: statusColor.withOpacity(0.15),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              invoice.status == 'paid'
                  ? Icons.check_circle_outline
                  : Icons.pending_outlined,
              color: statusColor,
              size: 18,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Invoice #${invoice.id} · ${Fmt.monthLabel(invoice.monthKey)}',
                  style: const TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  Fmt.date(invoice.createdAt),
                  style: const TextStyle(color: AppColors.textMuted, fontSize: 11),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                Fmt.moneyInt(invoice.netAmount ~/ 100),
                style: const TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  invoice.status.toUpperCase(),
                  style: TextStyle(color: statusColor, fontSize: 9, fontWeight: FontWeight.w700),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildShimmerStats() {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(40),
        child: CircularProgressIndicator(color: AppColors.primary, strokeWidth: 2),
      ),
    );
  }

  Widget _buildError(Object e) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.error.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text('Error: $e', style: const TextStyle(color: AppColors.error)),
    );
  }
}

class _QuickAction {
  final String label;
  final IconData icon;
  final Color color;
  final String route;
  const _QuickAction(this.label, this.icon, this.color, this.route);
}

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/local/school_database.dart';
import '../../../data/repositories/database_provider.dart';

final dashboardStatsProvider = FutureProvider<DashboardStats>((ref) async {
  final dao = ref.watch(dashboardDaoProvider);
  return dao.getStats();
});

final recentInvoicesProvider = StreamProvider<List<FeeInvoice>>((ref) {
  return ref.watch(dashboardDaoProvider).watchRecentInvoices();
});

class AppConstants {
  static const String appName = 'HubSchool Pro';
  static const String appVersion = '1.0.0';

  // Payment methods
  static const List<String> paymentMethods = ['cash', 'bank', 'jazzcash', 'easypaisa'];

  // Staff designations
  static const List<String> designations = [
    'Principal',
    'Vice Principal',
    'Teacher',
    'Lab Assistant',
    'Clerk',
    'Peon',
    'Guard',
  ];

  // Invoice statuses
  static const String statusUnpaid = 'unpaid';
  static const String statusPartial = 'partial';
  static const String statusPaid = 'paid';

  static const Map<String, String> statusLabels = {
    'unpaid': 'Unpaid',
    'partial': 'Partial',
    'paid': 'Paid',
  };
}

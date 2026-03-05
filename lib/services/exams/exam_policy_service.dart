import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Stores exam-related policy like pass/fail threshold.
class ExamPolicyService {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  static const _kPassFailAutoKey = 'hubschool_pass_fail_auto';
  static const _kPassFailThresholdKey = 'hubschool_pass_fail_threshold';

  /// Default Pakistani-style passing percentage when auto mode is ON.
  static const double defaultAutoThreshold = 33.0;

  Future<bool> isPassFailAuto() async {
    final v = await _storage.read(key: _kPassFailAutoKey);
    // default: auto ON
    return v != '0';
  }

  Future<void> setPassFailAuto(bool enabled) async {
    await _storage.write(key: _kPassFailAutoKey, value: enabled ? '1' : '0');
  }

  /// Returns the active passing percentage.
  ///
  /// If auto is enabled, returns [defaultAutoThreshold].
  /// Otherwise returns the custom stored value, defaulting to [defaultAutoThreshold] if absent.
  Future<double> getPassFailThreshold() async {
    final auto = await isPassFailAuto();
    if (auto) return defaultAutoThreshold;
    final v = await _storage.read(key: _kPassFailThresholdKey);
    final parsed = double.tryParse(v ?? '');
    return parsed ?? defaultAutoThreshold;
  }

  Future<void> setCustomPassFailThreshold(double percent) async {
    await _storage.write(
      key: _kPassFailThresholdKey,
      value: percent.toStringAsFixed(2),
    );
  }
}

final examPolicyService = ExamPolicyService();


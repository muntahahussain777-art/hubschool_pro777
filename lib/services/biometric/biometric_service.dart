import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:local_auth/local_auth.dart';

class BiometricService {
  final _auth = LocalAuthentication();
  final _storage = const FlutterSecureStorage();

  static const _kFingerprintLoginKey = 'hubschool_fingerprint_login';

  Future<bool> isAvailable() async {
    try {
      final canCheck = await _auth.canCheckBiometrics;
      final supported = await _auth.isDeviceSupported();
      return canCheck || supported;
    } catch (_) {
      return false;
    }
  }

  Future<List<BiometricType>> getAvailableTypes() async {
    try {
      return await _auth.getAvailableBiometrics();
    } catch (_) {
      return [];
    }
  }

  Future<bool> authenticate({String reason = 'Verify your identity'}) async {
    try {
      return await _auth.authenticate(
        localizedReason: reason,
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: true,
          // System dialogs on, taa ke device ka proper
          // fingerprint prompt aur error messages dikh sakein.
          useErrorDialogs: true,
        ),
      );
    } on PlatformException catch (e) {
      return false;
    }
  }

  /// Persistent app-lock toggle
  Future<bool> isFingerprintLoginEnabled() async {
    try {
      final v = await _storage.read(key: _kFingerprintLoginKey);
      return v == '1';
    } catch (_) {
      return false;
    }
  }

  Future<void> setFingerprintLoginEnabled(bool enabled) async {
    try {
      await _storage.write(key: _kFingerprintLoginKey, value: enabled ? '1' : '0');
    } catch (_) {
      // ignore
    }
  }

  /// Staff attendance via biometric
  Future<bool> authenticateForAttendance(String staffName) async {
    return authenticate(reason: 'Fingerprint to mark attendance for $staffName');
  }
}

final biometricService = BiometricService();

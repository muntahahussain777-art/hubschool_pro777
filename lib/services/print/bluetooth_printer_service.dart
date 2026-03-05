import 'dart:typed_data';
import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'thermal_receipt_service.dart';

class BluetoothPrinterService {
  static final BlueThermalPrinter _bluetooth = BlueThermalPrinter.instance;
  static final ThermalReceiptService _receipt = ThermalReceiptService();
  static BluetoothDevice? _connectedDevice;

  static Future<List<BluetoothDevice>> getBondedDevices() async {
    try {
      return await _bluetooth.getBondedDevices();
    } catch (_) {
      return [];
    }
  }

  static Future<bool> connect(BluetoothDevice device) async {
    try {
      await _bluetooth.connect(device);
      _connectedDevice = device;
      return true;
    } catch (e) {
      _connectedDevice = null;
      return false;
    }
  }

  static Future<void> disconnect() async {
    try {
      await _bluetooth.disconnect();
      _connectedDevice = null;
    } catch (_) {}
  }

  static Future<bool> get isConnected async => (await _bluetooth.isConnected) ?? false;
  static BluetoothDevice? get connectedDevice => _connectedDevice;

  static Future<bool> printFeeReceipt({
    required String schoolName,
    required String receiptNo,
    required String studentName,
    required String className,
    required int paidAmountRs,
    required int dueAmountRs,
    required int totalAmountRs,
    required DateTime paidAt,
    required String paymentMethod,
    bool is80mm = false,
  }) async {
    try {
      final bytes = await _receipt.buildFeeReceipt(
        schoolName: schoolName,
        receiptNo: receiptNo,
        studentName: studentName,
        className: className,
        paidAmountRs: paidAmountRs,
        dueAmountRs: dueAmountRs,
        totalAmountRs: totalAmountRs,
        paidAt: paidAt,
        paymentMethod: paymentMethod,
        is80mm: is80mm,
      );
      final connected = await _bluetooth.isConnected;
      if (connected != true) return false;
      await _bluetooth.writeBytes(Uint8List.fromList(bytes));
      return true;
    } catch (_) {
      return false;
    }
  }
}

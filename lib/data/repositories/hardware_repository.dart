import 'package:flutter/services.dart';

abstract class HardwareRepository {
  Future<int?> ledConnect();

  Future<int?> ledDisconnect();

  Future<bool?> ledClearScreen();

  Future<bool?> ledDisplay(double data);
}

class HardwareRepositoryImpl extends HardwareRepository {
  static const String _ledChannelName = 'pos_tong_fa.adedom.com/led';

  static const String _ledConnectMethodName = 'ledConnect';
  static const String _ledDisconnectMethodName = 'ledDisconnect';
  static const String _ledClearScreenMethodName = 'ledClearScreen';
  static const String _ledDisplayMethodName = 'ledDisplay';

  static const _ledChannel = MethodChannel(_ledChannelName);

  @override
  Future<int?> ledConnect() async {
    try {
      return await _ledChannel.invokeMethod<int>(_ledConnectMethodName);
    } on PlatformException catch (e) {
      return -1;
    }
  }

  @override
  Future<int?> ledDisconnect() async {
    try {
      return await _ledChannel.invokeMethod<int>(_ledDisconnectMethodName);
    } on PlatformException catch (e) {
      return -1;
    }
  }

  @override
  Future<bool?> ledClearScreen() async {
    try {
      return await _ledChannel.invokeMethod<bool>(_ledClearScreenMethodName);
    } on PlatformException catch (e) {
      return false;
    }
  }

  @override
  Future<bool?> ledDisplay(double data) async {
    try {
      return await _ledChannel.invokeMethod<bool>(
        _ledDisplayMethodName,
        data,
      );
    } on PlatformException catch (e) {
      return false;
    }
  }
}

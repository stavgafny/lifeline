import 'package:flutter_foreground_task/flutter_foreground_task.dart';

abstract class LocalStorage<T> {
  static const _$baseKey = "\$localStorage-@";

  final String _$key;
  final String Function(T) encode;
  final T Function(String) decode;
  final T defaultValue;

  String _lastData = "";

  LocalStorage({
    required String key,
    required this.encode,
    required this.decode,
    required this.defaultValue,
  }) : _$key = _$baseKey + key;

  Future<T> $read() async {
    _lastData = await FlutterForegroundTask.getData<String>(key: _$key) ?? "";
    if (_lastData.isEmpty) return defaultValue;
    return decode(_lastData);
  }

  Future<bool> $store(T data) async {
    final prevData = _lastData;
    _lastData = encode(data);
    if (prevData == _lastData) return false;
    return FlutterForegroundTask.saveData(key: _$key, value: _lastData);
  }
}

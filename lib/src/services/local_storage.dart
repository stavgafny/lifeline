import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class _LocalStorageCore<T> {
  final String $key;
  final Future<String?> Function({required String key}) readMethod;
  final Future<bool> Function({required String key, required String value})
      writeMethod;
  final String Function(T) encode;
  final T Function(String) decode;
  final T defaultValue;

  String _lastData = "";

  _LocalStorageCore({
    required this.$key,
    required this.readMethod,
    required this.writeMethod,
    required this.encode,
    required this.decode,
    required this.defaultValue,
  });

  Future<T> $read() async {
    try {
      _lastData = await readMethod(key: $key) ?? "";
      return decode(_lastData);
    } catch (e) {
      return defaultValue;
    }
  }

  Future<bool> $store(T data) async {
    try {
      final prevData = _lastData;
      _lastData = encode(data);
      if (prevData == _lastData) return false;
      return await writeMethod(key: $key, value: _lastData);
    } catch (e) {
      return false;
    }
  }
}

abstract class LocalStorage<T> extends _LocalStorageCore<T> {
  static const _$baseKey = "\$LocalStorage-@";

  static SharedPreferences? _pref;

  static Future<String?> _readMethod({required String key}) async {
    _pref ??= await SharedPreferences.getInstance();
    return _pref?.getString(key);
  }

  static Future<bool> _writeMethod({
    required String key,
    required String value,
  }) async {
    _pref ??= await SharedPreferences.getInstance();

    return await _pref?.setString(key, value) ?? false;
  }

  LocalStorage({
    required String key,
    required super.encode,
    required super.decode,
    required super.defaultValue,
  }) : super(
          $key: _$baseKey + key,
          readMethod: _readMethod,
          writeMethod: _writeMethod,
        );
}

abstract class SyncedIsolatesLocalStorage<T> extends _LocalStorageCore<T> {
  static const _$baseKey = "\$SyncedIsolatesLocalStorage-@";

  static Future<String?> _readMethod({required String key}) async {
    return await FlutterForegroundTask.getData(key: key);
  }

  static Future<bool> _writeMethod({
    required String key,
    required String value,
  }) async {
    return await FlutterForegroundTask.saveData(key: key, value: value);
  }

  SyncedIsolatesLocalStorage({
    required String key,
    required super.encode,
    required super.decode,
    required super.defaultValue,
  }) : super(
          $key: _$baseKey + key,
          readMethod: _readMethod,
          writeMethod: _writeMethod,
        );
}

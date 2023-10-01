import 'package:shared_preferences/shared_preferences.dart';

abstract class LocalStorage<T> {
  static const _$baseKey = "\$localStorage-@";
  static SharedPreferences? _prefs;

  static Future<void> _ensureEstablishAndRefresh() async {
    _prefs ??= await SharedPreferences.getInstance();
    await _prefs?.reload();
  }

  final String _$key;
  final String Function(T) encode;
  final T Function(String) decode;
  final T defaultValue;

  const LocalStorage({
    required String key,
    required this.encode,
    required this.decode,
    required this.defaultValue,
  }) : _$key = _$baseKey + key;

  Future<T> read() async {
    await _ensureEstablishAndRefresh();
    final jsonData = _prefs?.getString(_$key);
    if (jsonData == null || jsonData.isEmpty) return defaultValue;
    return decode(jsonData);
  }

  Future<bool> store(T data) async {
    await _ensureEstablishAndRefresh();
    return (await _prefs?.setString(_$key, encode(data))) ?? false;
  }
}

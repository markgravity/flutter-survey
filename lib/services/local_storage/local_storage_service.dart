import 'dart:convert';

import 'package:object_mapper/object_mapper.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class LocalStorageService {
  static const preferenceTokenKey = "auth_service_preference_token";

  Future<void> setObject<T extends Mappable>(T object, {required String key});

  Future<T?> getObject<T extends Mappable>(String key);

  Future<void> setListObject<T extends Mappable>(List<T> list,
      {required String key});

  Future<List<T>?> getListObject<T extends Mappable>(String key);

  Future<void> remove(String key);
}

class LocalStorageServiceImpl implements LocalStorageService {
  @override
  Future<void> setObject<T extends Mappable>(T object,
      {required String key}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, object.toJsonString());
  }

  @override
  Future<T?> getObject<T extends Mappable>(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(key);
    if (jsonString == null) {
      return null;
    }

    final Map<String, dynamic> json =
        jsonDecode(jsonString) as Map<String, dynamic>;
    return Mapper.fromJson(json).toObject<T>();
  }

  @override
  Future<List<T>?> getListObject<T extends Mappable>(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(key);
    if (jsonString == null) {
      return null;
    }

    final json = jsonDecode(jsonString) as List<dynamic>;
    return json
        .map((e) => Mapper.fromJson(e as Map<String, dynamic>).toObject<T>()!)
        .toList();
  }

  @override
  Future<void> setListObject<T extends Mappable>(List<T> list,
      {required String key}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final jsonList = list.map((e) => e.toJson()).toList();
    await prefs.setString(key, jsonEncode(jsonList));
  }

  @override
  Future<void> remove(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
  }
}

import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';
import '../utils/constants.dart';

class SharedPreferencesService {
  final SharedPreferences _prefs;

  SharedPreferencesService(this._prefs);

  // User authentication
  Future<void> setUserLoggedIn(bool value) async {
    await _prefs.setBool(AppConstants.keyIsLoggedIn, value);
  }

  bool isUserLoggedIn() {
    return _prefs.getBool(AppConstants.keyIsLoggedIn) ?? false;
  }

  Future<void> setUserId(String userId) async {
    await _prefs.setString(AppConstants.keyUserId, userId);
  }

  String? getUserId() {
    return _prefs.getString(AppConstants.keyUserId);
  }

  Future<void> setUserToken(String token) async {
    await _prefs.setString(AppConstants.keyUserToken, token);
  }

  String? getUserToken() {
    return _prefs.getString(AppConstants.keyUserToken);
  }

  Future<void> saveUserData(UserModel user) async {
    final userJson = jsonEncode(user.toJson());
    await _prefs.setString(AppConstants.keyUserData, userJson);
  }

  UserModel? getUserData() {
    final userJson = _prefs.getString(AppConstants.keyUserData);
    if (userJson == null) return null;
    
    try {
      return UserModel.fromJson(jsonDecode(userJson));
    } catch (e) {
      print('Error parsing user data: $e');
      return null;
    }
  }

  // Clear user data on logout
  Future<void> clearUserData() async {
    await _prefs.remove(AppConstants.keyIsLoggedIn);
    await _prefs.remove(AppConstants.keyUserId);
    await _prefs.remove(AppConstants.keyUserToken);
    await _prefs.remove(AppConstants.keyUserData);
  }
}

// Provider for SharedPreferencesService
final sharedPreferencesServiceProvider = Provider<SharedPreferencesService>((ref) {
  // Get the initialized service from the state provider
  final service = ref.watch(sharedPreferencesServiceStateProvider);
  if (service == null) {
    throw UnimplementedError('SharedPreferencesService must be initialized first');
  }
  return service;
});

// State provider to hold the initialized service
final sharedPreferencesServiceStateProvider = StateProvider<SharedPreferencesService?>((ref) => null);

// Initialize the SharedPreferencesService and update the state provider
Future<SharedPreferencesService> initializeSharedPreferences(ProviderContainer container) async {
  final prefs = await SharedPreferences.getInstance();
  final service = SharedPreferencesService(prefs);
  container.read(sharedPreferencesServiceStateProvider.notifier).state = service;
  return service;
}

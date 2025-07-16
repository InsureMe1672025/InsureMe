import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/user_model.dart';
import 'shared_preferences_service.dart';

class AuthService {
  final SharedPreferencesService _prefsService;

  AuthService(this._prefsService);

  // For demo purposes, we'll use mock authentication
  // In a real app, this would connect to an API
  Future<UserModel?> signIn({required String cpr, required String password}) async {
    // Simulate API call delay
    await Future.delayed(const Duration(seconds: 1));
    
    // For demo, any valid input will work
    if (cpr.isNotEmpty && password.isNotEmpty) {
      // Create a mock user
      final user = UserModel(
        id: '123456',
        cpr: cpr,
        name: 'John Doe',
        email: 'john.doe@example.com',
        phone: '97312345678',
        role: UserRole.customer,
        nationality: 'Bahraini',
        gender: 'Male',
      );
      
      // Save user data to shared preferences
      await _prefsService.setUserLoggedIn(true);
      await _prefsService.setUserId(user.id);
      await _prefsService.setUserToken('mock_token_${DateTime.now().millisecondsSinceEpoch}');
      await _prefsService.saveUserData(user);
      
      return user;
    }
    
    return null;
  }

  Future<UserModel?> register({
    required String name,
    required String cpr,
    required String phone,
    required String password,
    String? email,
    String? nationality,
    String? gender,
    String? dateOfBirth,
    String? passportNumber,
  }) async {
    // Simulate API call delay
    await Future.delayed(const Duration(seconds: 1));
    
    // For demo, any valid input will work
    if (name.isNotEmpty && cpr.isNotEmpty && phone.isNotEmpty && password.isNotEmpty) {
      // Create a mock user
      final user = UserModel(
        id: 'reg_${DateTime.now().millisecondsSinceEpoch}',
        cpr: cpr,
        name: name,
        email: email ?? '',
        phone: phone,
        role: UserRole.customer,
        nationality: nationality,
        gender: gender,
        dateOfBirth: dateOfBirth,
        passportNumber: passportNumber,
      );
      
      // Save user data to shared preferences
      await _prefsService.setUserLoggedIn(true);
      await _prefsService.setUserId(user.id);
      await _prefsService.setUserToken('mock_token_${DateTime.now().millisecondsSinceEpoch}');
      await _prefsService.saveUserData(user);
      
      return user;
    }
    
    return null;
  }

  Future<void> signOut() async {
    await _prefsService.clearUserData();
  }

  Future<UserModel?> getCurrentUser() async {
    if (!_prefsService.isUserLoggedIn()) {
      return null;
    }
    
    return _prefsService.getUserData();
  }

  bool isLoggedIn() {
    return _prefsService.isUserLoggedIn();
  }
}

// Provider for AuthService
final authServiceProvider = Provider<AuthService>((ref) {
  final prefsService = ref.watch(sharedPreferencesServiceProvider);
  return AuthService(prefsService);
});

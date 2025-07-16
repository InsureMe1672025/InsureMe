class AppConstants {
  // App information
  static const String appName = 'InsureMe';
  static const String appVersion = '1.0.0';
  
  // Shared preferences keys
  static const String keyIsLoggedIn = 'is_logged_in';
  static const String keyUserId = 'user_id';
  static const String keyUserToken = 'user_token';
  static const String keyUserData = 'user_data';
  
  // API endpoints
  static const String baseUrl = 'https://api.insureme.com/v1';
  static const String loginEndpoint = '/auth/login';
  static const String registerEndpoint = '/auth/register';
  static const String policiesEndpoint = '/policies';
  static const String companiesEndpoint = '/companies';
  static const String offersEndpoint = '/offers';
  
  // Routes
  static const String routeStart = '/start';
  static const String routeLogin = '/login';
  static const String routeRegister = '/register';
  static const String routeHome = '/home';
  static const String routePolicies = '/policies';
  static const String routeCompanies = '/companies';
  static const String routeOffers = '/offers';
  static const String routeProfile = '/profile';
  
  // Animation durations
  static const Duration defaultAnimationDuration = Duration(milliseconds: 300);
  
  // Validation
  static const int minPasswordLength = 6;
  static const String emailRegex = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
  static const String phoneRegex = r'^\d{8,12}$';
}

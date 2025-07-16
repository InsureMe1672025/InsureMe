import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:insure_me/utils/app_colors.dart';

import '../../providers/main_provider.dart';
import '../../services/auth_service.dart';
import '../../widgets/auth/auth_background.dart';
import '../../widgets/auth/auth_footer.dart';
import '../../widgets/auth/auth_form_container.dart';
import '../../widgets/common/app_logo.dart';
import '../../widgets/common/custom_button.dart';
import '../../widgets/common/custom_text_field.dart';
import '../../utils/constants.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool isRegistration = false;

  void _toggleAuthMode() {
    setState(() {
      isRegistration = !isRegistration;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSwitcher(
        duration: AppConstants.defaultAnimationDuration,
        transitionBuilder: (child, animation) {
          return FadeTransition(opacity: animation, child: child);
        },
        child:
            isRegistration
                ? RegistrationForm(
                  key: const ValueKey('RegForm'),
                  onToggle: _toggleAuthMode,
                )
                : LoginForm(
                  key: const ValueKey('LoginForm'),
                  onToggle: _toggleAuthMode,
                ),
      ),
    );
  }
}

class LoginForm extends ConsumerStatefulWidget {
  final VoidCallback onToggle;
  const LoginForm({super.key, required this.onToggle});

  @override
  ConsumerState<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends ConsumerState<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _cprController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  bool _obscurePassword = true;

  Future<void> _signIn() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final authService = ref.read(authServiceProvider);
      final user = await authService.signIn(
        cpr: _cprController.text.trim(),
        password: _passwordController.text,
      );

      if (user != null) {
        await ref.read(mainProvider.notifier).getIfUserLoggedIn();
        
        // Navigate to home screen after successful login
        if (mounted) {
          Navigator.of(context).pushNamedAndRemoveUntil(
            AppConstants.routeHome,
            (route) => false, // Remove all previous routes
          );
        }
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Invalid CPR or password'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _cprController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AuthBackground(
      backgroundImage: "assets/images/loginbackground.png",
      backgroundColor: AppColors.primary,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const AppLogo(showText: false, size: 320),
            const SizedBox(height: 40),
            AuthFormContainer(
              title: 'Sign In',
              subtitle: 'Welcome back to InsureMe',
              backgroundColor: Colors.transparent,
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    CustomTextField(
                      hintText: 'CPR',
                      hintTextStyle: const TextStyle(color: AppColors.secondary),
                      controller: _cprController,
                      keyboardType: TextInputType.text,
                      prefixIcon: const Icon(Icons.person, color: AppColors.secondary),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your CPR';
                        }
                        return null;
                      },
                    ),
                    CustomTextField(
                      hintText: 'Password',
                      hintTextStyle: const TextStyle(color: AppColors.secondary),
                      controller: _passwordController,
                      obscureText: _obscurePassword,
                      prefixIcon: const Icon(Icons.lock, color: AppColors.secondary),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword ? Icons.visibility : Icons.visibility_off,
                          color: AppColors.secondary,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 8),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          // Forgot password functionality
                        },
                        child: const Text('Forgot Password?', style: TextStyle(color: AppColors.secondaryLight)),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: GestureDetector(
                        onTap: _isLoading ? null : _signIn,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(40),
                            border: Border.all(width: 3, color: Colors.white),
                          ),
                          child: Center(
                            child: _isLoading
                              ? const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2,
                                  ),
                                )
                              : const Text(
                                'Sign In',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextButton(
                      onPressed: () {
                        // Continue as guest functionality
                      },
                      child: const Text('Continue as a guest', style: TextStyle(color: AppColors.secondaryLight)),
                    ),
                  ],
                ),
              ),
            ),
            AuthFooter(
              questionText: "Don't have an account?",
              linkText: "Sign up here",
              onLinkTap: widget.onToggle,
            ),
          ],
        ),
      ),
    );
  }
}

class RegistrationForm extends ConsumerStatefulWidget {
  final VoidCallback onToggle;
  const RegistrationForm({super.key, required this.onToggle});

  @override
  ConsumerState<RegistrationForm> createState() => _RegistrationFormState();
}

class _RegistrationFormState extends ConsumerState<RegistrationForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _cprController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nationalityController = TextEditingController();
  String? _selectedGender;
  DateTime? _selectedDate;
  bool _isLoading = false;
  bool _obscurePassword = true;

  final List<String> _genders = ['Male', 'Female'];

  Future<void> _register() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final authService = ref.read(authServiceProvider);
      final user = await authService.register(
        name: _nameController.text.trim(),
        cpr: _cprController.text.trim(),
        phone: _phoneController.text.trim(),
        password: _passwordController.text,
        email: _emailController.text.trim(),
        nationality: _nationalityController.text.trim(),
        gender: _selectedGender,
        dateOfBirth: _selectedDate?.toIso8601String(),
      );

      if (user != null) {
        await ref.read(mainProvider.notifier).getIfUserLoggedIn();
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Registration failed. Please try again.'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _cprController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _nationalityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AuthBackground(
      backgroundImage: "assets/images/pagesbackground.png",
      backgroundColor: Colors.white,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const AppLogo(),
            const SizedBox(height: 40),
            AuthFormContainer(
              title: 'Sign Up',
              subtitle: 'Be a member of our Family',
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextField(
                      hintText: 'CPR',
                      controller: _cprController,
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your CPR';
                        }
                        return null;
                      },
                    ),
                    CustomTextField(
                      hintText: 'Full Name',
                      controller: _nameController,
                      textCapitalization: TextCapitalization.words,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your name';
                        }
                        return null;
                      },
                    ),
                    CustomTextField(
                      hintText: 'Mobile Number',
                      controller: _phoneController,
                      keyboardType: TextInputType.phone,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your phone number';
                        }
                        return null;
                      },
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 8.0, top: 8.0),
                      child: Text(
                        'Gender',
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        children: _genders.map((gender) {
                          return Expanded(
                            child: Row(
                              children: [
                                Radio<String>(
                                  value: gender,
                                  groupValue: _selectedGender,
                                  onChanged: (String? value) {
                                    setState(() {
                                      _selectedGender = value;
                                    });
                                  },
                                ),
                                Text(gender),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => _selectDate(context),
                      child: AbsorbPointer(
                        child: CustomTextField(
                          hintText: 'Date of birth',
                          controller: TextEditingController(
                            text: _selectedDate != null
                                ? '${_selectedDate!.day}-${_selectedDate!.month}-${_selectedDate!.year}'
                                : '',
                          ),
                          suffixIcon: const Icon(Icons.calendar_today),
                        ),
                      ),
                    ),
                    CustomTextField(
                      hintText: 'Nationality',
                      controller: _nationalityController,
                    ),
                    CustomTextField(
                      hintText: 'Password',
                      controller: _passwordController,
                      obscureText: _obscurePassword,
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword ? Icons.visibility_off : Icons.visibility,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a password';
                        }
                        if (value.length < AppConstants.minPasswordLength) {
                          return 'Password must be at least ${AppConstants.minPasswordLength} characters';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 24),
                    CustomButton(
                      text: 'Register',
                      onPressed: _register,
                      isLoading: _isLoading,
                    ),
                  ],
                ),
              ),
            ),
            AuthFooter(
              questionText: "Already have an account?",
              linkText: "Sign in here",
              onLinkTap: widget.onToggle,
            ),
          ],
        ),
      ),
    );
  }
}

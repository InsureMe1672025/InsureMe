import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../utils/constants.dart';
import '../widgets/common/app_logo.dart';
import '../widgets/common/custom_button.dart';
import '../features/auth/auth_page.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSwitcher(
        duration: AppConstants.defaultAnimationDuration,
        transitionBuilder: (child, animation) {
          return FadeTransition(opacity: animation, child: child);
        },
        child: const StartScreenContent(),
      ),
    );
  }
}

class StartScreenContent extends StatelessWidget {
  const StartScreenContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/loginbackground.png'),
          fit: BoxFit.cover,
        ),
        color: AppColors.primary,
      ),
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Spacer(flex: 2),
            const AppLogo(size: 400, showText: false),
            const Spacer(flex: 2),
            
            // Welcome message
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(40),
                ),
                child: const Text(
                  'Welcome to the family',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            
            const SizedBox(height: 20),
            // Sign in button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const AuthPage(),
                    ),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(40),
                    border: Border.all(width: 3, color: Colors.white),
                    
                  ),
                  child:Text(
                  'Sign In',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  
                ),
                            ),
              ),),
            
            const SizedBox(height: 20),
            
            // Continue as guest
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: TextButton(
                onPressed: () {
                  // Navigate to home screen as guest
                  Navigator.of(context).pushReplacementNamed(AppConstants.routeHome);
                },
                child: const Text(
                  'Continue as a guest',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    //underline
                    decoration: TextDecoration.underline,
                    decorationColor: Colors.white,
                  ),
                ),
              ),
            ),
            
            const Spacer(),
          ],
        ),
      ),
    );
  }
}

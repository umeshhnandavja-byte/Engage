import 'package:flutter/material.dart';
import '../../../../core/theme/colors.dart';
import '../../../../services/auth_service.dart';

class LoginCard extends StatefulWidget{
  final VoidCallback? onLoginSuccess;

  const LoginCard({super.key, this.onLoginSuccess});

  @override
  State<LoginCard> createState() => _LoginCardState();
}

class _LoginCardState extends State<LoginCard> {
  final AuthService _authService = AuthService();
  bool _isLoading = false;

  Future<void> _signIn() async {
    setState(() => _isLoading = true);

    try {
      final creds = await _authService.signInWithGoogleWeb();
      if (creds != null && mounted) {
        widget.onLoginSuccess?.call();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Login failed: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.all(30),
        decoration: BoxDecoration(
          color: AppColors.loginBackground,
          borderRadius: BorderRadius.circular(40)
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Organiser Login Portal',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: AppColors.loginText
              ),
            ),

            ElevatedButton(
              onPressed: _signIn,
              child: Text('Sign In With Google')
            ),

            _isLoading
                  ? const CircularProgressIndicator()
                  : ElevatedButton.icon(
                      onPressed: _signIn,
                      icon: const Icon(Icons.login),
                      label: const Text('Sign in with Google'),
                    ),

          ],
        ),
      )
    );
  }
}
import 'package:flutter/material.dart';
import '../../../../core/theme/colors.dart';

class LoginCard extends StatelessWidget{
  const LoginCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: AppColors.loginBackground,
        borderRadius: BorderRadius.circular(40)
      ),
      child: Column(
        children: [
          Text(
            'Organiser Login Portal',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: AppColors.loginText
            ),
          ),

        ],
      ),
    );
  }
}
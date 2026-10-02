
import 'package:flutter/material.dart';
import '../widgets/login_card.dart';

class LoginPortal extends StatelessWidget{
  const LoginPortal({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      body: Padding(
        padding: EdgeInsets.all(30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LoginCard()
          ],
        ),
      )
    );
  }
}
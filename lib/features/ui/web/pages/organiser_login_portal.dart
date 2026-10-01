
import 'package:flutter/material.dart';
import '../widgets/login_card.dart';

class WebOrganiserLoginPortal extends StatelessWidget{
  const WebOrganiserLoginPortal({super.key});

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
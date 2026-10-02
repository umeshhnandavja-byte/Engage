import 'package:flutter/material.dart';
import '../../../../core/theme/colors.dart';

import 'package:firebase_auth/firebase_auth.dart';

class ProfileCard extends StatelessWidget{
  const ProfileCard ({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null){
      return const SizedBox.shrink();
    }

    return
      Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.profileBackground,
          borderRadius: BorderRadius.circular(10)
        ),
        
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,

          children: [ 
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,

                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,

                          children: [
                            Text(user.displayName ?? 'Name not Found'),
                            Text(user.email ?? 'No Email Found'),

                          ],
                        ),
                      ),

                    ],
                  )
                ],
              ),
            ),
            
        
          ],
        
        ),

    );    
  }
}
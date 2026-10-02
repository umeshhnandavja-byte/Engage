import 'package:flutter/material.dart';
import '../../../../core/theme/colors.dart';

import 'package:firebase_auth/firebase_auth.dart';

class OrganiserProfileCard extends StatelessWidget{
  const OrganiserProfileCard ({super.key});

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
                        child: Text('Organiser Image'),
                        ),

                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,

                          children: [
                            Text(
                              user.displayName ?? 'Organiser',
                            ),
                            Text(
                              user.email ?? 'Email not Found',
                            ),

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
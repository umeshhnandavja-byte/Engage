import 'package:engage/features/ui/mobile/pages/activity_page.dart';
import 'package:engage/features/ui/mobile/widgets/profile_card.dart';
import 'package:flutter/material.dart';

import '../../../../core/theme/colors.dart';

class ProfilePage extends StatefulWidget{

  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();

}

class _ProfilePageState extends State<ProfilePage>{

  @override
  Widget build(BuildContext context) {
    return  
      Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Center(
              child: Text(
                'Profile',
                style: TextStyle(
                  color: AppColors.profileTitle,
                  fontSize: 20
                ),
              ),
            ),

            SizedBox(height: 10),
            
            ProfileCard(),

            SizedBox(height: 10),

            Center(
              child: Text(
                'Events Activity',
                style: TextStyle(
                  color: AppColors.activityTitle,
                  fontSize: 20,
                ),
              ),
            ),

            SizedBox(height: 10),

           ActivityPage() 
          ],

        ),
      );


  }
}
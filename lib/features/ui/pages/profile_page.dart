import 'package:flutter/material.dart';

import '../../../core/theme/colors.dart';
import '../widgets/activity_card.dart';

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
                'Events Activity',
                style: TextStyle(
                  color: AppColors.activityTitle,
                  fontSize: 20,
                ),
              ),
            ),

            Container(
              padding: const EdgeInsets.all(15),

              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,

                children: [
                  
                  ActivityCard(
                    category: 'Registered',
                    content: 0,
                  ),

                  Spacer(),

                  ActivityCard(
                    category: 'Attended',
                    content: 0,
                  ),
                  
                  Spacer(),
                  
                  ActivityCard(
                    category: 'Unregistered',
                    content: 0,
                  ),

                ],

                  
              ),

            ),
            
          ],

        ),
      );


  }
}
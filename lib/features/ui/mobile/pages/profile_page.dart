import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:engage/core/constants/app_constants.dart';
import 'package:engage/features/ui/mobile/pages/activity_page.dart';
import 'package:engage/features/ui/mobile/widgets/profile_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../../core/theme/colors.dart';

class ProfilePage extends StatefulWidget{

  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();

}

class _ProfilePageState extends State<ProfilePage>{
  int registeredCount = 0;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchCount();
  }

  Future<void> _fetchCount() async {
      final uid = FirebaseAuth.instance.currentUser?.uid;
      if (uid == null) return;

      final doc = await FirebaseFirestore.instance.collection(AppConstants.usersCollection).doc(uid).get();

      // 2. Update the variable and refresh the screen
      setState(() {
        registeredCount = doc.data()?['eventsRegisteredCount'] ?? 0;
        isLoading = false;
      });
    }

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

           ActivityPage(
            registeredCount: registeredCount,
           ) 
          ],

        ),
      );


  }
}
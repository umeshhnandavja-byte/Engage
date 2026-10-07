import 'package:engage/features/ui/mobile/pages/activity_page.dart';
import 'package:flutter/material.dart';

import '../../../../core/theme/colors.dart';
import 'package:engage/features/ui/mobile/pages/events_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:engage/core/constants/app_constants.dart';

class HomePage extends StatefulWidget{

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();

}

class _HomePageState extends State<HomePage>{
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
    return  Column(
      children: [
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

              SizedBox(height: 10),

              ActivityPage(
                registeredCount: registeredCount,
              ),
  
            ],

          ),
        ),
        
        Align(
          alignment: Alignment.center,
          child: EventsPage(),
        )
      ]
    );

  }
}
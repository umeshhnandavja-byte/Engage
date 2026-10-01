import 'package:engage/features/ui/mobile/pages/activity_page.dart';
import 'package:flutter/material.dart';

import '../../../../core/theme/colors.dart';
import 'package:engage/features/ui/mobile/pages/events_page.dart';

class HomePage extends StatefulWidget{

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();

}

class _HomePageState extends State<HomePage>{

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

              ActivityPage(),
  
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
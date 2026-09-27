import 'package:flutter/material.dart';

import '../../../core/theme/colors.dart';
import '../widgets/activity_card.dart';
import 'package:engage/features/ui/pages/events_page.dart';

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
          padding: const EdgeInsets.all(0),
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
        ),
        
        Align(
          alignment: Alignment.center,
          child: EventsPage(),
        )
      ]
    );

  }
}
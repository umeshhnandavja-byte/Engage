import 'package:flutter/material.dart';
import '../widgets/activity_card.dart';

class ActivityPage extends StatelessWidget{
  const ActivityPage ({super.key});

  @override
  Widget build(BuildContext context) {
    return 
      Row(
        mainAxisAlignment: MainAxisAlignment.start,

        children: [
          
          Expanded(
            child: ActivityCard(
              category: 'Registered',
              content: 0,
            ),
          ),

          SizedBox(width: 10),

          Expanded(
            child: ActivityCard(
              category: 'Attended',
              content: 0,
            ),
          ),
          
          SizedBox(width: 10),
          
          Expanded(
            child: ActivityCard(
              category: 'Unregistered',
              content: 0,
            ),
          ),
          

        ],

          
      );
  }
}
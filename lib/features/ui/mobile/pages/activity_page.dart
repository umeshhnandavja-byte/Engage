import 'package:flutter/material.dart';
import '../widgets/activity_card.dart';

class ActivityPage extends StatelessWidget{
  final int registeredCount;

  ActivityPage ({
    super.key,
    required this.registeredCount,
  });
  
  @override
  Widget build(BuildContext context) {
    return 
      Row(
        mainAxisAlignment: MainAxisAlignment.start,

        children: [
          
          Expanded(
            child: ActivityCard(
              category: 'Registered',
              content: registeredCount,
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
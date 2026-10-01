import 'package:flutter/material.dart';
import '../../../../core/theme/colors.dart';

class ActivityCard extends StatelessWidget{
  final String category;
  final int content;
  
  const ActivityCard({
    super.key,
    required this.category,
    required this.content

  });

  @override
  Widget build(BuildContext context) {
    return 
      Container(
        height: 90,
        width: 90,
        decoration: BoxDecoration(
          color: AppColors.activityBackground,
          borderRadius: BorderRadius.circular(5),
                  
        ),

        child: Column(
          children: [

            Spacer(),

            Text(
              content.toString(),
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.activityContent,
                fontWeight: FontWeight.w700,
                fontSize: 30,

              ),
                                          
            ),

            Spacer(),

            Text(
              category,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.activityHeader,
                fontWeight: FontWeight.bold,
                fontSize: 16,
            
              ),
            ),

          ]
        ),

      ); 
  }
}
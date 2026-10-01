import 'package:flutter/material.dart';
import '../../../../core/theme/colors.dart';

class OrganiserEventPage extends StatelessWidget{
  const OrganiserEventPage ({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
        home: Scaffold( 
      body: Padding(
              padding: EdgeInsetsGeometry.all(15),
              child:  Container(
                padding: EdgeInsets.all(35),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColors.eventsBackground,
                  borderRadius: BorderRadius.circular(20)
                ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Event Name',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,  color: AppColors.eventsHeading),
                  ),

                  Text(
                    'Event Description',
                    style: TextStyle(fontSize: 15, color: AppColors.eventsDescription),
                  ),

                  Text(
                    'Conudcted by-',
                    style: TextStyle(fontSize: 10, color: AppColors.eventsConducted),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [

                    ],
                  )

                ],
              )


            ),
          ),
      )
    );
    
  }
}
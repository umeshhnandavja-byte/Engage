import 'package:engage/features/ui/mobile/pages/event_page.dart';
import 'package:flutter/material.dart';
import '../../../../core/theme/colors.dart';

class EventCard extends StatelessWidget{
  final String title;
  final String description;
  final String buttonText;
  
  const EventCard({
    super.key,
    required this.title,
    required this.description,
    required this.buttonText
  });
  
  @override
  Widget build(BuildContext context) {
    return 
      Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: AppColors.eventsBackground,
          borderRadius: BorderRadius.circular(10),
        ),

        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,

          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
  
                children: [
  
                  Text(
                    title,
                    style: TextStyle(color: AppColors.eventsHeading, fontSize: 20), 
                  ),
  
                  SizedBox(height: 4),
  
                  Text(
                    description,
                    style: TextStyle(color: AppColors.eventsDescription, fontSize: 14),
                  ),
  
                ]
  
              ),
            ),

            const Spacer(),

            ElevatedButton(
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EventPage(),
                  ),
                );
              }, 
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.registerButtonBackground,
                foregroundColor: AppColors.registerButtonforeground,
                
              ),
              child: Text(buttonText),

            )

          ],

        ),

      );

  }
}
import 'package:engage/features/ui/web/pages/organiser_event_page.dart';
import 'package:flutter/material.dart';
import '../../../../core/theme/colors.dart';

class OrganiserEventCard extends StatelessWidget{
  final String eventId;
  final String title;
  final String shortDescription;
  final String buttonText;
  
  const OrganiserEventCard({
    super.key,
    required this.eventId,
    required this.title,
    required this.shortDescription,
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
                    shortDescription,
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
                    builder: (context) => OrganiserEventPage(eventId: eventId,quizId: eventId),
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
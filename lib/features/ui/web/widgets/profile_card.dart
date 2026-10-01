import 'package:flutter/material.dart';
import '../../../../core/theme/colors.dart';

class OrganiserProfileCard extends StatelessWidget{
  const OrganiserProfileCard ({super.key});

  @override
  Widget build(BuildContext context) {
    return
      Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.profileBackground,
          borderRadius: BorderRadius.circular(10)
        ),
        
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,

          children: [ 
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,

                    children: [
                      Expanded( 
                        child: Text('Organiser Image'),
                        ),

                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,

                          children: [
                            Text('Organiser Name'),
                            Text('Organiser Email')

                          ],
                        ),
                      ),

                    ],
                  )
                ],
              ),
            ),
            
        
          ],
        
        ),

    );    
  }
}
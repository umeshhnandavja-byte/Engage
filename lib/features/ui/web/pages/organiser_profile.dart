import 'package:engage/features/ui/web/widgets/profile_card.dart';
import 'package:flutter/material.dart';

import '../../../../core/theme/colors.dart';

class OrganiserProfilePage extends StatefulWidget{

  const OrganiserProfilePage({super.key});

  @override
  State<OrganiserProfilePage> createState() => _OrganiserProfilePageState();

}

class _OrganiserProfilePageState extends State<OrganiserProfilePage>{

  @override
  Widget build(BuildContext context) {
    
    return  
      Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            
            Center(
              child: Text(
                'Profile',
                style: TextStyle(
                  color: AppColors.profileTitle,
                  fontSize: 20,
                ),
              ),
            ),

            SizedBox(
              height: 10
            ),

            OrganiserProfileCard()
          ],

        ),
      );


  }
}

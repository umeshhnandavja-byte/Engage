import 'package:flutter/material.dart';

import 'core/theme/colors.dart';
import 'features/ui/web/pages/organiser_portal.dart';

void main(){
  runApp(EngageWebPortalApp());
}

class EngageWebPortalApp extends StatelessWidget{
  const EngageWebPortalApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Engage Organiser Studio',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.background,
      ),
      home: const WebOrganiserPortal(),
    );
    
  }
}
import 'package:engage/core/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'core/theme/colors.dart';
import 'features/ui/web/pages/organiser_portal.dart';
import 'features/ui/web/pages/organiser_login_portal.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await Supabase.initialize(
    url:  AppConstants.supabaseUrl,
    anonKey:  AppConstants.supabaseAnonKey,
  );

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
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }

          if (snapshot.hasData && snapshot.data != null) {
            return const WebOrganiserPortal();
          }

          return const Scaffold(
            backgroundColor: Colors.red,
            body: Center(
              child: WebOrganiserLoginPortal(),
            ),
          );
        }
      ),
    );
    
  }
}
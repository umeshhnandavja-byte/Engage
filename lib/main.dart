import 'package:engage/core/constants/app_constants.dart';
import 'package:engage/features/ui/mobile/pages/login_portal.dart';
import 'package:flutter/material.dart';

import 'package:engage/core/theme/colors.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'features/ui/mobile/pages/events_page.dart';
import 'features/ui/mobile/pages/home_page.dart';
import 'features/ui/mobile/pages/profile_page.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );

  await Supabase.initialize(
    url: AppConstants.supabaseUrl,
    publishableKey: AppConstants.supabaseAnonKey,
  );

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
            return const MainNavigationShell();
          }

          return const Scaffold(
            backgroundColor: Colors.red,
            body: Center(
              child: LoginPortal(),
            ),
          );
        }
      ),
    );
  }
}

class MainNavigationShell extends StatefulWidget {
    const MainNavigationShell({super.key});

    @override
    State<MainNavigationShell> createState() => _MainNavigationShellState();
}

class _MainNavigationShellState extends State<MainNavigationShell> {
  int _currentPage = 1;

  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentPage);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _BottomNavBarTapped(int page){
    _pageController.animateToPage(
      page,
      duration: const Duration(milliseconds: 100),
      curve: Curves.easeInOut 
    );
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      
      appBar: AppBar(
        title: Text(
          'Engage',
          style: TextStyle(
          color: AppColors.appBarText,
          fontWeight: FontWeight.bold,
          fontFamily: '',
          fontSize: 31
          )
        ),
        backgroundColor: AppColors.appBarBackground,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){},
        child: Icon(Icons.qr_code_scanner),
      ),

      body: Padding(
        padding: EdgeInsets.all(0), 
        child: PageView(
          controller: _pageController,
          onPageChanged: (int page){
            setState(() {
              _currentPage = page;
            });
          },
          children: [
            EventsPage(),
            HomePage(),
            ProfilePage()
          ],
        ),
      ),

      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppColors.navBarBackground,
        unselectedItemColor: AppColors.navBarUnselectItem,
        selectedItemColor: AppColors.navBarSelectItem,

        currentIndex: _currentPage,

        onTap: _BottomNavBarTapped,

        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.upcoming),
              label: 'Upcoming Events',
            ),

            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),

            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            )
        ],

      ),

    );
    
  }

}
import 'package:flutter/material.dart';

import 'package:engage/core/theme/colors.dart';
import 'features/ui/pages/events_page.dart';
import 'features/ui/pages/home_page.dart';
import 'features/ui/pages/profile_page.dart';
void main() {
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
      home: const MainNavigationShell(),
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

  final List<Widget> _pages = const [
    EventsPage(),
    HomePage(),
    ProfilePage()
  ];

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

      body: Padding(
        padding: EdgeInsets.all(0), 
        child: PageView(
          controller: _pageController,
          onPageChanged: (int page){
            setState(() {
              _currentPage = page;
            });
          },
          children: _pages,
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
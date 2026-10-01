import 'package:engage/features/ui/web/pages/organiser_events_page.dart';
import 'package:engage/features/ui/web/pages/organiser_profile.dart';
import 'package:engage/features/ui/web/widgets/edit_profile_button.dart';
import 'package:flutter/material.dart';
import '../widgets/new_event_button.dart';
import '../../../../core/theme/colors.dart';

class WebOrganiserPortal extends StatefulWidget{
  const WebOrganiserPortal ({super.key});

  @override
  State<WebOrganiserPortal> createState() => _WebOrganiserPortalState();
}

class _WebOrganiserPortalState extends State<WebOrganiserPortal>{
  int _selectedPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Engage',
          style: TextStyle(
            fontSize: 30, 
            fontWeight: FontWeight.bold, 
            color: AppColors.appBarText
          ),
        ),
        backgroundColor: AppColors.appBarBackground,
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          NavigationRail(
            onDestinationSelected: (int index){
              setState((){
                _selectedPage = index;
              });
            },
            selectedIndex: _selectedPage,  
            destinations: const [
              NavigationRailDestination(
                icon: Icon(Icons.event), 
                label: Text('Events'),
              ),

              NavigationRailDestination(
                icon: Icon(Icons.person), 
                label: Text('Profile')
              )
              
            ]
            
          ),

          Expanded(
            child: IndexedStack(
              index: _selectedPage,
              children: [
                OrganiserEventsPage(),
                OrganiserProfilePage()
              ],
            ),
          ),
        ]
      ),
      floatingActionButton:  IndexedStack(
        index: _selectedPage,
        children: [
          NewEventButton(),
          EditOrganiserProfileButton()
        ],
      )
    );
  }
}
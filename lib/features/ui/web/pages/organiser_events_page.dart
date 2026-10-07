import 'package:engage/core/constants/app_constants.dart';
import 'package:engage/features/ui/web/widgets/organiser_event_card.dart';
import 'package:flutter/material.dart';
import '../../../../core/theme/colors.dart';
import '../../../events/data/models/event_model.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OrganiserEventsPage extends StatefulWidget{

  const OrganiserEventsPage({super.key});

  @override
  State<OrganiserEventsPage> createState() => _OrganiserEventsPageState();

}

class _OrganiserEventsPageState extends State<OrganiserEventsPage>{

  List<EventModel> _events = [

  ];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchOrganiserEvents();
  }

  Future<void> _fetchOrganiserEvents() async {
    final currentUserId = FirebaseAuth.instance.currentUser?.uid;

    if (currentUserId == null) {
      if (mounted) setState(() => _isLoading = false);
      return;
    }

    try {
      final snapshot = await FirebaseFirestore.instance
          .collection(AppConstants.eventsCollection)
          .where('organiserId', isEqualTo: currentUserId)
          .get();

      final loadedEvents = snapshot.docs.map((doc) {
        final data = doc.data();
        return EventModel(
          id: doc.id,
          title: data['name'] ?? 'Untitled Event',
          shortDescription: data['shortDescription'] ?? 'No description',
        );
      }).toList();

      if (mounted) {
        setState(() {
          _events = loadedEvents;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to load events: $e')),
        );
      }
    }
  }

  

  @override
  Widget build(BuildContext context) {

    final upcomingEvents = _events.toList();

    return SingleChildScrollView(

      physics: BouncingScrollPhysics(),
      child: Padding(

        padding: EdgeInsets.all(20),
        child: Column(

          crossAxisAlignment: CrossAxisAlignment.center,

          children: [

            Text(
              'Upcoming Events',
              style: TextStyle(
                color: AppColors.eventsTitle,
                fontSize: 20,
              )
            ),
            
            const SizedBox(height: 10),

            ...upcomingEvents.map(

              (event) => Padding(

                padding: EdgeInsets.only(bottom: 10),
                child: OrganiserEventCard(
                  eventId: event.id,
                  title: event.title,
                  shortDescription: event.shortDescription,
                  buttonText: 'Edit'
                ),

              ),
              
            ),
          ],

        ),
      ),
      
    );

  }
}                    
import 'package:flutter/material.dart';
import '../../../../core/theme/colors.dart';
import '../../../events/data/models/event_model.dart';
import '../widgets/event_card.dart';

class EventsPage extends StatefulWidget{

  const EventsPage({super.key});

  @override
  State<EventsPage> createState() => _EventsPageState();

}

class _EventsPageState extends State<EventsPage>{

  final List<EventModel> _events = [

    const EventModel(
      id: '1',
      title: 'Git & Github',
      description: 'Discussing the difference'
    ),
    
    const EventModel(
      id: '2',
      title: 'OpenSource Introduction',
      description: 'learning about opensource'
    )

  ];

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
                child: EventCard(
                  title: event.title,
                  description: event.description,
                  buttonText: 'Register'
                ),

              ),
              
            ),
          ],

        ),
      ),
      
    );

  }
}                    
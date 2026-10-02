import 'package:engage/core/constants/app_constants.dart';
import 'package:flutter/material.dart';
import '../../../../core/theme/colors.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OrganiserEventPage extends StatelessWidget{
  final String eventId;
  const OrganiserEventPage ({super.key, required this.eventId});

  Future<void> _openGoogleForm(BuildContext context, String? urlString) async {
    if (urlString == null || urlString.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No Google Form registration link attached.')),
      );
      return;
    }

    final uri = Uri.parse(urlString);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Could not open the registration link.')),
        );
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
        home: Scaffold( 
      body: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        future: FirebaseFirestore.instance.collection(AppConstants.eventsCollection).doc(eventId).get(),
        builder: (context, snapshot) {
          // A: While loading from database
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          // B: If there's an error or document doesn't exist
          if (snapshot.hasError || !snapshot.hasData || !snapshot.data!.exists) {
            return const Center(
              child: Text(
                'Event not found or has been deleted.',
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
            );
          }

          // C: Document successfully loaded!
          final data = snapshot.data!.data()!;
          final title = data['name'] ?? data['title'] ?? 'Untitled Event';
          final description = data['description'] ?? 'No description provided.';
          final photoUrl = data['photoUrl'] as String?;
          final googleFormLink = data['googleFormLink'] as String?;
          final Timestamp? dateTimestamp = data['eventDate'] as Timestamp?;
          
          final dateString = dateTimestamp != null
              ? DateFormat('EEEE, dd MMMM yyyy').format(dateTimestamp.toDate())
              : 'Date not set';
              
              
          return Padding(
              padding: EdgeInsetsGeometry.all(15),
              child:  Container(
                padding: EdgeInsets.all(35),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColors.eventsBackground,
                  borderRadius: BorderRadius.circular(20)
                ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (photoUrl != null && photoUrl.isNotEmpty)
                        Image.network(
                          photoUrl,
                          height: 300,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => Container(
                            height: 200,
                            color: Colors.grey.shade200,
                            child: const Center(
                              child: Icon(Icons.broken_image, size: 50, color: Colors.grey),
                            ),
                          ),
                        ),

                  Text(
                    title,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,  color: AppColors.eventsHeading),
                  ),

                  Text(
                    description,
                    style: TextStyle(fontSize: 15, color: AppColors.eventsDescription),
                  ),

                  Text(
                    'Conudcted by-',
                    style: TextStyle(fontSize: 10, color: AppColors.eventsConducted),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [

                    ],
                  ),

                  const Icon(Icons.calendar_today, size: 16, color: Colors.blueAccent),
                                const SizedBox(width: 8),
                                Text(
                                  dateString,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blueAccent,
                                  ),
                                ),

                  if (googleFormLink != null && googleFormLink.isNotEmpty)
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton.icon(
                                  onPressed: () => _openGoogleForm(context, googleFormLink),
                                  icon: const Icon(Icons.open_in_new),
                                  label: const Text('Open Registration Form'),
                                  style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(vertical: 16),
                                  ),
                                ),
                              ),

                ],
              )


            ),
          );
          }
        )
      )
    );
    
  }
}
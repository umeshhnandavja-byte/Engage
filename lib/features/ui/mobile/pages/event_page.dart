import 'package:engage/core/constants/app_constants.dart';
import 'package:engage/features/ui/mobile/pages/quiz_page.dart';
import 'package:flutter/material.dart';
import '../../../../core/theme/colors.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class EventPage extends StatefulWidget{
  final String eventId;
  const EventPage ({super.key, required this.eventId});

  @override
  State<EventPage> createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> with WidgetsBindingObserver{
  bool _isFormOpen = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed && _isFormOpen) {
      _isFormOpen = false;
      
      if (!mounted) return;
      _showWelcomeBackDialog(); 
    }
  }

  Future<void> _openGoogleForm(BuildContext context, String? urlString) async {
    if (urlString == null || urlString.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No Google Form registration link attached.')),
      );
      return;
    }

    final uri = Uri.parse(urlString);
    if (await canLaunchUrl(uri)) {
      _isFormOpen = true;
      await launchUrl(uri, mode: LaunchMode.inAppBrowserView);
    } else {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Could not open the registration link.')),
        );
      }
    }
  }

  void _showWelcomeBackDialog() {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Confirm!'),
          content: const Text('Confirm your Form'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: const Text('No'),
            ),
            ElevatedButton(
              onPressed: () async{
                Navigator.of(dialogContext).pop();
                final user = FirebaseAuth.instance.currentUser;
                if (user == null) return;

                final db = FirebaseFirestore.instance;

                final eventRef = db.collection(AppConstants.eventsCollection).doc(widget.eventId);
                DocumentSnapshot eventName = await db.collection(AppConstants.eventsCollection).doc(widget.eventId).get();
                
                await db.collection(AppConstants.usersCollection).doc(user.uid).set({
                  'eventsRegisteredCount': FieldValue.increment(1),
                }, SetOptions(merge: true));

                final userRegisteredEventRef = db
                    .collection(AppConstants.usersCollection)
                    .doc(user.uid)
                    .collection(AppConstants.userRegistered)
                    .doc(widget.eventId);

                try {
                  final batch = db.batch();

                  batch.set(userRegisteredEventRef, {
                    'eventId': widget.eventId,
                    'name': eventName.get('name'), 
                    'timestamp': FieldValue.serverTimestamp(),
                  });

                  batch.update(eventRef, {
                    'registeredCount': FieldValue.increment(1),
                  });

                  final eventParticipantRef = eventRef.collection('participants').doc(user.uid);
                  batch.set(eventParticipantRef, {
                    'name' : user.displayName,
                    'email': user.email,
                    'timestamp': FieldValue.serverTimestamp(),
                  });

                  await batch.commit();

                } catch (e) {
                  print('Error saving registration: $e');
                }
              },
              child: const Text('Yes, I confirm!'),
            ),
          ],
        );
      },
    );
  }
  
  @override
  Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(),
        body: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        future: FirebaseFirestore.instance.collection(AppConstants.eventsCollection).doc(widget.eventId).get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError || !snapshot.hasData || !snapshot.data!.exists) {
            return const Center(
              child: Text(
                'Event not found or has been deleted.',
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
            );
          }

          final data = snapshot.data!.data()!;
          final title = data['name'] ?? data['title'] ?? 'Untitled Event';
          final shortDescription = data['shortDescription'] ?? 'No description provided.';
          final longDescription = data['longDescription'] ?? 'No description provided.';
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
                    shortDescription,
                    style: TextStyle(fontSize: 15, color: AppColors.eventsDescription),
                  ),
                  
                  Text(
                    longDescription,
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

                 ElevatedButton(
                  onPressed: (){
                    Navigator.push(
                      context, 
                      MaterialPageRoute(
                        builder: (context) => QuizPage(quizId: widget.eventId)
                      ) 
                    );
                  },
                  child: Text('Quiz')
                  )

                ],
              )


            ),
          );
          }
        )
        
      );
    
  }
}

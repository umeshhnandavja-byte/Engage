import 'package:engage/core/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class NewEventPage extends StatefulWidget {
  const NewEventPage({super.key});

  @override
  State<NewEventPage> createState() => _NewEventPageState();
}

class _NewEventPageState extends State<NewEventPage> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _shortdescriptionController = TextEditingController();
  final _longdescriptionController = TextEditingController();
  final _googleFormLinkController = TextEditingController();

  DateTime? _eventDate;
  TimeOfDay? _startTime;
  TimeOfDay? _endTime;

  bool _isPublishing = false;

  Uint8List? _selectedImageBytes;
  String? _selectedImageName;

  @override
  void dispose() {
    _nameController.dispose();
    _shortdescriptionController.dispose();
    _longdescriptionController.dispose();
    _googleFormLinkController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final XFile? file = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 85,
    );

    if (file != null) {
      final bytes = await file.readAsBytes();
      setState(() {
        _selectedImageBytes = bytes;
        _selectedImageName = file.name;
      });
    }
  }

  Future<void> _pickDate() async{
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context, 
      initialDate: _eventDate ?? now,
      firstDate: now,
      lastDate: DateTime(now.year + 2),
    );
    if(picked != null){
      setState(() {
        _eventDate = picked;
      });
    }
  }

  Future<void> _pickTime({required bool isStart}) async{
    final picked = await showTimePicker(
      context: context, 
      initialTime: TimeOfDay.now(),
    );
    if(picked != null){
      setState(() {
        if(isStart){
          _startTime = picked;
        }else{
          _endTime = picked;
        }
      });
    }
  }

  String? _validateGoogleForm(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter the Google Form link';
    }
    final uri = Uri.tryParse(value.trim());
    if (uri == null || !uri.hasScheme || (!value.contains('forms.gle') && !value.contains('forms.google.com') && !value.contains('docs.google.com/forms'))) {
      return 'Please enter a valid Google Form URL (e.g., https://forms.gle/...)';
    }
    return null;
  }

  Future<void> _publishEvent() async{
    if (!_formKey.currentState!.validate()) return ;

    if(_eventDate == null || _startTime == null || _endTime == null){
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please Select Date and Both times.')),
      );
      return ;  
    }

    final user = FirebaseAuth.instance.currentUser;
    if(user == null) return;

    setState(() {
      _isPublishing = true;
    });

    try{
      String uploadImageUrl = '';

      if (_selectedImageBytes != null) {
        final supabase = Supabase.instance.client;
        final cleanFileName = _selectedImageName?.replaceAll(' ', '_') ?? 'poster.jpg';
        final filePath = 'banners/${DateTime.now().millisecondsSinceEpoch}_$cleanFileName';

        // Upload raw bytes directly to the Supabase public bucket
        await supabase.storage.from(AppConstants.eventImagesBucket).uploadBinary(
              filePath,
              _selectedImageBytes!,
              fileOptions: const FileOptions(
                contentType: 'image/jpeg',
                upsert: true,
              ),
            );

        // Retrieve the public HTTPS image URL
        uploadImageUrl = supabase.storage.from(AppConstants.eventImagesBucket).getPublicUrl(filePath);
      }

      final startDateTime = DateTime(
        _eventDate!.year, _eventDate!.month, _eventDate!.day, 
        _startTime!.hour, _startTime!.minute,
      );
      
      final endDateTime = DateTime(
        _eventDate!.year, _eventDate!.month, _eventDate!.day, 
        _endTime!.hour, _endTime!.minute,
      );

      await FirebaseFirestore.instance.collection(AppConstants.eventsCollection).add({
        'name': _nameController.text.trim(),
        'shortDescription': _shortdescriptionController.text.trim(),
        'longDescription': _longdescriptionController.text.trim(),
        'photoUrl': uploadImageUrl,
        'googleFormLink': _googleFormLinkController.text.trim(),
        'startDateTIme': Timestamp.fromDate(startDateTime),
        'endDateTIme': Timestamp.fromDate(endDateTime),
        'createdAt': FieldValue.serverTimestamp(),

        'registeredCount': 0,
        'registeredUsers': [],
        
        'organiserId': user?.uid, 
        'organiserName': user?.displayName ?? 'Organiser',
        'organiserEmail': user?.email ?? '',
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Event published live!')),
        );
        Navigator.pop(context);
      }
    }catch(e){
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to publish: $e')),
        );
      }
    }finally {
      if (mounted) {
        setState(() => _isPublishing = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),

      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(10),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                
                GestureDetector(
                    onTap: _pickImage,
                    child: Container(
                      height: 180,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey.shade300, width: 1.5),
                      ),
                      child: _selectedImageBytes != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Stack(
                                fit: StackFit.expand,
                                children: [
                                  Image.memory(
                                    _selectedImageBytes!,
                                    fit: BoxFit.cover,
                                  ),
                                  Positioned(
                                    bottom: 8,
                                    right: 8,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                      decoration: BoxDecoration(
                                        color: Colors.black54,
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      child: const Text(
                                        'Change Photo',
                                        style: TextStyle(color: Colors.white, fontSize: 12),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.add_photo_alternate_outlined, size: 50, color: Colors.grey.shade600),
                                const SizedBox(height: 8),
                                Text(
                                  'Click to select Event Photo / Poster',
                                  style: TextStyle(color: Colors.grey.shade700, fontWeight: FontWeight.w500),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'JPG, PNG (Max 5MB)',
                                  style: TextStyle(color: Colors.grey.shade500, fontSize: 12),
                                ),
                              ],
                            ),
                    ),
                  ),

                  const SizedBox(height: 10),
                
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Event Name *',
                    prefixIcon: Icon(Icons.title),
                    border: OutlineInputBorder()
                  ),
                  validator: (val) => (val == null || val.trim().isEmpty)
                    ? 'Event Name is Required'
                    : null,
                ),

                const SizedBox(height: 10),

              
                TextFormField(
                  controller: _longdescriptionController,
                  decoration: const InputDecoration(
                    labelText: 'Event Description *',
                    alignLabelWithHint: true,
                    prefixIcon: Icon(Icons.description),
                    border: OutlineInputBorder(),
                  ),
                  validator: (val) => (val == null || val.trim().isEmpty)
                      ? 'Event description is required'
                      : null,
                ),

                const SizedBox(height: 10),
                
                TextFormField(
                  controller: _googleFormLinkController,
                  decoration: const InputDecoration(
                    labelText: 'Google Form Registration Link *',
                    hintText: 'https://forms.gle/...',
                    prefixIcon: Icon(Icons.link),
                    border: OutlineInputBorder(),
                  ),
                  validator: _validateGoogleForm,
                ),
                
                const SizedBox(height: 10),

                
                OutlinedButton.icon(
                  onPressed: _pickDate,
                  icon: const Icon(Icons.calendar_month),
                  label: Text(
                    _eventDate == null
                        ? 'Select Event Date *'
                        : 'Event Date: ${_eventDate!.day}/${_eventDate!.month}/${_eventDate!.year}',
                  ),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    alignment: Alignment.centerLeft,
                  ),
                ),

                const SizedBox(height: 10),
                
                OutlinedButton.icon(
                  onPressed: _pickDate,
                  icon: const Icon(Icons.calendar_month),
                  label: Text(
                    _eventDate == null
                        ? 'Select Event Date *'
                        : 'Event Date: ${_eventDate!.day}/${_eventDate!.month}/${_eventDate!.year}',
                  ),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    alignment: Alignment.centerLeft,
                  ),
                ),

                const SizedBox(height: 10),

                
                ElevatedButton(
                  onPressed: _isPublishing ? null : _publishEvent,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: _isPublishing
                      ? const SizedBox(
                          width: 22,
                          height: 22,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Text(
                          'Publish Event',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                ),
              ],
            )
          ),
        ),
      ),
    );
  }
}

//Check The Code once again
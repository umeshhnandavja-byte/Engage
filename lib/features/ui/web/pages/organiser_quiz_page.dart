import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:engage/core/constants/app_constants.dart';
import 'package:flutter/material.dart';

class OrganiserQuizPage extends StatefulWidget{
  final String quizId;
  const OrganiserQuizPage({super.key, required this.quizId});

  @override
  State<OrganiserQuizPage> createState() => _OrganiserQuizPageState(); 
}

class _OrganiserQuizPageState extends State<OrganiserQuizPage>{
  final _questionController = TextEditingController();

  final List<TextEditingController> _optionController = List.generate(4, (_) => TextEditingController());

  int _correctAnswer = 0;
  bool _isSaving = false;

  Future<void> _saveQuestion() async {
    if(_questionController.text.isEmpty ||
      _optionController.any((c) => c.text.isEmpty)){
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please Fill all fields'))
        );
        return;
    }

    setState(() {
      _isSaving = true;
    });

    try{
      final List<String> optionsText = _optionController.map((c) => c.text.trim()).toList();

      await FirebaseFirestore.instance.collection(AppConstants.quizesCollection).doc(widget.quizId).collection(AppConstants.questionsCollection).add({
        'question': _questionController.text.trim(),
        'options': optionsText,
        'correctAnswer':  _correctAnswer,
        'createdAt': FieldValue.serverTimestamp(),
      });

      _questionController.clear();

      for(var c in _optionController){
        c.clear();
      }

      setState(() {
        _correctAnswer = 0;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Question added! Add another.')),
      );

    }catch(e){
      print('Error Saving question: $e');
    }finally{
      setState(() {
        _isSaving = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            TextField(
              controller: _questionController,
              decoration: const InputDecoration(
                labelText: 'Question',
                border: OutlineInputBorder()
              ),
            ),

            const SizedBox(height: 10,),

            ...List.generate(4, (index){
              return Padding(
                padding: EdgeInsetsGeometry.all(10),
                child: TextField(
                  controller: _optionController[index],
                  decoration: InputDecoration(
                    labelText: 'Option',
                    border: OutlineInputBorder()
                  ),
                ),
              );
            }),

            const SizedBox(height: 10,),

            DropdownButtonFormField<int>(
              value: _correctAnswer,
              decoration: InputDecoration(
                labelText: 'Choose correct option',
                border: OutlineInputBorder()
              ),
              items: const [
                DropdownMenuItem(value: 0, child: Text('Option 1')),
                DropdownMenuItem(value: 1, child: Text('Option 2')),
                DropdownMenuItem(value: 2, child: Text('Option 3')),
                DropdownMenuItem(value: 3, child: Text('Option 4')),

              ], 
              onChanged: (val){
                if(val != null){
                  setState(() {
                    _correctAnswer = val;
                  });
                }
              }
              ),

              const SizedBox(height: 10,),

              ElevatedButton(
                onPressed: _isSaving ? null : _saveQuestion,
                child: _isSaving
                      ? const CircularProgressIndicator()
                      : const Text('Save')
              ),

          ],
          
        ),
      ),
    );
  }
}
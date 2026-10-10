import 'package:engage/core/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class QuizPage extends StatefulWidget{
  final String quizId;
  const QuizPage({super.key, required this.quizId});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage>{
  int _currentAnswer = 0;
  int _score = 0;
  bool _isAnswered = false;
  int? _selectedAnswer;

  void _submitAnswer(int selectedOption, int correctAnswer, int totalQuestions) async{
    if (_isAnswered) return;

    setState(() {
      _isAnswered = true;
      _selectedAnswer = selectedOption;
      if(_selectedAnswer == correctAnswer) _score++;
    });

    await Future.delayed(const Duration(milliseconds: 150));

    if(!mounted) return;

    setState(() {
      _currentAnswer++;
      _isAnswered = false;
      _selectedAnswer = null;
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
        .collection(AppConstants.quizesCollection)
        .doc(widget.quizId)
        .collection(AppConstants.questionsCollection)
        .orderBy('createdAt')
        .snapshots(), 
        builder: (context, snapshot){
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('Waiting for Organiser to add questions...'));
          }

          final questions = snapshot.data!.docs;

          if (_currentAnswer >= questions.length) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Quiz Complete!', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),
                  Text('Your Score: $_score / ${questions.length}', style: const TextStyle(fontSize: 22)),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context), 
                    child: const Text('Finish'),
                  )
                ],
              ),
            );
          }

          final currentQuestionData = questions[_currentAnswer].data() as Map<String, dynamic>;
          final String questionText = currentQuestionData['question'] ?? 'Loading question...';
          final List<dynamic> options = currentQuestionData['options'] ?? ['Option 1', 'Option 2', 'Option 3', 'Option 4'];
          final int correctIndex = (currentQuestionData['correctAnswer'] as num?)?.toInt() ?? 0;

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text('Question ${_currentAnswer + 1} of ${questions.length}', 
                     style: const TextStyle(fontSize: 16, color: Colors.grey)),
                const SizedBox(height: 20),
                Text(questionText, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                const SizedBox(height: 30),

                ...List.generate(options.length, (index) {
                  Color buttonColor = Colors.white;
                  if (_isAnswered) {
                    if (index == correctIndex) {
                      buttonColor = Colors.green.shade300; 
                    } else if (index == _selectedAnswer) {
                      buttonColor = Colors.red.shade300; 
                    }
                  }

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: buttonColor,
                        padding: const EdgeInsets.all(16),
                        alignment: Alignment.centerLeft,
                      ),
                      onPressed: () => _submitAnswer(index, correctIndex, questions.length),
                      child: Text(
                        options[index],
                        style: const TextStyle(fontSize: 16, color: Colors.black),
                      ),
                    ),
                  );
                }),
              ],
            ),
          );
        }
      ),
    );
  }
}
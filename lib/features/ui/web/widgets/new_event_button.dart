import 'package:flutter/material.dart';
import '../../../../core/theme/colors.dart';

class NewEventButton extends StatelessWidget{
  const NewEventButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.large(
      backgroundColor: AppColors.addEventButtonBackground,
      child: Icon(Icons.add, size: 36),
      onPressed: (){},
    );
  }
}
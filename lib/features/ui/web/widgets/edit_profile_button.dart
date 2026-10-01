import 'package:flutter/material.dart';
import '../../../../core/theme/colors.dart';

class EditOrganiserProfileButton extends StatelessWidget{
  const EditOrganiserProfileButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.large(
      backgroundColor: AppColors.editEventButtonBackground,
      child: Icon(Icons.edit, size: 36),
      onPressed: (){},
    );
  }
}
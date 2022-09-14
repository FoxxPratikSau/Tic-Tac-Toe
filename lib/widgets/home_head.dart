import 'package:flutter/material.dart';
class HomeHead extends StatelessWidget {
  const HomeHead({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text("Tic Tac Toe",style: TextStyle(
          color: Colors.black26,
          fontSize: 33,
          fontWeight: FontWeight.w600,
          
        ),),
        
      ],
    );
  }
}
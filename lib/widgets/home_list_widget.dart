import 'package:flutter/material.dart';

class HomeListWidget extends StatelessWidget {
  final String subject;

  const HomeListWidget({
    super.key,
    required this.subject,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.black,
            width: 2,
          ),
        ),
      ),
      child: Center(
        child: Text(
          subject,
          style: const TextStyle(
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}

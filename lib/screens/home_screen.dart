import 'package:english/models/constants.dart';
import 'package:english/screens/detail_screen.dart';
import 'package:english/widgets/home_list_widget.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
  });

  Route createRoute(String suject) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => DetailScreen(
        subject: suject,
      ),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Center(
          child: Text(
            "My English",
            style: TextStyle(
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
        backgroundColor: Colors.grey.shade100,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.of(context)
                  .push(createRoute(Constants.collectionWords));
            },
            child: const HomeListWidget(
              subject: Constants.collectionWords,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context)
                  .push(createRoute(Constants.collectionSentences));
            },
            child: const HomeListWidget(
              subject: Constants.collectionSentences,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.grey,
          onPressed: () {},
          child: const Icon(
            Icons.add,
            color: Colors.white,
          )),
    );
  }
}

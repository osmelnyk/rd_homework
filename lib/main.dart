import 'package:flutter/material.dart';
import 'utils/themes.dart';
import 'lesson8/lesson_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cocktail Master',
      theme: lightTheme,
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const LessonScreen8()),
                );
              },
              child: const Text('Go to Lesson 8'),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

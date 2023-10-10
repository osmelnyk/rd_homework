import 'package:flutter/material.dart';
import 'lesson9/lesson_screen.dart';
import 'utils/themes.dart';
import 'lesson8/lesson_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lessons RD App',
      theme: lightTheme,
      debugShowCheckedModeBanner: false,
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
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const LessonScreen9()),
                );
              },
              child: const Text('Go to Lesson 9'),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

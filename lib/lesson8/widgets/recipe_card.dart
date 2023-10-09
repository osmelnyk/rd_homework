import 'package:flutter/material.dart';
import '../model/model.dart';
import 'time_container.dart';

// Custom recipe card widget
// isList cheks if List or Grid selected
class RecipeCard extends StatelessWidget {
  final Recipe recipe;
  final bool isList;

  const RecipeCard({
    Key? key,
    required this.recipe,
    this.isList = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      // Round Image corners as in Card
      clipBehavior: Clip.antiAliasWithSaveLayer,
      // InkWell for Tap ripple effect
      child: Ink(
        child: InkWell(
          onTap: () {
            _showDialog(context);
          },
          child: isList
              // List View
              ? listViewCard()
              // Grid View
              : gridViewCard(),
        ),
      ),
    );
  }

  Column gridViewCard() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          recipe.image,
          height: 170,
          fit: BoxFit.fitWidth,
        ),
        Text(
          recipe.name,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        TimeContainer(recipe: recipe),
      ],
    );
  }

  Row listViewCard() {
    return Row(
      children: [
        Image.asset(
          recipe.image,
          height: 120,
          width: 120,
          fit: BoxFit.fitHeight,
        ),
        const SizedBox(width: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              recipe.name,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            TimeContainer(recipe: recipe),
          ],
        ),
      ],
    );
  }

// Dialog for recipe details and instructions
  void _showDialog(BuildContext context) {
    showGeneralDialog(
      context: context,
      pageBuilder: (context, animation1, animation2) {
        return Material(
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                  ),
                  Image.asset(recipe.image),
                  const SizedBox(height: 16),
                  Center(
                    child: TimeContainer(recipe: recipe),
                  ),
                  Text(recipe.description),
                ],
              ),
            ),
          ),
        );
      },
      // Animation when dialog is shown from bottom
      transitionBuilder: (context, a1, a2, widget) {
        return SlideTransition(
          position: Tween(begin: const Offset(0, 1), end: const Offset(0, 0))
              .animate(a1),
          child: widget,
        );
      },
      transitionDuration: const Duration(milliseconds: 300),
    );
  }
}

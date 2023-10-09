import 'package:flutter/material.dart';
import 'model/model.dart';
import 'data/data.dart';
import 'widgets/recipe_card.dart';

class LessonScreen8 extends StatefulWidget {
  const LessonScreen8({super.key});

  @override
  State<LessonScreen8> createState() => _LessonScreen8State();
}

class _LessonScreen8State extends State<LessonScreen8> {
  final List<Recipe> _recipes = RecipeProvider().getRecipes();

  bool _isListView = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('Cocktail Master'),
        ),
      ),
      body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: _isListView ? listView() : gridView()),
      floatingActionButton: FloatingActionButton(
        // Display Grid or List Icon
        child: _isListView ? const Icon(Icons.grid_on) : const Icon(Icons.list),
        onPressed: () {
          setState(() {
            _isListView = !_isListView;
          });
        },
      ),
    );
  }

  GridView gridView() {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 15,
        crossAxisSpacing: 15,
        childAspectRatio: 0.90,
      ),
      shrinkWrap: true,
      itemCount: _recipes.length,
      itemBuilder: (context, index) {
        final recipe = _recipes[index];
        // Removing recipe by slide on Grid Item
        return Dismissible(
          key: Key(recipe.name),
          onDismissed: (direction) {
            setState(() {
              _recipes.removeAt(index);
            });
          },
          background: Container(
            color: Colors.red,
            child: const Icon(
              Icons.delete,
              color: Colors.white,
            ),
          ),
          child: RecipeCard(recipe: recipe, isList: false),
        );
      },
    );
  }

  ListView listView() {
    return ListView(
      children: _recipes.map((Recipe recipe) {
        return Dismissible(
          key: Key(recipe.name),
          // Removing recipe by slide on List Item
          onDismissed: (direction) {
            setState(() {
              _recipes.remove(recipe);
            });
          },
          background: Container(
            color: Colors.red,
            child: const Padding(
              padding: EdgeInsets.all(15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(Icons.delete, color: Colors.white),
                  SizedBox(
                    width: 8.0,
                  ),
                ],
              ),
            ),
          ),
          child: RecipeCard(recipe: recipe),
        );
      }).toList(),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cocktail Master',
      theme: lightTheme,
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
          child: _isListView
              ? ListView(
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
                )
              : GridView.builder(
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
                )),
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
}

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
              ? Row(
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
                )
              // Grid View
              : Column(
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
                ),
        ),
      ),
    );
  }

  // Dialog for recipe details and instructions
  void _showDialog(BuildContext context) {
    showGeneralDialog(
      context: context,
      pageBuilder: (context, animation1, animation2) {
        return Material(
          child: Container(
            width: MediaQuery.of(context).size.width - 10,
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

// Container for recipe time
class TimeContainer extends StatelessWidget {
  const TimeContainer({
    super.key,
    required this.recipe,
  });

  final Recipe recipe;

  @override
  Widget build(BuildContext context) {
    return Wrap(children: [
      const Icon(
        Icons.access_alarm_outlined,
        size: 18,
      ),
      const SizedBox(width: 3),
      Text(recipe.time.toString()),
    ]);
  }
}

class Recipe {
  final String name;
  final String image;
  final String description;
  final int time;

  Recipe(this.name, this.image, this.time, this.description);
}

class RecipeProvider {
  List<Recipe> getRecipes() {
    return [
      Recipe(
        'Маргарита',
        'assets/images/margarita.jpg',
        5,
        '''Інгредієнти:
        50 мл текіли
        30 мл апельсинового лікеру (наприклад, Cointreau)
        20 мл лимонного соку
        Лід
        Сіль для обрубки склянки

Приготування: Змочіть край склянки лимонним соком і обірвіть в сіль. Змішайте текілу, апельсиновий лікер і лимонний сік в шейкері з льодом. Потім процідіть у підготовлену склянку.''',
      ),
      Recipe(
        'Негроні',
        'assets/images/negroni.jpg',
        5,
        '''Інгредієнти:
    30 мл джину
    30 мл біттера Кампарі
    30 мл вермуту (наприклад, Martini Rosso)
    Апельсинова цедра або апельсиновий шматочок для гарніру
    Лід

Приготування:

    Наповніть келишок для коктейлю льодом.
    Додайте джин, біттер Кампарі і вермут у келишок.
    Помішайте інгредієнти ложкою.
    Виразьте апельсиновий шматочок над коктейлем так, щоб ароматний олійний спрій розповсюдився на поверхні напою, і додайте цедру або апельсиновий шматочок для гарніру.''',
      ),
      Recipe(
        'Космополітен',
        'assets/images/cosmopolitan.jpg',
        5,
        '''Інгредієнти:
        45 мл водки
        15 мл апельсинового лікеру (наприклад, Triple Sec)
        30 мл клюквеного соку
        15 мл лаймового соку
        Лід

Приготування: Змішайте всі інгредієнти в шейкері з льодом і процідіть у келишок для коктейлю.''',
      ),
      Recipe(
        'Піна Колада',
        'assets/images/pina-kolada.jpg',
        5,
        '''Інгредієнти:
        60 мл білої рому
        90 мл ананасового соку
        60 мл кокосового молока або кокосового крему
        Лід

Приготування: Змішайте всі інгредієнти в блендері з льодом та зберіть до однорідності. Подавайте зі стружкою кокоса або кількома шматочками ананаса.''',
      ),
      Recipe(
        'Мартіні',
        'assets/images/martini.jpg',
        3,
        '''Інгредієнти:
        60 мл джину
        15 мл вермуту
        Лід
        Оливки або лимонна цедра для гарніру

Приготування: Змішайте джин та вермут в келишку для мартіні з льодом. Перед подачею прикрасьте оливками або цедрою лимона.''',
      ),
      Recipe(
        'Мохіто',
        'assets/images/moxito.jpg',
        5,
        '''Інгредієнти:
        50 мл білої рому
        30 мл свіжого лаймового соку
        2 чайні ложки цукру
        6-8 м'яти листків
        Лід
        Содова вода

Приготування: В склянці розтрити м'яту з цукром і лаймовим соком. Додайте ром та лід. Завершіть напій содовою водою.''',
      ),
    ];
  }
}

// Theme data for light Theme
ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  useMaterial3: true,
  textTheme: const TextTheme(
    displayLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
    bodyLarge: TextStyle(fontSize: 18, color: Colors.black87),
  ),
  appBarTheme: AppBarTheme(
    titleTextStyle: TextStyle(
      fontFamily: GoogleFonts.fasthand(
        fontWeight: FontWeight.w700,
        fontStyle: FontStyle.italic,
      ).fontFamily,
      fontSize: 36,
      color: const Color.fromARGB(237, 254, 254, 254),
    ),
    color: const Color.fromARGB(255, 73, 159, 229),
    iconTheme: const IconThemeData(color: Colors.white),
  ),
  colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
);

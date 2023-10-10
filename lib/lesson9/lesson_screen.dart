import 'package:flutter/material.dart';
import 'model/model.dart';
import 'data/data.dart';
import 'screens/art_detailed_screen.dart';
import 'widgets/artist_drawer.dart';

class LessonScreen9 extends StatefulWidget {
  const LessonScreen9({super.key});

  @override
  State<LessonScreen9> createState() => _LessonScreen9State();
}

class _LessonScreen9State extends State<LessonScreen9> {
  List<Artwork> artworks = Artwork.filterByArtist(ArtProvider().getArt(), '');
  // Set Key to find Drawer
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  void _onTapCallback(String artist) {
    setState(() {
      artworks = Artwork.filterByArtist(ArtProvider().getArt(), artist);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            actions: <Widget>[
              IconButton(
                icon: const Icon(Icons.filter_list),
                onPressed: () {
                  // Show the drawer when the filter button is pressed
                  _scaffoldKey.currentState?.openEndDrawer();
                },
              ),
            ],
            expandedHeight: 200,
            flexibleSpace: const FlexibleSpaceBar(
              title: Text('Artworks'),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final artwork = artworks[index];
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ArtDetailedScreen(artwork: artwork),
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      color: Colors.grey[200],
                      alignment: Alignment.center,
                      child: Column(children: [
                        Image.asset(
                          artwork.image,
                          height: 170,
                          fit: BoxFit.fitWidth,
                        ),
                        Text(
                          artwork.artist,
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(artwork.title),
                      ]),
                    ),
                  );
                },
                childCount: artworks.length,
              ),
            ),
          ),
        ],
      ),
      endDrawer: ArtistDrawer(onTapCallback: _onTapCallback),
    );
  }
}

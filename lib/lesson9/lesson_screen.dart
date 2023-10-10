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
  // Set the initial value of the selected artist
  int selectedArtist = 0;
  // Set Key to find Drawer
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  void _onTapCallback(String artist, int index) {
    setState(() {
      artworks = Artwork.filterByArtist(ArtProvider().getArt(), artist);
      selectedArtist = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: LayoutBuilder(builder: (_, constraints) {
        return CustomScrollView(
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
              sliver: (constraints.maxWidth > 700) ? gridView() : listView(),
            ),
          ],
        );
      }),
      endDrawer: ArtistDrawer(
          onTapCallback: _onTapCallback, selectedArtist: selectedArtist),
    );
  }

  Widget listView() {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (_, index) {
          final artwork = artworks[index];
          return Ink(
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ArtDetailedScreen(artwork: artwork),
                  ),
                );
              },
              child: Container(
                margin: const EdgeInsets.all(5),
                child: Card(
                  clipBehavior: Clip.antiAlias,
                  child: Row(
                    children: [
                      Image.asset(
                        artwork.image,
                        width: 200,
                        fit: BoxFit.fitWidth,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              artwork.artist,
                              style:
                                  const TextStyle(fontWeight: FontWeight.w700),
                            ),
                            Text(artwork.title),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
        childCount: artworks.length,
      ),
    );
  }

  Widget gridView() {
    return SliverGrid(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: (MediaQuery.of(context).size.width / 3.3) /
              (MediaQuery.of(context).size.height / 3.6)),
      delegate: SliverChildBuilderDelegate(
        (_, index) {
          final artwork = artworks[index];
          return Ink(
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ArtDetailedScreen(artwork: artwork),
                  ),
                );
              },
              child: Container(
                margin: const EdgeInsets.all(5),
                child: Card(
                  clipBehavior: Clip.antiAlias,
                  child: Column(children: [
                    Image.asset(
                      artwork.image,
                      height: 150,
                      fit: BoxFit.fitHeight,
                    ),
                    Text(
                      artwork.artist,
                      style: const TextStyle(fontWeight: FontWeight.w700),
                    ),
                    Text(artwork.title),
                  ]),
                ),
              ),
            ),
          );
        },
        childCount: artworks.length,
      ),
    );
  }
}

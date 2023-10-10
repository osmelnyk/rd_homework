import 'package:flutter/material.dart';
import '../data/data.dart';
import '../model/model.dart';

class ArtistDrawer extends StatefulWidget {
  const ArtistDrawer({
    super.key,
    required this.onTapCallback,
    required this.selectedArtist,
  });
  final Function(String, int) onTapCallback;
  final int selectedArtist;

  @override
  State<ArtistDrawer> createState() => _ArtistDrawerState();
}

class _ArtistDrawerState extends State<ArtistDrawer> {
  final List<String> artists = Artwork.getAllArtists(ArtProvider().getArt());
  final String _address = '''
(845) 561-5224
77 Ann St
Newburgh, New York(NY), 12550''';

  @override
  Widget build(BuildContext _) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Colors.blue,
            ),
            child: Column(
              children: [
                const Text(
                  'Gold Gallery',
                  style: TextStyle(color: Colors.white, fontSize: 24),
                ),
                const SizedBox(height: 10),
                Text(
                  _address,
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
              ],
            ),
          ),
          Column(
            children: [
              ListTile(
                title: Text('All'),
                tileColor: (widget.selectedArtist == 0)
                    ? Colors.blue.shade200
                    : Colors.white,
                onTap: () {
                  widget.onTapCallback('', 0);
                },
              ),
              SizedBox(
                height: double.maxFinite,
                child: ListView.builder(
                    itemCount: artists.length,
                    itemBuilder: (_, index) {
                      return ListTile(
                        title: Text(artists[index]),
                        tileColor: (widget.selectedArtist == index + 1)
                            ? Colors.blue.shade200
                            : Colors.white,
                        onTap: () {
                          widget.onTapCallback(artists[index], index + 1);
                        },
                      );
                    }),
              ),
            ],
          )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../data/data.dart';
import '../model/model.dart';

class ArtistDrawer extends StatefulWidget {
  const ArtistDrawer({super.key, required this.onTapCallback});
  final Function(String) onTapCallback;

  @override
  State<ArtistDrawer> createState() => _ArtistDrawerState();
}

class _ArtistDrawerState extends State<ArtistDrawer> {
  final List<String> artists = Artwork.getAllArtists(ArtProvider().getArt());
  int _selectedArtist = 0;

  @override
  Widget build(BuildContext _) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              'Artists',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),
          Column(
            children: [
              ListTile(
                title: const Text('All'),
                tileColor: (_selectedArtist == 0)
                    ? Colors.blue.shade200
                    : Colors.white,
                onTap: () {
                  widget.onTapCallback('');
                  setState(() {
                    _selectedArtist = 0;
                  });
                },
              ),
              SizedBox(
                height: double.maxFinite,
                child: ListView.builder(
                    itemCount: artists.length,
                    itemBuilder: (_, index) {
                      return ListTile(
                        title: Text(artists[index]),
                        tileColor: (_selectedArtist == index + 1)
                            ? Colors.blue.shade200
                            : Colors.white,
                        onTap: () {
                          widget.onTapCallback(artists[index]);
                          setState(() {
                            _selectedArtist = index + 1;
                          });
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

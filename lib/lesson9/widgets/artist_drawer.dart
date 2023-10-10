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

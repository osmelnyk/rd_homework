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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: List<Widget>.generate(artists.length, (int index) {
                return ChoiceChip(
                  label: Text(artists[index]),
                  selected: widget.selectedArtist == index,
                  onSelected: (_) =>
                      widget.onTapCallback(artists[index], index),
                );
              }),
            ),
          )
        ],
      ),
    );
  }
}

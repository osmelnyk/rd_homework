// Dart SDK version: 3.1.1 (stable)

main() {
  final MusicCollection myPlaylist = MusicCollection('My Playlist', songList);
  // List all songs from playlist
  myPlaylist.printSongs();
  // Filter playlist by artist
  myPlaylist.printSongs(searchString: 'air');
  // Filter playlist by song title
  myPlaylist.printSongs(searchString: 'compute');
}

class Song {
  String artist, title, duration;
  int year;

  Song(this.artist, this.title, this.duration, this.year);
}

extension SongsDurationExtension on List<Song> {
  // Calculate duration of songs
  Duration sumDurations() {
    return map((song) {
      List<String> parts = song.duration.split(':');
      int minutes = int.parse(parts[0]);
      int seconds = int.parse(parts[1]);
      return Duration(minutes: minutes, seconds: seconds);
    }).reduce((v, e) => v + e);
  }
}

// Searching for Artist or Song Title
mixin SearchMixin on Playlist {
  List<Song> find(String searchString) {
    return songs
        .where((song) =>
            song.artist.toLowerCase().contains(searchString.toLowerCase()) ||
            song.title.toLowerCase().contains(searchString.toLowerCase()))
        .toList();
  }
}

class Playlist extends Song {
  final String name;
  final List<Song> songs;

  Playlist(this.name, this.songs) : super('', '', '', 0);
}

class MusicCollection extends Playlist with SearchMixin {
  MusicCollection(super.name, super.songs);

  // Print all songs from Playlist or filter by query
  void printSongs({String? searchString}) {
    //Check if Playlist is empty
    if (songs.isEmpty) {
      print('Playlist "$name" is empty');
      return;
    }
    // If search query is null return all songs
    // or filter playlist
    final List<Song> results =
        searchString == null ? songs : find(searchString);
    if (results.isEmpty && searchString != null) {
      print('No songs found for "$searchString" in "$name"');
    } else {
      searchString == null || searchString.isEmpty
          ? print('Songs in "$name":')
          : print('Songs found for "$searchString" in "$name":');
      int i = 0;
      for (Song song in results) {
        i++;
        print(
            '$i. ${song.artist} - ${song.title} (${song.duration}) ${song.year}');
      }
      // Convert Duration to more readable format
      final totalDurations =
          results.sumDurations().toString().split('.').first.padLeft(8, "0");
      print('Total Duration: $totalDurations \n');
    }
  }
}

final songList = <Song>[
  Song('Kraftwerk', 'Autobahn', '22:43', 1974),
  Song('Kraftwerk', 'The Model', '3:38', 1978),
  Song('Kraftwerk', 'Computer World', '5:06', 1981),
  Song('Kraftwerk', 'Trans Europe Express', '6:36', 1977),
  Song('Kraftwerk', 'Tour de France', '6:44', 1983),
  Song('Plaid', 'Eyen', '5:04', 1991),
  Song('Plaid', 'Ralome', '5:26', 1995),
  Song('Plaid', 'Squance', '6:30', 1997),
  Song('Plaid', 'Wallet', '5:22', 1999),
  Song('Plaid', 'Missing', '4:28', 2003),
  Song('Air', 'Sexy Boy', '4:58', 1998),
  Song('Air', 'La Femme d\'Argent', '7:10', 1998),
  Song('Air', 'Playground Love', '3:32', 2000),
  Song('Air', 'Cherry Blossom Girl', '3:39', 2004),
  Song('Air', 'Alone in Kyoto', '4:51', 2004),
  Song('LCD Soundsystem', 'Dance Yrself Clean', '8:56', 2010),
  Song('LCD Soundsystem', 'Someone Great', '6:26', 2007),
  Song('LCD Soundsystem', 'Losing My Edge', '7:53', 2002),
  Song('LCD Soundsystem', 'All My Friends', '7:37', 2007),
  Song('LCD Soundsystem', 'Tonite', '5:47', 2017),
  Song('Joey Beltram', 'Energy Flash', '5:51', 1990),
  Song('Joey Beltram', 'Mentasm', '4:14', 1991),
  Song('Joey Beltram', 'Game Form', '5:42', 1994),
  Song('Joey Beltram', 'My Sound', '5:22', 1995),
  Song('Joey Beltram', 'Drome', '4:54', 1996)
];

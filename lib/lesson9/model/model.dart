class Artwork {
  final String artist;
  final String title;
  final String description;
  final String image;

  Artwork(
      {required this.image,
      required this.title,
      required this.artist,
      required this.description});

  // Method to filter artworks by artist
  static List<Artwork> filterByArtist(
      List<Artwork> artworks, String artistName) {
    return (artistName != '')
        ? artworks.where((artwork) => artwork.artist == artistName).toList()
        : artworks;
  }

  // Method to get all artists without repeating them
  static List<String> getAllArtists(List<Artwork> artworks) {
    Set<String> uniqueArtists = {};
    for (var artwork in artworks) {
      uniqueArtists.add(artwork.artist);
    }
    return uniqueArtists.toList();
  }
}

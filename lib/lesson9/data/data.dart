import '../model/model.dart';

class ArtProvider {
  List<Artwork> getArt() {
    return [
      Artwork(
        artist: 'Leonardo da Vinci',
        title: 'Mona Lisa',
        image: '../assets/art/mona-lisa.jpg',
        description: 'Mona Lisa is a famous painting by Leonardo da Vinci.',
      ),
      Artwork(
        artist: 'Leonardo da Vinci',
        title: 'The Last Supper',
        image: '../assets/art/last-supper.jpg',
        description:
            'The Last Supper is another masterpiece by Leonardo da Vinci.',
      ),
      Artwork(
        artist: 'Vincent van Gogh',
        title: 'Starry Night',
        image: '../assets/art/starry-night.jpg',
        description: 'Starry Night is a masterpiece by Vincent van Gogh.',
      ),
      Artwork(
        artist: 'Vincent van Gogh',
        title: 'The Sunflowers',
        image: '../assets/art/sunflowers.jpg',
        description: 'The Sunflowers is one of Van Gogh\'s most famous works.',
      ),
      Artwork(
        artist: 'Pablo Picasso',
        title: 'Guernica',
        image: '../assets/art/guernica.jpg',
        description:
            'Guernica is one of Picasso\'s most powerful political artworks.',
      ),
      Artwork(
        artist: 'Pablo Picasso',
        title: 'Les Demoiselles d\'Avignon',
        image: '../assets/art/les-emoiselles-Avignon.jpg',
        description:
            'Les Demoiselles d\'Avignon is a groundbreaking work by Picasso.',
      ),
      Artwork(
        artist: 'Claude Monet',
        title: 'Water Lilies',
        image: '../assets/art/water-lilies.JPG',
        description:
            'Water Lilies series by Claude Monet is iconic in Impressionist art.',
      ),
      Artwork(
        artist: 'Claude Monet',
        title: 'Impression, Sunrise',
        image: '../assets/art/impression-sunrise.jpg',
        description:
            'Impression, Sunrise gave the name to the Impressionist movement.',
      ),
    ];
  }
}

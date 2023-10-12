import 'package:flutter/material.dart';
import '../model/model.dart';

class ArtDetailedScreen extends StatefulWidget {
  final Artwork artwork;
  const ArtDetailedScreen({
    Key? key,
    required this.artwork,
  }) : super(key: key);

  @override
  State<ArtDetailedScreen> createState() => _ArtDetailedScreenState();
}

class _ArtDetailedScreenState extends State<ArtDetailedScreen> {
  bool isDescriptionVisible = false;

  void toggleDescription() {
    setState(() {
      isDescriptionVisible = !isDescriptionVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        forceMaterialTransparency: true,
        actions: [
          IconButton(
            color: Colors.white70,
            icon: const Icon(
              Icons.close,
              color: Colors.white,
            ),
            onPressed: () {
              // Pop screen
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          // Full Screen Image
          InteractiveViewer(
            minScale: 0.1,
            maxScale: 6,
            constrained: false,
            child: Image.asset(
              widget.artwork.image,
              fit: BoxFit.fill,
            ),
          ),
          // Text Description (conditionally)
          if (isDescriptionVisible) artDescription(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: toggleDescription,
        child: Icon(
          isDescriptionVisible ? Icons.visibility_off : Icons.visibility,
        ),
      ),
    );
  }

  Widget artDescription() {
    return Container(
      color: Colors.black.withOpacity(0.7),
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              widget.artwork.artist,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 10.0),
            Text(
              widget.artwork.title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontStyle: FontStyle.italic,
              ),
            ),
            const SizedBox(height: 5.0),
            Text(
              widget.artwork.description,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

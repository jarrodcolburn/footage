import 'package:flutter/widgets.dart';
import 'package:footage/footage.dart';
import 'package:example/scenes/slidedeck.dart';

void main() {
  runVideo(
    const Video(),
    panel: true,
  );
}

class Video extends StatelessWidget {
  const Video({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Composition(
      fps: 30,
      duration: const Time.frames(120),
      width: 1920,
      height: 1080,
      child: const SlideDeckScene(),
    );
  }
}

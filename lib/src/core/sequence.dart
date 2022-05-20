import 'package:flutter/widgets.dart';
import 'package:footage/src/core/time.dart';

import 'config.dart';
import 'context_extensions.dart';
import 'providers.dart';

/// Sequences are small sections in finite time that make up your video clip. By
/// using a sequence, you can time-shift the display of your children.
///
/// When children are reading the configuration and current frame, they are
/// overriden to be relative to this sequence.
class Sequence extends StatelessWidget {
  const Sequence({
    super.key,
    required this.child,
    required this.from,
    this.name,
    this.duration,
  });

  final String? name;
  final Widget child;
  final Time from;
  final Time? duration;

  @override
  Widget build(BuildContext context) {
    final frame = context.video.currentFrame;
    final config = context.video.config;
    final fromInFrames = from.asFrames(config.durationInFrames, config.fps);
    final durationInFrames =
        duration?.asFrames(config.durationInFrames, config.fps) ??
            config.durationInFrames - fromInFrames;

    if (frame >= fromInFrames && frame < fromInFrames + durationInFrames) {
      return VideoConfigProvider(
        config: VideoConfig(
          fps: config.fps,
          durationInFrames: durationInFrames,
          width: config.width,
          height: config.height,
        ),
        child: CurrentFrameProvider(
          frame: (frame - fromInFrames).clamp(0, durationInFrames),
          child: child,
        ),
      );
    }

    return const SizedBox();
  }
}

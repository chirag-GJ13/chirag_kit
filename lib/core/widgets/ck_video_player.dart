import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

/// A reusable, self-contained video player widget.
///
/// Usage:
/// ```dart
/// import 'package:flutter_core_kit/core/widgets/video_player/ck_video_player.dart';
///
/// // Navigate to full-screen player
/// Get.to(() => CKVideoPlayer(videoUrl: 'https://...', title: 'My Video'));
///
/// // Or embed inline
/// CKVideoPlayer(videoUrl: 'https://...', isEmbedded: true)
/// ```
///
/// Dependencies (add to pubspec.yaml):
///   video_player: ^2.x.x
class CKVideoPlayer extends StatefulWidget {
  /// Remote or local video URL.
  final String videoUrl;

  /// Optional title shown in the AppBar (full-screen) or above the player (embedded).
  final String? title;

  /// When [true], renders as an inline widget (no Scaffold/AppBar).
  /// When [false] (default), renders as a full-screen Scaffold page.
  final bool isEmbedded;

  /// Background color. Defaults to [Colors.black].
  final Color backgroundColor;

  /// Color of the progress bar's played portion. Defaults to [Colors.red].
  final Color progressPlayedColor;

  /// Color of the buffered portion. Defaults to [Colors.grey].
  final Color progressBufferedColor;

  /// Size of the play/pause icon. Defaults to 60.
  final double controlIconSize;

  /// Duration after which controls auto-hide while playing.
  final Duration autoHideControlsDuration;

  /// Widget shown while the video is initializing.
  final Widget? loadingWidget;

  const CKVideoPlayer({
    super.key,
    required this.videoUrl,
    this.title,
    this.isEmbedded = false,
    this.backgroundColor = Colors.black,
    this.progressPlayedColor = Colors.red,
    this.progressBufferedColor = Colors.grey,
    this.controlIconSize = 60,
    this.autoHideControlsDuration = const Duration(seconds: 2),
    this.loadingWidget,
  });

  @override
  State<CKVideoPlayer> createState() => _CKVideoPlayerState();
}

class _CKVideoPlayerState extends State<CKVideoPlayer> {
  late VideoPlayerController _controller;
  bool _showControls = true;

  // ─── Lifecycle ────────────────────────────────────────────────────────────

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl))
      ..initialize().then((_) {
        if (mounted) setState(() {});
      });
    _controller.addListener(_onVideoUpdate);
  }

  @override
  void dispose() {
    _controller.removeListener(_onVideoUpdate);
    _controller.dispose();
    super.dispose();
  }

  // ─── Listeners / Helpers ─────────────────────────────────────────────────

  void _onVideoUpdate() {
    if (mounted) setState(() {});
  }

  void _togglePlayPause() {
    if (_controller.value.isPlaying) {
      _controller.pause();
      setState(() => _showControls = true);
    } else {
      _controller.play();
      setState(() => _showControls = false);
      Future.delayed(widget.autoHideControlsDuration, () {
        if (mounted && _controller.value.isPlaying) {
          setState(() => _showControls = false);
        }
      });
    }
  }

  void _toggleControls() {
    setState(() => _showControls = !_showControls);
  }

  String _formatDuration(Duration d) {
    final minutes = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  // ─── Build ────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return widget.isEmbedded ? _buildEmbedded() : _buildFullScreen();
  }

  /// Full-screen Scaffold — use when navigating to the player as a page.
  Widget _buildFullScreen() {
    return Scaffold(
      backgroundColor: widget.backgroundColor,
      extendBodyBehindAppBar: true,
      appBar: _showControls
          ? AppBar(
              backgroundColor: widget.backgroundColor.withOpacity(0.3),
              elevation: 0,
              foregroundColor: Colors.white,
              title: Text(widget.title ?? 'Video Player'),
            )
          : null,
      body: Center(child: _buildPlayerBody()),
    );
  }

  /// Inline widget — use when embedding the player inside another screen.
  Widget _buildEmbedded() {
    return ColoredBox(
      color: widget.backgroundColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (widget.title != null) ...[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              child: Text(
                widget.title!,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
          _buildPlayerBody(),
        ],
      ),
    );
  }

  /// Core player body shared by both modes.
  Widget _buildPlayerBody() {
    if (!_controller.value.isInitialized) {
      return widget.loadingWidget ??
          const Center(child: CircularProgressIndicator(color: Colors.white));
    }

    return GestureDetector(
      onTap: _toggleControls,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // ── Video ──────────────────────────────────────────────────────
          AspectRatio(
            aspectRatio: _controller.value.aspectRatio,
            child: VideoPlayer(_controller),
          ),

          // ── Play / Pause button ────────────────────────────────────────
          if (_showControls)
            GestureDetector(
              onTap: _togglePlayPause,
              child: Icon(
                _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
                color: Colors.white,
                size: widget.controlIconSize,
              ),
            ),

          // ── Bottom progress + time row ─────────────────────────────────
          if (_showControls)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  VideoProgressIndicator(
                    _controller,
                    allowScrubbing: true,
                    colors: VideoProgressColors(
                      playedColor: widget.progressPlayedColor,
                      bufferedColor: widget.progressBufferedColor,
                      backgroundColor: Colors.white24,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          _formatDuration(_controller.value.position),
                          style: const TextStyle(color: Colors.white),
                        ),
                        Text(
                          _formatDuration(_controller.value.duration),
                          style: const TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class VideoItem extends StatefulWidget {
  final int index;
  final String text;
  final String videoUrl;
  final String imgUrl;
  final String baseUrl = 'http://18.198.107.110';

  const VideoItem(
      {Key? key,
      required this.index,
      required this.imgUrl,
      required this.text,
      required this.videoUrl})
      : super(key: key);

  @override
  State<VideoItem> createState() => _VideoItemState();
}

class _VideoItemState extends State<VideoItem> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();

    print('${widget.videoUrl} hwa dh el url');
    try {
      _controller = YoutubePlayerController(
        initialVideoId:
            YoutubePlayerController.convertUrlToId(widget.videoUrl)!,
        params: const YoutubePlayerParams(
            loop: true,
            color: 'transparent',
            desktopMode: true,
            strictRelatedVideos: true,
            showFullscreenButton: !kIsWeb),
      );
      print('${widget.videoUrl} kda dh error mn t7t');
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    print('screen built ');
    print('${widget.videoUrl}   deh ta7t elscreeen built');
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: widget.videoUrl.isEmpty
                ? 0
                : MediaQuery.of(context).size.height * 0.5,
            child: widget.videoUrl.isEmpty
                ? const SizedBox()
                :
                // if(_controller)
                YoutubePlayerControllerProvider(
                    controller: _controller,
                    child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15)),
                        child: YoutubePlayerIFrame(controller: _controller)),
                  ),
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            width: double.infinity,
            height: widget.imgUrl.isEmpty
                ? 0
                : MediaQuery.of(context).size.height * 0.3,
            child: widget.imgUrl.isEmpty
                ? const SizedBox()
                : ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image.network('${widget.baseUrl}${widget.imgUrl}')),
          ),
          SizedBox(
            width: double.infinity,
            child: widget.text.isEmpty || widget.text == '.'
                ? const SizedBox()
                : const Text(
                    'التفاصيل',
                    textAlign: TextAlign.end,
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey),
                  ),
          ),
          const SizedBox(
            height: 20,
          ),
          widget.text.isEmpty || widget.text == '.'
              ? const SizedBox()
              : Container(
                  child: Text(
                    utf8.decode(widget.text.runes.toList()),
                    textDirection: TextDirection.rtl,
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}

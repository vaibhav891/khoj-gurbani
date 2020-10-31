import 'package:flutter/material.dart';

class GestureOverlay extends StatefulWidget {
  bool isPlaying;
  // bool icons;
  final Function tapPause;
  final Function tapPlay;
  final Function tapStop;
  bool show;
  final Function removeOverlayEntry;
  final Function showOverlayFalse;

  GestureOverlay(
      {Key key,
      this.tapPause,
      this.tapPlay,
      this.isPlaying,
      this.tapStop,
      this.show,
      this.removeOverlayEntry,
      this.showOverlayFalse})
      : super(key: key);

  @override
  _GestureOverlayState createState() => _GestureOverlayState();
}

class _GestureOverlayState extends State<GestureOverlay> {
  bool icons;

  @override
  void initState() {
    super.initState();
    icons = !this.widget.isPlaying;
  }

  @override
  Widget build(BuildContext context) {
    double maxWidth = MediaQuery.of(context).size.width;
    double maxHeight = MediaQuery.of(context).size.height;
    icons = !this.widget.isPlaying;
    return Row(
      children: <Widget>[
        GestureDetector(
          onTap: () async {
            if (icons == false) {
              this.widget.tapPause();
              if (!mounted) return;
              setState(() {
                this.widget.isPlaying = true;
                icons = true;
              });
            } else {
              this.widget.tapPlay();
              if (!mounted) return;
              setState(() {
                this.widget.isPlaying = false;
                icons = false;
              });
            }
          },
          child: icons == false
              ? Icon(
                  Icons.pause,
                  color: Colors.white,
                  size: 30.0,
                )
              : Icon(
                  Icons.play_arrow,
                  color: Colors.white,
                  size: 30.0,
                ),
        ),
        Padding(
          padding: EdgeInsets.only(left: maxWidth * 0.04729, top: 0),
          child: GestureDetector(
            onTap: () async {
              if (!mounted) return;
              this.widget.tapStop();
              this.widget.removeOverlayEntry();
              setState(() {
                this.widget.showOverlayFalse();
                this.widget.isPlaying = false;
                // icons = false;
                this.widget.show = false;
              });
            },
            child: Icon(
              Icons.clear,
              color: Colors.white,
              size: 30,
            ),
          ),
        ),
      ],
    );
  }
}

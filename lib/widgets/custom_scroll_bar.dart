import 'package:flutter/material.dart';
import 'package:vs_scrollbar/vs_scrollbar.dart';

import '../utils/constants.dart';

class CusScrollbar extends StatefulWidget {
  final Widget child;
  final ScrollController? scrollController;
  final bool isAlwaysShown;
  final double thickness;

  CusScrollbar(
      {Key? key,
      required this.child,
      this.scrollController,
      this.isAlwaysShown = false,
      this.thickness = 16.0})
      : super(key: key);

  @override
  _CusScrollbarState createState() => _CusScrollbarState();
}

class _CusScrollbarState extends State<CusScrollbar> {
  _CusScrollbarState();

  @override
  Widget build(BuildContext context) {
    return VsScrollbar(
        controller: widget.scrollController,
        // showTrackOnHover: true, // default false
        isAlwaysShown: widget.isAlwaysShown, // default false
        // scrollbarFadeDuration: Duration(
        //     milliseconds:
        //         500), // default : Duration(milliseconds: 300)
        // scrollbarTimeToFade: Duration(
        //     milliseconds:
        //         800), // default : Duration(milliseconds: 600)
        style: VsScrollbarStyle(
          hoverThickness: widget.thickness + 2, // default 12.0
          radius: Radius.circular(
              cardsBorderRadius), // default Radius.circular(8.0)
          thickness: widget.thickness, // [ default 8.0 ]
          color: scrollBarColor, // default ColorScheme Theme
        ),
        child: widget.child);
  }
}

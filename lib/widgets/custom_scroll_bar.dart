import 'package:flutter/material.dart';

class CusScrollbar extends StatefulWidget {
  final Widget child;

  CusScrollbar(this.child);

  @override
  _CusScrollbarState createState() => _CusScrollbarState(child);
}

class _CusScrollbarState extends State<CusScrollbar> {
  Widget child;

  _CusScrollbarState(this.child);

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
        thumbVisibility: true, thickness: 10.0, child: widget.child);
  }
}

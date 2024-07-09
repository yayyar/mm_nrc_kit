import 'package:flutter/material.dart';

class UIExpansionTile extends StatelessWidget {
  const UIExpansionTile(
      {super.key,
      this.children = const <Widget>[],
      this.onExpansionChanged,
      required this.leadingTitle,
      required this.trailingTitle,
      this.backgroundColor,
      this.leadingTitleColor,
      this.leadingTitleFontSize,
      this.trailingTitleFontSize});

  final String leadingTitle;
  final String trailingTitle;
  final List<Widget> children;
  final void Function(bool)? onExpansionChanged;
  final Color? backgroundColor;
  final Color? leadingTitleColor;
  final double? leadingTitleFontSize;
  final double? trailingTitleFontSize;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return ExpansionTile(
          onExpansionChanged: onExpansionChanged,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          tilePadding: const EdgeInsets.all(0),
          initiallyExpanded: false,
          backgroundColor: backgroundColor ?? Colors.white,
          collapsedBackgroundColor: backgroundColor ?? Colors.white,
          childrenPadding: const EdgeInsets.symmetric(horizontal: 0),
          title: Text(
            leadingTitle,
            style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: trailingTitleFontSize ?? 16,
                color: leadingTitleColor ?? Colors.black),
          ),
          trailing: Text(
            trailingTitle,
            style: TextStyle(
                color: Colors.deepPurple,
                fontWeight: FontWeight.w600,
                fontSize: trailingTitleFontSize ?? 16),
          ),
          children: children);
    });
  }
}

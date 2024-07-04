import 'package:flutter/material.dart';

class UIExpansionTile extends StatelessWidget {
  const UIExpansionTile(
      {super.key,
      this.children = const <Widget>[],
      this.onExpansionChanged,
      required this.leadingTitle,
      required this.trailingTitle});

  final String leadingTitle;
  final String trailingTitle;
  final List<Widget> children;
  final void Function(bool)? onExpansionChanged;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        child: ExpansionTile(
            onExpansionChanged: onExpansionChanged,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
            trailing: Text(
              trailingTitle,
              style: const TextStyle(
                  color: Colors.deepPurple,
                  fontWeight: FontWeight.w600,
                  fontSize: 16),
            ),
            tilePadding: const EdgeInsets.all(0),
            initiallyExpanded: false,
            backgroundColor: Colors.white,
            collapsedBackgroundColor: Colors.white,
            childrenPadding: const EdgeInsets.symmetric(horizontal: 20),
            title: Text(
              leadingTitle,
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
            ),
            children: children),
      );
    });
  }
}

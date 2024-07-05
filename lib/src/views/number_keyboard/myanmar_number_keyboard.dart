import 'package:flutter/material.dart';
import 'package:mm_nrc_kit/src/views/number_keyboard/key_button.dart';

class MyanmarNumberKeyboard extends StatelessWidget {
  final Function(String) onKeyPressed;

  const MyanmarNumberKeyboard({super.key, required this.onKeyPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xffD1D3DA),
      padding: const EdgeInsets.only(top: 5),
      child: SafeArea(child: OrientationBuilder(
        builder: (context, orientation) {
          return SizedBox(
            height: orientation == Orientation.landscape
                ? MediaQuery.of(context).size.width / 3.8
                : MediaQuery.of(context).size.width / 1.9, // 250
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    KeyButton(
                      context,
                      '၁',
                      orientation: orientation,
                      onKeyPressed: onKeyPressed,
                    ),
                    KeyButton(
                      context,
                      '၂',
                      orientation: orientation,
                      onKeyPressed: onKeyPressed,
                    ),
                    KeyButton(
                      context,
                      '၃',
                      orientation: orientation,
                      onKeyPressed: onKeyPressed,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    KeyButton(
                      context,
                      '၄',
                      orientation: orientation,
                      onKeyPressed: onKeyPressed,
                    ),
                    KeyButton(
                      context,
                      '၅',
                      orientation: orientation,
                      onKeyPressed: onKeyPressed,
                    ),
                    KeyButton(
                      context,
                      '၆',
                      orientation: orientation,
                      onKeyPressed: onKeyPressed,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    KeyButton(
                      context,
                      '၇',
                      orientation: orientation,
                      onKeyPressed: onKeyPressed,
                    ),
                    KeyButton(
                      context,
                      '၈',
                      orientation: orientation,
                      onKeyPressed: onKeyPressed,
                    ),
                    KeyButton(
                      context,
                      '၉',
                      orientation: orientation,
                      onKeyPressed: onKeyPressed,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    KeyButton(
                      context,
                      '﹀',
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      fontWeight: FontWeight.w500,
                      fontSize: 26,
                      orientation: orientation,
                      overlayColor: Colors.transparent,
                      onKeyPressed: onKeyPressed,
                    ),
                    KeyButton(
                      context,
                      '၀',
                      orientation: orientation,
                      onKeyPressed: onKeyPressed,
                    ),
                    KeyButton(
                      context,
                      '⌫',
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      fontWeight: FontWeight.w300,
                      fontSize: 26,
                      orientation: orientation,
                      overlayColor: Colors.transparent,
                      onKeyPressed: onKeyPressed,
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      )),
    );
  }
}

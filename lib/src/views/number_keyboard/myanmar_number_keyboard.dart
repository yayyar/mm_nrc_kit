import 'package:flutter/material.dart';
import 'package:mm_nrc_kit/src/views/number_keyboard/key_button.dart';

class MyanmarNumberKeyboard extends StatelessWidget {
  final Function(String) onKeyPressed;

  const MyanmarNumberKeyboard({super.key, required this.onKeyPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xffD1D3DA),
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
      child: SafeArea(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              KeyButton(
                context,
                '၁',
                onKeyPressed: onKeyPressed,
              ),
              const SizedBox(
                width: 5,
              ),
              KeyButton(
                context,
                '၂',
                onKeyPressed: onKeyPressed,
              ),
              const SizedBox(
                width: 5,
              ),
              KeyButton(
                context,
                '၃',
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
                onKeyPressed: onKeyPressed,
              ),
              const SizedBox(
                width: 5,
              ),
              KeyButton(
                context,
                '၅',
                onKeyPressed: onKeyPressed,
              ),
              const SizedBox(
                width: 5,
              ),
              KeyButton(
                context,
                '၆',
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
                onKeyPressed: onKeyPressed,
              ),
              const SizedBox(
                width: 5,
              ),
              KeyButton(
                context,
                '၈',
                onKeyPressed: onKeyPressed,
              ),
              const SizedBox(
                width: 5,
              ),
              KeyButton(
                context,
                '၉',
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
                overlayColor: Colors.transparent,
                onKeyPressed: onKeyPressed,
              ),
              const SizedBox(
                width: 5,
              ),
              KeyButton(
                context,
                '၀',
                onKeyPressed: onKeyPressed,
              ),
              const SizedBox(
                width: 5,
              ),
              KeyButton(
                context,
                '⌫',
                backgroundColor: Colors.transparent,
                elevation: 0,
                fontWeight: FontWeight.w300,
                fontSize: 26,
                overlayColor: Colors.transparent,
                onKeyPressed: onKeyPressed,
              ),
            ],
          ),
        ],
      )),
    );
  }
}

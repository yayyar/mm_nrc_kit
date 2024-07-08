import 'package:flutter/material.dart';
import 'package:mm_nrc_kit/src/views/number_keyboard/key_button.dart';

class EnglishNumberKeyboard extends StatelessWidget {
  final Function(String) onKeyPressed;

  const EnglishNumberKeyboard({super.key, required this.onKeyPressed});

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
                '1',
                onKeyPressed: onKeyPressed,
              ),
              const SizedBox(
                width: 5,
              ),
              KeyButton(
                context,
                '2',
                onKeyPressed: onKeyPressed,
              ),
              const SizedBox(
                width: 5,
              ),
              KeyButton(
                context,
                '3',
                onKeyPressed: onKeyPressed,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              KeyButton(
                context,
                '4',
                onKeyPressed: onKeyPressed,
              ),
              const SizedBox(
                width: 5,
              ),
              KeyButton(
                context,
                '5',
                onKeyPressed: onKeyPressed,
              ),
              const SizedBox(
                width: 5,
              ),
              KeyButton(
                context,
                '6',
                onKeyPressed: onKeyPressed,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              KeyButton(
                context,
                '7',
                onKeyPressed: onKeyPressed,
              ),
              const SizedBox(
                width: 5,
              ),
              KeyButton(
                context,
                '8',
                onKeyPressed: onKeyPressed,
              ),
              const SizedBox(
                width: 5,
              ),
              KeyButton(
                context,
                '9',
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
                '0',
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

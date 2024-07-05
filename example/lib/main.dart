import 'package:flutter/material.dart';
import 'package:mm_nrc_kit/mm_nrc_kit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MM NRC Kit',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'SF-Compact-Rounded-Regular',
        appBarTheme: const AppBarTheme(backgroundColor: Colors.white),
        scaffoldBackgroundColor: const Color(0xffEFEEF2),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'MM NRC Kit'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    return GestureDetector(
      onTap: () {
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.focusedChild?.unfocus();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: NRCField(
            language: NrcLanguage.myanmar,
            // nrcValue: "8/MAKANA(N)223344",
            leadingTitleColor: Colors.black,
            backgroundColor: Colors.white,
            pickerItemColor: Colors.black,
            borderColor: Colors.white,
            borderRadius: 10,
            borderWidth: 0.4,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
            onCompleted: (value) {
              debugPrint("onCompleted : $value");
            },
            onChanged: (value) {
              debugPrint("onChanged : $value");
            },
          ),
        ),
      ),
    );
  }
}

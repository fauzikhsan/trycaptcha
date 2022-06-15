import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:g_recaptcha_v3/g_recaptcha_v3.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GRecaptchaV3.ready("6LfwIfYfAAAAAImiA7FCJ97MBADzvh5Ln_EeWCpT",
      showBadge: true);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _token = 'Click the below button to generate token';
  bool badgeVisible = true;
  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> getToken() async {
    String token = await GRecaptchaV3.execute('submit') ?? 'null returned';
    setState(() {
      _token = token;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Coba Package Recaptcha Flutter for Tetra'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SelectableText('Token: $_token\n'),
              ElevatedButton(
                child: const Text('Get new token'),
                onPressed: getToken,
              ),
              OutlinedButton.icon(
                onPressed: () {
                  if (badgeVisible) {
                    GRecaptchaV3.hideBadge();
                  } else {
                    GRecaptchaV3.showBadge();
                  }
                  badgeVisible = !badgeVisible;
                },
                icon: const Icon(Icons.legend_toggle),
                label: const Text("Toggle Badge Visibilty"),
              ),
              TextButton.icon(
                  label: const Icon(Icons.copy),
                  onPressed: () {
                    Clipboard.setData(const ClipboardData(
                        text: "https://pub.dev/packages/g_recaptcha_v3"));
                  },
                  icon: const SelectableText(
                      "https://pub.dev/packages/g_recaptcha_v3")),
            ],
          ),
        ),
      ),
    );
  }
}
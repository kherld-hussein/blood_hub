import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutBlood extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Image.asset('assets/images/phone.png', height: 130),
                const SizedBox(height: 15),
                const Text(
                  'BLOOD HUB',
                  style: const TextStyle(
                      fontSize: 25, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                Center(
                  child: const Text(
                    'Version: 1.0.0',
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ),
                const SizedBox(height: 15),
                ExpansionTile(
                  title: const Text(
                    'How make blood request',
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 14),
                  ),
                  children: [
                    Linkify(
                      text:
                          "Please view the README file for instructions: https://github.com/kherld-hussein/blood-hub",
                      textAlign: TextAlign.center,
                      linkStyle:
                          TextStyle(color: Theme.of(context).accentColor),
                      onOpen: (link) => launch(link.url),
                    ),
                  ],
                ),
                ExpansionTile(
                  title: const Text(
                    'How to donate blood',
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 14),
                  ),
                  children: [
                    Linkify(
                      text:
                          "Please view the README file for instructions: https://github.com/kherld-hussein/blood-hub",
                      textAlign: TextAlign.center,
                      linkStyle:
                          TextStyle(color: Theme.of(context).accentColor),
                      onOpen: (link) => launch(link.url),
                    ),
                  ],
                ),
                ExpansionTile(
                  title: const Text(
                    'Why use this app? Is it safe?',
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 14),
                  ),
                  children: [
                    Text(
                        'We are very grateful that BloodHub exists! It\'s now easier for '
                        'donors & receivers of blood to schedule and make request with less complexity, '
                        'Read our Privacy policy and see how we protect your data.',
                        style: TextStyle(letterSpacing: 1.8),
                        textAlign: TextAlign.center),
                  ],
                ),
                const Divider(),
                const Text(
                  'This app is a partnership of name them here ....',
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                Linkify(
                  text: 'Support'
                      'Open Source & Contributors\nhttps://github.com/kherld-hussein/bloodhub',
                  style: const TextStyle(color: Colors.grey, fontSize: 13),
                  linkStyle: TextStyle(color: Theme.of(context).accentColor),
                  textAlign: TextAlign.center,
                  onOpen: (link) => launch(link.url),
                ),
                const SizedBox(height: 10),
                Linkify(
                  text: 'Developer\n Kherld Hussein',
                  style: const TextStyle(color: Colors.grey, fontSize: 13),
                  linkStyle: TextStyle(color: Theme.of(context).accentColor),
                  textAlign: TextAlign.center,
                  onOpen: (link) => launch(link.url),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

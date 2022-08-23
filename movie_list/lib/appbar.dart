import 'package:flutter/material.dart';

import 'package:fluttermoji/fluttermoji.dart';

import 'avatar.dart';
import 'home.dart';
import 'view_website.dart';

AppBar appBar(context, page) {
  return AppBar(
      toolbarHeight: 70.0,
      title: ElevatedButton(
        style: ButtonStyle(
          elevation: MaterialStateProperty.resolveWith((states) => 0),
          fixedSize: MaterialStateProperty.resolveWith(
            (states) => const Size.fromRadius(50),
          ),
        ),
        onPressed: () {
          if (page == "index" || page == "avatar") {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const WebSite()),
                (route) => false);
          } else {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const Home()),
                (route) => false);
          }
        },
        child: const Text("Site Oficial", style: TextStyle(fontSize: 20)),
      ),
      actions: [
        TextButton(
          style: ButtonStyle(
            fixedSize: MaterialStateProperty.resolveWith(
                (states) => const Size.fromWidth(50)),
          ),
          onPressed: () {
            if (page == "index" || page == "website") {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const Avatar()),
                  (route) => false);
            } else {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const Home()),
                  (route) => false);
            }
          },
          child: FluttermojiCircleAvatar(
            backgroundColor: Colors.grey[200],
            radius: 100,
          ),
        )
      ],
      bottom: page == "index"
          ? const TabBar(
              tabs: [
                Tab(child: Text("Filmes")),
                Tab(child: Text("Personagens")),
                Tab(child: Text("Favoritos")),
              ],
            )
          : null);
}

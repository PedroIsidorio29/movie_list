import 'package:flutter/material.dart';

import 'package:fluttermoji/fluttermoji.dart';

AppBar appBar(page) {
  return AppBar(
      leading: ElevatedButton(
        onPressed: () {print("aqui");},
        child: const Text("Site Oficial"),
      ),
      actions: [
        TextButton(
          onPressed: () {
            print('aqui2');
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

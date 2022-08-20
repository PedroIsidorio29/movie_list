import 'package:flutter/material.dart';
import 'package:movie_list/appbar.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(initialIndex: 0,
      length: 3,
      child: Scaffold(
        appBar: appBar("index"),
        body: TabBarView(
          children: [
            filmes(),
            personagens(),
            favoritos(),
          ],
        ),
      ),
    );
  }

 

  Widget filmes() {
    return Container(color: Colors.red);
  }

  Widget personagens() {
    return Container(color: Colors.green);
  }

  Widget favoritos() {
    return Container(color: Colors.blue);
  }
}

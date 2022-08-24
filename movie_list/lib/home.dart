// ignore_for_file: unused_local_variable, curly_braces_in_flow_control_structures, non_constant_identifier_names

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:movie_list/appbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  getShared() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey("fav") == false) {
      prefs.setString("fav", jsonEncode([]));
    } else {
      String? fav = prefs.getString("fav");
      setState(() {
        favoritos = jsonDecode(fav!);
      });
      // print(favoritos);
    }
  }

  List favoritos = [];

  @override
  void initState() {
    getShared();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 3,
      child: Scaffold(
        appBar: appBar(context, "index"),
        body: TabBarView(
          children: [
            filmes(),
            personagens(),
            favoritos_page(),
          ],
        ),
      ),
    );
  }

  Future getFutureDados(url, tipo) async {
    var resp = await Dio().get(url);
    return resp.data;
  }

  Color verificarFav(value, [tipo = "filmes"]) {
    bool isFav = false;
    var color = Colors.black26;
    String text;
    if (tipo == "filmes")
      text = "episode_id";
    else
      text = "name";
    for (var i = 0; i < favoritos.length; i++) {
      if (favoritos[i][text] == value[text]) {
        color = Colors.red;
        break;
      }
    }
    return color;
  }

  Widget filmes() {
    return FutureBuilder(
        future: getFutureDados("https://swapi.dev/api/films/", "api"),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var data = jsonDecode(jsonEncode(snapshot.data));
            List<dynamic> listaFilmes = data["results"];
            return ListView.builder(
                itemCount: listaFilmes.length,
                itemBuilder: ((context, i) {
                  return ListTile(
                    title: Text("${listaFilmes[i]["title"]}"),
                    trailing: IconButton(
                        icon: Icon(Icons.favorite,
                            color: verificarFav(listaFilmes[i])),
                        onPressed: () async {
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          bool addFav = true;
                          for (var x = 0; x < favoritos.length; x++) {
                            if (favoritos[x]["episode_id"] ==
                                listaFilmes[i]["episode_id"]) {
                              favoritos.remove(favoritos[x]);
                              addFav = false;
                              break;
                            }
                          }
                          if (addFav) {
                            listaFilmes[i]
                                .addAll({"view": listaFilmes[i]["title"]});
                            favoritos.add(listaFilmes[i]);
                          }
                          prefs.setString("fav", jsonEncode(favoritos));
                          getShared();
                        }),
                  );
                }));
          }
          return circular();
        });
  }

  Widget personagens() {
    return FutureBuilder(
        future: getFutureDados("https://swapi.dev/api/people/", "api"),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var data = jsonDecode(jsonEncode(snapshot.data));
            List<dynamic> listPessoas = data["results"];
            return ListView.builder(
                itemCount: listPessoas.length,
                itemBuilder: ((context, i) {
                  return ListTile(
                    title: Text("${listPessoas[i]["name"]}"),
                    trailing: IconButton(
                        icon: Icon(Icons.favorite,
                            color: verificarFav(listPessoas[i], "pessoas")),
                        onPressed: () async {
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          bool addFav = true;
                          for (var x = 0; x < favoritos.length; x++) {
                            if (favoritos[x]["view"] ==
                                listPessoas[i]["name"]) {
                              favoritos.remove(favoritos[x]);
                              addFav = false;
                              break;
                            }
                          }
                          if (addFav) {
                            listPessoas[i]
                                .addAll({"view": listPessoas[i]["name"]});
                            favoritos.add(listPessoas[i]);
                          }
                          prefs.setString("fav", jsonEncode(favoritos));
                          getShared();
                        }),
                  );
                }));
          }
          return circular();
        });
  }

  Widget favoritos_page() {
    color(i) {
      var color = const Color.fromARGB(255, 126, 241, 130);
      if (favoritos[i]['title'] != null) {
        color = const Color.fromARGB(255, 247, 118, 109);
      }
      return color;
    }

    return ListView.builder(
        itemCount: favoritos.length,
        itemBuilder: (context, i) {
          return ListTile(
            tileColor: color(i),
            title: Text("${favoritos[i]["view"]}"),
          );
        });
  }

  Widget circular() => Container(
      margin: const EdgeInsets.symmetric(horizontal: 150, vertical: 235),
      child: const CircularProgressIndicator());
}

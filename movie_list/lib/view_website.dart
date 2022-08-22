import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:movie_list/appbar.dart';

class WebSite extends StatefulWidget {
  const WebSite({Key? key}) : super(key: key);

  @override
  State<WebSite> createState() => _WebSiteState();
}

class _WebSiteState extends State<WebSite> {
  bool _load = false;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: appBar(context, "website"),
      body: IndexedStack(
        index: _load ? 1 : 0,
        children: [
          Container(
              margin: EdgeInsets.only(
                top: size.height * 0.4,
                left: size.width * 0.45,
              ),
              child: const CircularProgressIndicator()),
          InAppWebView(
            onLoadStop: (controller, url) {
              setState(() {
                _load = true;
              });
            },
            initialUrlRequest: URLRequest(
              url: Uri.parse("https://www.starwars.com/community"),
            ),
          ),
        ],
      ),
    );
  }
}

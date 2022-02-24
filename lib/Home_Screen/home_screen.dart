import 'dart:convert';
import 'package:cats_facts/Constants/constants.dart';
import 'package:cats_facts/Models/cat_facts_model.dart';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:share/share.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String linkAPI = 'https://catfact.ninja/fact';

  ///Fetch Data
  Future<CatFactsModel> fetchAPI() async {
    CatFactsModel catFactsModel;
    http.Response response = await http.get(Uri.parse(linkAPI));
    Map<String, dynamic> jsonResponse = jsonDecode(response.body);
    catFactsModel = CatFactsModel.fromJson(jsonResponse);
    return catFactsModel;
  }

  @override
  void initState() {
    fetchAPI();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size s = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Cats Facts'),
      ),
      body: Container(
        height: s.height,
        width: s.width,
        child: FutureBuilder<CatFactsModel>(
          future: fetchAPI(),
          builder:
              (BuildContext context, AsyncSnapshot<CatFactsModel> snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }
            final v = snapshot.data;
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Divider(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: s.width,
                    child: Center(
                      child: Column(
                        children: [
                          Text(
                            "${v.fact}",
                            style: GoogleFonts.raleway(
                              textStyle: TextStyle(
                                fontSize: 30,
                              ),
                            ),
                          ),
                          Divider(),
                          Container(
                            width: s.width,
                            child: Center(
                              child: Text(
                                'Length -${v.length}-',
                                style: GoogleFonts.raleway(
                                  textStyle: TextStyle(
                                    fontSize: 30,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Divider(),
                        ],
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      onPressed: () {
                        Share.share("${v.fact} - ${v.length}").then(
                          (value) => showToastMsg("Sharing Successfully!"),
                        );
                      },
                      icon: Icon(Icons.share),
                    ),
                    IconButton(
                      onPressed: () {
                        FlutterClipboard.copy("${v.fact} - ${v.length}").then(
                          (value) => showToastMsg("Copied Successfully!"),
                        );
                      },
                      icon: Icon(Icons.copy),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

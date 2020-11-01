import 'dart:convert';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:movie/details_page.dart';

class MusicList extends StatefulWidget {
  @override
  _MusicListState createState() => _MusicListState();
}

class _MusicListState extends State<MusicList> {
  // ///internet check
  // String result = '';
  // var Colorsval = Colors.white;
  // void CheckStatus() {
  //   Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
  //     if (result == ConnectivityResult.mobile ||
  //         result == ConnectivityResult.wifi) {
  //       ChangeValues("Connected", Colors.green[900]);
  //     } else {
  //       ChangeValues("No Internet", Colors.red[900]);
  //     }
  //   });
  // }
  //
  // void ChangeValues(String resultval, Color colorval) {
  //   setState(() {
  //     result = resultval;
  //     Colorsval = colorval;
  //   });
  // }

  ///Fetching Data
  var api1 =
      "https://api.musixmatch.com/ws/1.1/chart.tracks.get?apikey=2d782bc7a52a41ba2fc1ef05b9cf40d7";
  var res, track;

  @override
  void initState() {
    super.initState();
    fetchData();
    //CheckStatus();
  }

  fetchData() async {
    res = await http.get(api1);
    track = jsonDecode(res.body)["message"]["body"]["track_list"];
    //print(track.toString());
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text("Music"),
        centerTitle: true,
      ),
      body: res != null
          ? ListView.builder(
              itemCount: track.length,
              itemBuilder: (BuildContext ctx, index) {
                var trackDetails = track[index]["track"];
                var trackId = trackDetails[
                    "track_id"]; //track=["message"]["body"]["track_list"]
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DetailsPage(
                                trackDetails: trackDetails, id: trackId)));
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Divider(
                        thickness: 5,
                        height: 10,
                      ),
                      Text(
                        "Track$index : ${trackDetails["track_name"]}",
                        style: TextStyle(
                            fontSize: 20, fontStyle: FontStyle.italic),
                      ),
                      Text(
                        " album name : ${trackDetails["album_name"]}",
                        style: TextStyle(
                            fontSize: 10, fontStyle: FontStyle.italic),
                      ),
                      Text(
                        " album name : $trackId",
                        style: TextStyle(
                            fontSize: 10, fontStyle: FontStyle.italic),
                      ),
                    ],
                  ),
                );
              })
          : Center(child: CircularProgressIndicator()),
    );
  }
}

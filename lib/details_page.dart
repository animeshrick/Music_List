import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DetailsPage extends StatefulWidget {
  final trackDetails;

  const DetailsPage({Key key, this.trackDetails});

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  ///Fetching Data
  var url =
      "https://api.musixmatch.com/ws/1.1/track.get?track_id=TRACK_ID&apikey=2d782bc7a52a41ba2fc1ef05b9cf40d7";
  var res, track;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  fetchData() async {
    res = await http.get(url);
    //print(res.body);
    track = jsonDecode(res.body)["message"];
    print(track.toString());
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    int trackRating = widget.trackDetails["track_rating"];
    String tr = "$trackRating";
    return Scaffold(
      appBar: AppBar(
        title: Text('Track Details of ${widget.trackDetails["track_id"]}'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Track name -> " + widget.trackDetails["track_name"]),
          Divider(
            thickness: 5,
          ),
          Text("Track rating -> " + tr),
          Divider(
            thickness: 5,
          ),
          Text("Lyrics -> \n" + widget.trackDetails["track_share_url"]),
        ],
      ),
    );
  }
}

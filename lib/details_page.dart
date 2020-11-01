import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DetailsPage extends StatefulWidget {
  final trackDetails, id;

  const DetailsPage({Key key, this.trackDetails, this.id}) : super(key: key);

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  ///Fetching Data
  ///after ["body"]
  ///api3
  ///{lyrics: {lyrics_id: 23954890, explicit: 1, lyrics_body: Oh-oh-oh
  /// Yeah, yeah, yeah, yeah
  /// Yeah....}
  ///api2
  ///{track: {track_id: 200360817, track_name: Mood (feat. iann dior),
  ///track_name_translation_list: [], track_rating: 99, commontrack_id: 113838056,
  ///instrumental: 0, explicit: 1, has_lyrics: 1, has_subtitles: 1, has_richsync: 1,
  ///num_favourite: 209, album_id: 39278869, album_name: Mood (feat. iann dior) - Single,
  ///artist_id: 46038964, artist_name: 24kGoldn feat. iann dior,
  ///track_share_url: https://www.musixmatch.com/lyrics/24kGoldn-iann-dior/Mood-Iann-Dior?utm_source=application&utm_campaign=api&utm_medium=n%2Fa%3A1409620463618, track_edit_url: https://www.musixmatch.com/lyrics/24kGoldn-iann-dior/Mood-Iann-Dior/edit?utm_source=application&utm_campaign=api&utm_medium=n%2Fa%3A1409620463618,
  ///restricted: 0, updated_time: 2020-10-01T07:39:12Z, primary_genres: {music_genre_list: []}}}
  var api1 =
      "https://api.musixmatch.com/ws/1.1/chart.tracks.get?apikey=2d782bc7a52a41ba2fc1ef05b9cf40d7";
  var api2 =
      "https://api.musixmatch.com/ws/1.1/track.get?track_id=$oneTrackId&apikey=2d782bc7a52a41ba2fc1ef05b9cf40d7";
  var api3 =
      "https://api.musixmatch.com/ws/1.1/track.lyrics.get?track_id=$oneTrackId&apikey=2d782bc7a52a41ba2fc1ef05b9cf40d7";
  var res, lyrics, tracksId;

  static var oneTrackId = "201234497"; //WAP
  //static var trackIdAll = widget.trackDetails[id];
  //var trackDetails = track[index]["track"];
  //track = jsonDecode(res.body)["message"]["body"]["track_list"];
  //static var allId = widget.id.toString();

  @override
  void initState() {
    super.initState();
    fetchData();
    fetchTrackId();
    var allId = widget.id.toString();
    print(allId);
  }

  ///for lyrics
  fetchData() async {
    res = await http.get(api3);
    lyrics = jsonDecode(res.body)["message"]["body"]["lyrics"]["lyrics_body"];
    //print(lyrics.toString());
    setState(() {});
  }

  ///for track_id
  fetchTrackId() async {
    res = await http.get(api2);
    tracksId = jsonDecode(res.body)["message"]["body"]["track"]["track_id"];
    //print(tracksId.toString());
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    int trackRating = widget.trackDetails["track_rating"];
    String tr = "$trackRating";
    var trackIdAll = widget.trackDetails["track_id"];
    String ids = "$trackIdAll";
    return Scaffold(
      appBar: AppBar(
        title: Text('Track Details of \n${widget.trackDetails["album_name"]}'),
      ),
      body: lyrics != null
          ? Padding(
              padding: EdgeInsets.all(5),
              child: ListView(
                children: [
                  Text("Track Id -> " + ids),
                  Text("\n"),
                  Text("Track name -> " + widget.trackDetails["track_name"]),
                  Divider(
                    thickness: 5,
                  ),
                  Text("Artist name -> " + widget.trackDetails["artist_name"]),
                  Divider(
                    thickness: 5,
                  ),
                  Text(
                      "Updated time -> " + widget.trackDetails["updated_time"]),
                  Divider(
                    thickness: 5,
                  ),
                  Text("Track rating -> " + tr),
                  Divider(
                    thickness: 5,
                  ),
                  Text("Lyrics :\n" + lyrics),
                ],
              ),
            )
          : Center(child: CircularProgressIndicator()),
    );
  }
}

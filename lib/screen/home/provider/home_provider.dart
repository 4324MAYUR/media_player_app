import 'package:just_audio/just_audio.dart';
import 'package:flutter/material.dart';

class HomeProvider with ChangeNotifier {

  List<Map<String,String>> listOfSong = [
    {
      'title' : "Rabba Mereya",
      'image' : "https://pagalfree.com/images/128Rabba Mereya - B Praak 128 Kbps.jpg",
      'url' : "https://pagalfree.com/musics/128-Rabba Mereya - B Praak 128 Kbps.mp3",
      'subtitle' : "B Praak, Avvy Sra, Jaani"
    },
     {
      'title' : "Singham Again",
      'image' : "https://pagalfree.com/images/128Singham Again Title Track - Singham Again 128 Kbps.jpg",
      'url' : "https://pagalfree.com/musics/128-Singham Again Title Track - Singham Again 128 Kbps.mp3",
      'subtitle' : "Swanand Kirkire, Santhosh, Ravi Basrur"
    },

     {
      'title' : "Bhool Bhulaiyaa 3",
      'image' : "https://pagalfree.com/images/128Bhool Bhulaiyaa 3 - Title Track (Feat. Pitbull) - Bhool Bhulaiyaa 3 128 Kbps.jpg",
      'url' : "https://pagalfree.com/musics/128-Bhool Bhulaiyaa 3 - Title Track (Feat. Pitbull) - Bhool Bhulaiyaa 3 128 Kbps.mp3",
      'subtitle' : "Pitbull, Diljit Dosanjh"
    },
     {
      'title' : "Aaj Ki Raat",
      'image' : "https://pagalfree.com/images/128Aaj Ki Raat - Stree 2 128 Kbps.jpg",
      'url' : "https://pagalfree.com/musics/128-Aaj Ki Raat - Stree 2 128 Kbps.mp3",
      'subtitle' : "Amitabh Bhattacharya, Divya Kumar"
    },
   {
      'title' : "ANGAARON",
      'image' : "https://pagalfree.com/images/128Angaaron - Pushpa 2 The Rule 128 Kbps.jpg",
      'url' : "https://pagalfree.com/musics/128-Angaaron - Pushpa 2 The Rule 128 Kbps.mp3",
     'subtitle' : "Shreya Ghoshal, Devi Sri Prasad"
   },
    {
      'title' : "AAYI NAI",
      'image' : "https://pagalfree.com/images/128Aayi Nai - Stree 2 128 Kbps.jpg",
      'url' : "https://pagalfree.com/musics/128-Aayi Nai - Stree 2 128 Kbps.mp3",
      'subtitle' : "Amitabh Bhattachaya , Sachin-Jigar"
    },
    {
      'title' : "Maar Udi",
      'image' : "https://pagalfree.com/images/128Maar Udi - Sarfira 128 Kbps.jpg",
      'url' : "https://pagalfree.com/musics/128-Maar Udi - Sarfira 128 Kbps.mp3",
      'subtitle' : "Manoj Muntashir, Sugandh Shekar"
    },
    {
      'title' : "Pushpa Pushpa",
      'image' : "https://pagalfree.com/images/128Pushpa Pushpa - Pushpa 2 The Rule 128 Kbps.jpg",
      'url' : "https://pagalfree.com/musics/128-Pushpa Pushpa - Pushpa 2 The Rule 128 Kbps.mp3",
      'subtitle' : "Mika Singh, Nakash Aziz"
    },
    {
      'title' : "Zaalim",
      'image' : "https://pagalfree.com/images/128Zaalim - Badshah 128 Kbps.jpg",
      'url' : "https://pagalfree.com/musics/128-Zaalim - Badshah 128 Kbps.mp3",
      'subtitle' : "Badshah, Payal Dev"
    },
    {
      'title' : "Khaali Botal",
      'image' : "https://pagalfree.com/images/128Khaali Botal - Manan Bhardwaj 128 Kbps.jpg",
      'url' : "https://pagalfree.com/musics/128-Khaali Botal - Manan Bhardwaj 128 Kbps.mp3",
      'subtitle' : "Manan Bhardwaj, Paramparan Tandon"
    },
    {
      'title' : "Khudaya",
      'image' : "https://pagalfree.com/images/128Khudaya - Sarfira 128 Kbps.jpg",
      'url' : "https://pagalfree.com/musics/128-Khudaya - Sarfira 128 Kbps.mp3",
      'subtitle' : "Manoj Muntashir, Suhit Abhyanka"
    },
  ];

  int index = 0;
  void indexPass(int newIndex) {
    index = newIndex;
    notifyListeners();
  }

  bool isPlay = false;

  AudioPlayer audioPlayer = AudioPlayer();
  Duration currentPosition = Duration.zero;
  Duration totalDuration = Duration.zero;
  HomeProvider() {
    audioPlayer.durationStream.listen((duration) {
      totalDuration = duration ?? Duration.zero;
      notifyListeners();
    });

    audioPlayer.positionStream.listen((position) {
      currentPosition = position;
      notifyListeners();
    });

    audioPlayer.playerStateStream.listen((state) {
      isPlay = state.playing;
      notifyListeners();
    });
  }

  void togglePlayPause(String? url) async {
    String url = listOfSong[index]['url']!;
    if (isPlay) {
      await audioPlayer.pause();
    } else {
      try {
        totalDuration = audioPlayer.duration ?? Duration.zero;
        await audioPlayer.stop();
        await audioPlayer.setUrl(url);
        await audioPlayer.play();
      } catch (e) {
        debugPrint("Playback error: $e");
      }
    }
    notifyListeners();
  }

  void addSong(Map<String, String> song) {
    listOfSong.add(song);
    notifyListeners();
  }

  void seekTo(Duration position) async {
    await audioPlayer.seek(position);
    notifyListeners();
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }
}

 import 'package:flutter/material.dart';
 import 'package:media_player_app/screen/home/provider/home_provider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late HomeProvider hRead;
  late HomeProvider hWatch;
  @override
  Widget build(BuildContext context) {
    hRead = context.read<HomeProvider>();
    hWatch = context.watch<HomeProvider>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: const Text("MEDIA PLAYER",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
          fontSize: 18,
        ),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
        },
            icon: const Icon(Icons.arrow_back_sharp,
              color: Colors.white,
            ),
        ),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          // bg image
          Stack(
            fit: StackFit.expand,
            children: [
              Image.network(hRead.listOfSong[hWatch.index]['image']!,
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
               fit: BoxFit.cover,
            ),
              Container(
                color: Colors.black.withOpacity(0.7),
              ),
                Column(
                  children: [
                    Text(hRead.listOfSong[hWatch.index]['title']!,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 22,
                    ),
                    ),
                    Text(hRead.listOfSong[hWatch.index]['subtitle']!,
                    style: const TextStyle(
                       color: Colors.black,
                      fontSize: 12,
                    ),
                    ),
                  ],
              ),
             ],
          ),
          // center image
          Center(
            child: Image.network(hRead.listOfSong[hWatch.index]['image']!,
              fit: BoxFit.cover,
              width: 350,
              height: 350,
            ),
          ),
           // icon play , next and previous , slider
            Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Slider(
                    min: 0,
                    max: hWatch.totalDuration.inSeconds.toDouble(),
                    value: hWatch.currentPosition.inSeconds.toDouble(),
                    activeColor: Colors.white,
                    inactiveColor: Colors.grey,
                    onChanged: (value) {
                      hRead.seekTo(Duration(seconds: value.toInt(),),);
                    },
                  ),
                  Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text("${hRead.currentPosition.inMinutes}:${(hRead.currentPosition.inSeconds % 60).toString().padLeft(2,'0')}",
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        int previous = (hRead.index > 0)
                        ? hRead.index -1
                        : hRead.index;
                        hRead.indexPass(previous);
                        hRead.togglePlayPause(
                          hRead.listOfSong[previous]['url'],
                        );
                      },
                      icon: const Icon(
                        Icons.skip_previous,
                        color: Colors.white,
                        size: 35,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        hRead.togglePlayPause(hRead.listOfSong[hRead.index]['url']!);
                      },
                      icon: Icon(
                        hWatch.isPlay
                            ? Icons.pause
                            : Icons.play_arrow,
                        color: Colors.white,
                        size: 40,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        int nextindex =
                        (hRead.index < hRead.listOfSong.length - 1)
                            ? hRead.index + 1
                            : hRead.index;
                        hRead.indexPass(nextindex);
                        hRead.togglePlayPause(hRead.listOfSong[nextindex]['url'],
                        );
                      },
                      icon: const Icon(
                        Icons.skip_next,
                        color: Colors.white,
                        size: 35,
                      ),
                    ),
                    Text("${hRead.totalDuration.inMinutes}:${(hRead.totalDuration.inSeconds % 60).toString().padLeft(2,'0')}",
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
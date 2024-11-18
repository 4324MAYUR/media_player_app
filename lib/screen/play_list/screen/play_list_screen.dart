import 'package:flutter/material.dart';
 import 'package:media_player_app/screen/home/provider/home_provider.dart';
import 'package:provider/provider.dart';

class PlayListScreen extends StatefulWidget {
  const PlayListScreen({super.key});

  @override
  State<PlayListScreen> createState() => _PlayListScreenState();
}

class _PlayListScreenState extends State<PlayListScreen> {
  late HomeProvider hRead;
  late HomeProvider hWatch;
  @override
  Widget build(BuildContext context) {
    hRead = context.read<HomeProvider>();
    hWatch = context.watch<HomeProvider>();
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: const Text("PLAY LIST",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 18,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
      child: ListView.builder(
        itemCount: hRead.listOfSong.length,
        itemBuilder: (context, index) {
          final song = hRead.listOfSong[index];
          return GestureDetector(
            onTap: () {
              hRead.indexPass(index);
              hRead.togglePlayPause(song['url']);
              Navigator.of(context).pushNamed('home');
            },
            child: Container(
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.4),
                    blurRadius: 2,
                    offset: const Offset(4, 3),
                  ),
                  const BoxShadow(
                    color: Colors.white,
                    blurRadius: 10,
                    offset: Offset(-6, 6),
                  ),
                ],
              ),
              child: ListTile(
                contentPadding: const EdgeInsets.all(28),
                title: Text(
                  song['title']!,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                subtitle: Text(
                  song['subtitle'] ?? "No subtitle available",
                  style: const TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                  ),
                ),
                trailing: const Icon(
                  Icons.music_note,
                  color: Colors.black,
                  size: 28,
                ),
                leading: CircleAvatar(
                  backgroundImage: const NetworkImage(
                      "https://img.freepik.com/free-vector/musical-notes-frame-with-text-space_1017-32857.jpg?semt=ais_hybrid"
                  ),
                  child: Image.network(
                    song['image']!,
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          );
        },
      ),
      ),
    );
  }
}
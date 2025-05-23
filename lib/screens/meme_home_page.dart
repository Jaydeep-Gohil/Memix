import 'package:flutter/material.dart';
import 'package:memix/models/meme_model.dart';
import 'package:memix/widgets/meme_card.dart';
import 'package:memix/services/meme_services.dart';

class MemeHomePage extends StatefulWidget {
  const MemeHomePage({Key? key}) : super(key: key);

  @override
  State<MemeHomePage> createState() => _MemeHomePageState();
}

class _MemeHomePageState extends State<MemeHomePage> {
  List<Meme> memes = [];
  bool isLoading = true;
  Color backgroundColor = Colors.deepPurple;

  @override
  void initState() {
    super.initState();
    fetchMemes();
  }

  Future<void> fetchMemes() async {
    final fetchedMemes = await MemeService().fetchMemes(context);
    if (fetchedMemes != null) {
      setState(() {
        memes = fetchedMemes;
        isLoading = false;
      });
    }
  }

  void updateBackgroundColor(Color color) {
    setState(() {
      backgroundColor = color;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meme Generator'),
        centerTitle: true,
        backgroundColor: backgroundColor.withOpacity(0.8),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              backgroundColor.withOpacity(0.8),
              backgroundColor.withOpacity(0.4),
            ],
          ),
        ),
        child: Center(
          child: isLoading
              ? const CircularProgressIndicator()
              : memes.isEmpty
              ? const Text("No Memes Found")
              : ListView.builder(
            itemCount: memes.length,
            itemBuilder: (context, index) {
              final meme = memes[index];
              return MemeCard(
                title: meme.title,
                imageUrl: meme.url,
                ups: meme.ups,
                postLink: meme.postLink,
                onColorExtracted: updateBackgroundColor,
              );
            },
          ),
        ),
      ),
    );
  }
}

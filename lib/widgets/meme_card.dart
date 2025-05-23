import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';

class MemeCard extends StatefulWidget {
  final String title;
  final String imageUrl;
  final int ups;
  final String postLink;
  final Function(Color) onColorExtracted;

  const MemeCard({
    Key? key,
    required this.title,
    required this.imageUrl,
    required this.ups,
    required this.postLink,
    required this.onColorExtracted,
  }) : super(key: key); // ✅ Fixed: added missing semicolon

  @override
  State<MemeCard> createState() => _MemeCardState();
}

class _MemeCardState extends State<MemeCard> {
  Color backgroundColor = Colors.white;

  @override
  void initState() {
    super.initState();
    extractColor();
  }

  Future<void> extractColor() async {
    final paletteGenerator = await PaletteGenerator.fromImageProvider(
     CachedNetworkImageProvider(widget.imageUrl),
    );
    setState(() {
      backgroundColor = paletteGenerator.darkMutedColor?.color ?? Colors.white;
    });
    widget.onColorExtracted(backgroundColor);
  }




  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [backgroundColor.withOpacity(0.8),backgroundColor.withOpacity(0.4)],
          ),
          borderRadius: const BorderRadius.all(Radius.circular(12)),

        ),
        child: Padding(padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CachedNetworkImage(imageUrl: widget.imageUrl,
              placeholder: (context,url) => const
              Center(child: CircularProgressIndicator()),
              errorWidget: (context,url,error) => const Icon(Icons.error),
              width: double.infinity,
              height: 300,
                fit: BoxFit.cover,

            ),
            Text(widget.title,style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.white)),
            SizedBox(height: 4,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Ups : ${widget.ups}',style: TextStyle(color: Colors.white)),
                TextButton(onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Link: ${widget.postLink}")),
                  );
                }, child: Text('View Post',style: TextStyle(color: Colors.deepPurple),)),
                ],
              
            )

          ],
        ),
        ),
      ),
    );
  }
}

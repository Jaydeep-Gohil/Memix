import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:memix/models/meme_model.dart';

class MemeService {
  Future<List<Meme>> fetchMemes(BuildContext context) async {
    final url = Uri.parse("https://meme-api.com/gimme/wholesomememes/50");

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        final memes = (data['memes'] as List)
            .map((meme) => Meme.fromJson(meme))
            .toList();

        return memes;
      } else {
        throw Exception("Failed to load memes");
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Error loading memes")),
      );
      return []; // ✅ Return an empty list instead of null
    }
  }
}

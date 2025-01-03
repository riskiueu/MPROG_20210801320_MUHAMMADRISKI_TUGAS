import 'package:flutter/material.dart';
import 'package:flutter_apps/layout/model/Albums.dart';
import 'package:http/http.dart' as http;

import 'dart:async';
import 'dart:convert';

class Postnews extends StatefulWidget {
  const Postnews({super.key});
  @override
  State<Postnews> createState() {
    return _PostnewsState();
  }
}

class _PostnewsState extends State<Postnews> {
  Future<Albums> createAlbums(String title) async {
    final response = await http.post(
      Uri.parse('https://jsonplaceholder.typicode.com/albums'),
      headers: <String, String>{
        'Content-type': 'application/json; charset=UTF-8'
      },
      body: jsonEncode(<String, String>{'title': title}),
    );

    if (response.statusCode == 201) {
      return Albums.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      throw Exception('Failed to create album.');
    }
  }

  final TextEditingController _controller = TextEditingController();
  Future<Albums>? _futureAlbums;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Create Data Example',
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple)),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Create Data Example'),
        ),
        body: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(8),
          child: (_futureAlbums == null) ? buildColumn() : buildFutureBuilder(),
        ),
      ),
    );
  }

  Column buildColumn() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        TextField(
          controller: _controller,
          decoration: const InputDecoration(hintText: 'Enter title'),
        ),
        ElevatedButton(
          onPressed: () {
            setState(() {
              _futureAlbums = createAlbums(_controller.text);
            });
          },
          child: const Text('Create Data'),
        )
      ],
    );
  }

  FutureBuilder<Albums> buildFutureBuilder() {
    return FutureBuilder<Albums>(
      future: _futureAlbums,
      builder: (context, snapshoot) {
        if (snapshoot.hasData) {
          return Text(snapshoot.data!.title);
        } else if (snapshoot.hasError) {
          return Text('${snapshoot.error}');
        }

        return const CircularProgressIndicator();
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_apps/layout/model/Getnews.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import 'apiPage/NewsCard.dart';

class Newspage extends StatefulWidget {
  Newspage({Key? key}) : super(key: key);
  @override
  State<Newspage> createState() => _NewspageState();
}

class _NewspageState extends State<Newspage> {
  Future<List<Getnews>> fetchPosts() async {
    final url = Uri.parse('https://jsonplaceholder.typicode.com/posts');
    final response = await http.get(url);
    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      var getPostsData = json.decode(response.body) as List;
      var listsPosts = getPostsData.map((i) => Getnews.fromJson(i)).toList();
      return listsPosts;
    } else {
      throw Exception('Failed to load Posts');
    }
  }

  late Future<List<Getnews>> futurePosts;

  @override
  void initState() {
    super.initState();
    futurePosts = fetchPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Post List'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: FutureBuilder<List<Getnews>>(
            future: futurePosts,
            builder: (context, snapshoot) {
              if (snapshoot.hasData) {
                return ListView.separated(
                    itemBuilder: ((context, index) {
                      var post = (snapshoot.data as List<Getnews>)[index];
                      return Column(
                        children: [
                          Newscard(
                            getnews: Getnews(
                                id: post.id,
                                title: post.title,
                                body: post.body),
                          ),
                          SizedBox(height: 20)
                        ],
                      );
                    }),
                    separatorBuilder: (context, index) {
                      return const Divider();
                    },
                    itemCount: (snapshoot.data as List<Getnews>).length);
              } else if (snapshoot.hasError) {
                return Text('${snapshoot.error}');
              }
              return const CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}

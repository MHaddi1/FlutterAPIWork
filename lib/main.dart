import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'Models/MyModel.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<MyModel> postlist = [];

  Future<List<MyModel>> getPostAPI() async {
    var response =
        await http.get(Uri.parse("https://jsonplaceholder.typicode.com/posts"));

    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      for (var i in data) {
        postlist.add(MyModel.fromJson(i));
      }
      return postlist;
    } else {
      return postlist;
    }
    // Add this return statement
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Api Working"),
        backgroundColor: Colors.indigoAccent,
      ),
      body: Column(
        children: [
          Expanded(
              child: FutureBuilder(
                  future: getPostAPI(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(
                        child: Text("Loading...!!"),
                      );
                    } else {
                      return ListView.builder(
                        itemCount: postlist.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: Card(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    postlist[index].title.toString(),
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(postlist[index].body.toString())
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    }
                  }))
        ],
      ),
    );
  }
}

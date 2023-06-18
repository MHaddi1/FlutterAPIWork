import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'Models/Image_model.dart';

class ExampleTwo extends StatefulWidget {
  const ExampleTwo({Key? key}) : super(key: key);

  @override
  State<ExampleTwo> createState() => _ExampleTwoState();
}

class _ExampleTwoState extends State<ExampleTwo> {
  List<Photo> listPhoto = [];

  Future<List<Photo>> getImage() async {
    var response = await http
        .get(Uri.parse("https://jsonplaceholder.typicode.com/photos"));
    var data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      for (Map<String, dynamic> i in data) {
        Photo photo = Photo(title: i['title'], url: i['url']);
        listPhoto.add(photo);
      }
      return listPhoto;
    } else {
      return listPhoto;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("API Two"),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<List<Photo>>(
              future: getImage(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text("Error: ${snapshot.error}"),
                  );
                } else if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading:  CircleAvatar(
                          backgroundImage: NetworkImage(
                            snapshot.data![index].url.toString(),
                          ),
                        ),
                        title: Text(snapshot.data![index].title),
                        
                      );
                    },
                  );
                } else {
                  return const Center(
                    child: Text("No data available"),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}



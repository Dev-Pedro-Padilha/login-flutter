import 'package:flutter/material.dart';
import 'dart:convert';

class HomeScreen extends StatelessWidget {
  final String responseData;

  HomeScreen({required this.responseData});

  @override
  Widget build(BuildContext context) {
    final user = json.decode(responseData);
    return Scaffold(
      appBar: AppBar(
        title: Text('Resposta da API'),
      ),
      body: user == null
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${user!['user']['cn']}-${user!['user']['description']}',
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(
                    user!['user']['title'],
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(
                    user!['user']['department'],
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              )),
    );
  }
}

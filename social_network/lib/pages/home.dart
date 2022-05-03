import 'package:flutter/material.dart';
import 'package:social_network/components/post_widget.dart';
import 'package:social_network/components/top_bar.dart';
import 'package:social_network/models/user.dart';

import '../components/bottom_bar.dart';
import '../models/post.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Post _postData;
    final User _userData;
    _userData = const User(firstName: "Sara", lastName: "Anderson", url: "https://randomuser.me/api/portraits/women/58.jpg");
    _postData = Post(publishDate: '03-05-2022', likes: 12, image: "https://img.dummyapi.io/photo-1564694202779-bc908c327862.jpg", text: 'adult labrador retriever', owner: _userData, link: 'link', id: '0002');
    return Scaffold(
      appBar: const TopBar(),
      bottomNavigationBar: const BottomBar(),
      body: ListView(
        children: [
          PostWidget(_postData),
          PostWidget(_postData),
          PostWidget(_postData),
        ],
      ),
    );
  }
}

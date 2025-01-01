import 'package:fire_base_keeper_app/utils/helpers/fb_auth_helper.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Book App"),
        actions: [
          IconButton(
            onPressed: () => FbAuthHelper.fbAuthHelper.logout(context),
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: Column(
        children: [
          ListTile(
            title: Text("News"),
          ),
        ],
      ),
    );
  }
}

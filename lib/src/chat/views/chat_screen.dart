import 'package:car_pooling_app/src/chat/views/chat_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatScreen extends StatelessWidget {
  static const String routeName = '/chat';

  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Chat'),
      ),
      body: ListView(
        children: [
          ListTile(
            onTap: () {
              Get.toNamed(ChatDetailScreen.routeName);
            },
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(32.0),
              child: Image.asset(
                'assets/images/person.jpeg',
                fit: BoxFit.cover,
                width: 46.0,
                height: 46.0,
              ),
            ),
            title: const Text('Zain'),
            subtitle: const Text('Last message will be show here..'),
          ),
          const Divider(
            indent: 10.0,
            endIndent: 10.0,
          ),
          ListTile(
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(32.0),
              child: Image.asset(
                'assets/images/person.jpeg',
                fit: BoxFit.cover,
                width: 46.0,
                height: 46.0,
              ),
            ),
            title: const Text('Hassan'),
            subtitle: const Text('Last message will be show here..'),
          ),
          const Divider(
            indent: 10.0,
            endIndent: 10.0,
          ),
          ListTile(
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(32.0),
              child: Image.asset(
                'assets/images/person.jpeg',
                fit: BoxFit.cover,
                width: 46.0,
                height: 46.0,
              ),
            ),
            title: const Text('Ash'),
            subtitle: const Text('Last message will be show here..'),
          ),
        ],
      ),
    );
  }
}

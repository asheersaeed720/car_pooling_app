import 'package:bubble/bubble.dart';
import 'package:car_pooling_app/src/chat/chat_msg.dart';
import 'package:flutter/material.dart';

class ChatDetailScreen extends StatefulWidget {
  static const String routeName = '/chat-detail';

  const ChatDetailScreen({Key? key}) : super(key: key);

  @override
  _ChatDetailScreenState createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  final List<ChatMessage> msgList = ChatMessage.dummyMsgList;

  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: Column(
          children: [
            Image.asset(
              'assets/images/chat_img.png',
              // width: 200.0,
              fit: BoxFit.cover,
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                reverse: true,
                controller: _scrollController,
                itemCount: msgList.length,
                shrinkWrap: true,
                itemBuilder: (context, i) {
                  return msgList[i].uid == '1'
                      ? _buildMyMessage(msgList[i])
                      : _buildOtherMemberMessage(msgList[i]);
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 12.0),
              decoration:
                  BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(32)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const SizedBox(width: 6),
                  Expanded(
                    child: Material(
                      elevation: 4.0,
                      shadowColor: Colors.black87,
                      child: TextFormField(
                        decoration: const InputDecoration(
                          hintText: 'Write a reply...',
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.only(left: 10.0),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  const Icon(Icons.emoji_emotions_outlined),
                  const SizedBox(width: 2.0),
                  const Icon(Icons.photo),
                  const SizedBox(width: 2.0),
                  const Icon(Icons.attach_file),
                  const SizedBox(width: 6.0),
                  InkWell(
                    onTap: () {},
                    child: Icon(Icons.send, size: 32.0, color: Theme.of(context).primaryColor),
                  ),
                  const SizedBox(width: 6),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMyMessage(ChatMessage chatData) {
    return Padding(
      key: UniqueKey(),
      padding: const EdgeInsets.all(8.0),
      child: Bubble(
        elevation: 4.0,
        margin: const BubbleEdges.only(top: 10),
        radius: const Radius.circular(8.0),
        alignment: Alignment.topRight,
        nipWidth: 8,
        nipHeight: 24,
        nip: BubbleNip.rightTop,
        color: Theme.of(context).primaryColor,
        child: Text(
          chatData.message,
          style: const TextStyle(fontSize: 15.0, color: Colors.white, fontWeight: FontWeight.bold),
          textAlign: TextAlign.right,
        ),
      ),
    );
  }

  Widget _buildOtherMemberMessage(ChatMessage chatData) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Stack(
              clipBehavior: Clip.none,
              children: [
                const CircleAvatar(
                  radius: 30.0,
                  backgroundImage: NetworkImage(
                      'https://www.ommel.fi/content/uploads/2019/03/dummy-profile-image-female.jpg'),
                  backgroundColor: Colors.transparent,
                ),
                Positioned(
                  top: 40.0,
                  left: 42.0,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white, width: 2.0),
                      borderRadius: BorderRadius.circular(32.0),
                    ),
                    child: Image.asset(
                      'assets/images/online.png',
                      width: 12.0,
                    ),
                  ),
                )
              ],
            ),
            title: const Text('Test'),
            subtitle: const Text('1min ago'),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Bubble(
              elevation: 4.0,
              margin: const BubbleEdges.only(top: 10),
              radius: const Radius.circular(8.0),
              alignment: Alignment.topLeft,
              nipWidth: 8,
              nipHeight: 24,
              nip: BubbleNip.leftTop,
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    chatData.message,
                    style: const TextStyle(fontSize: 16.0),
                    textAlign: TextAlign.right,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

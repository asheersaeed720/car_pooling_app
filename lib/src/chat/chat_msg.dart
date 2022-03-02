class ChatMessage {
  ChatMessage({
    this.uid = '',
    this.message = '',
  });

  String uid;
  String message;

  static List<ChatMessage> dummyMsgList = [
    ChatMessage(
      uid: '1',
      message: 'Hello',
    ),
    ChatMessage(
      uid: '2',
      message: 'Hi',
    ),
    ChatMessage(
      uid: '1',
      message: 'How are you',
    ),
    ChatMessage(
      uid: '2',
      message: 'good',
    ),
  ];
}

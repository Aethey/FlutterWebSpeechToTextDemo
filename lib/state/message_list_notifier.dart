import 'package:flutter_riverpod/flutter_riverpod.dart';

class MessageListNotifier extends StateNotifier<List<String>> {
  MessageListNotifier() : super([]);

  void addText(String newMessage) {
    state = [...state, newMessage];
  }
}

final messageListProvider =
    StateNotifierProvider<MessageListNotifier, List<String>>((ref) {
  return MessageListNotifier();
});

import 'dart:html';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:js' as js;

import 'package:flutter_web_azure_speech_text_simple/state/message_list_notifier.dart';

class JavaScriptMessageHandler {
  final WidgetRef ref;
  const JavaScriptMessageHandler(this.ref);

  void initV2Thandler() {
    window.onMessage.listen((event) {
      if (event.data is Map) {
        var data = event.data;
        switch (data['type']) {
          case 'recognized':
            _handleRecognizedText(data['message']);
            break;
          // Add more cases for different message types here
        }
      }
    });
  }

  void startV2Thandler(config) {
    js.context.callMethod('startRecording', [js.JsObject.jsify(config)]);
  }

  void stopV2Thandler() {
    js.context.callMethod('stopRecording');
  }

  void _handleRecognizedText(String message) {
    if (kDebugMode) {
      print('Recognized text in flutter: $message');
    }
    ref.read(messageListProvider.notifier).addText(message);
    // Handle the recognized text as needed
  }

// You can add more methods to handle different types of messages
}

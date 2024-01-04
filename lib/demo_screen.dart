import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:js' as js;

import 'package:flutter_web_azure_speech_text_simple/config.dart';
import 'package:flutter_web_azure_speech_text_simple/service/javascript_message_handler.dart';
import 'package:flutter_web_azure_speech_text_simple/state/message_list_notifier.dart';



class DemoScreen extends ConsumerWidget {
  const DemoScreen({super.key});

// Authorization Info
  Map<String, dynamic> _loadConfig() {
    var apiKey = AppConfig.apiKey;
    var region = AppConfig.region;
    var endpointID = AppConfig.endpointID;
    return {
      "apiKey": apiKey,
      "region": region,
      "endpointId": endpointID,
    };
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // message list form js sync by reivepod
    // ignore: unused_local_variable
    final messageList = ref.watch(messageListProvider);
    return Container();
  }

// start v2t
  void onStartV2T(WidgetRef ref) {
    JavaScriptMessageHandler messageHandler = JavaScriptMessageHandler(ref);
    messageHandler.startV2Thandler(_loadConfig());
  }

//  stop v2t
  void onStopV2T(WidgetRef ref) {
    JavaScriptMessageHandler messageHandler = JavaScriptMessageHandler(ref);
    messageHandler.stopV2Thandler();
  }
}

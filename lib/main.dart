import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_web_azure_speech_text_simple/demo_screen.dart';
import 'package:flutter_web_azure_speech_text_simple/service/javascript_message_handler.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // init js mic and callback method
    JavaScriptMessageHandler messageHandler = JavaScriptMessageHandler(ref);
    messageHandler.initV2Thandler();
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const DemoScreen(),
    );
  }
}

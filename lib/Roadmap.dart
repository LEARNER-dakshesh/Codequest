import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Roadmap extends StatefulWidget {
  const Roadmap({super.key});

  @override
  State<Roadmap> createState() => _RoadmapState();
}

class _RoadmapState extends State<Roadmap> {
  final controller = WebViewController()
  ..setJavaScriptMode(JavaScriptMode.unrestricted)
  ..loadRequest(Uri.parse('https://neetcode.io/roadmap'));


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WebViewWidget(controller: controller,),
    );
  }
}

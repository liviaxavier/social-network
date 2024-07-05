import 'package:flutter/material.dart';
import 'package:instagram_clone/responseive/mobile_screen_layout.dart';
import 'package:instagram_clone/responseive/responsive_layout_screen.dart';
import 'package:instagram_clone/responseive/web_screen_layout.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Instagram Clone",
      home: ResponsiveLayout(webScreenLayout: WebScreenLayout(), mobileScreenLayout: MobileScreenLayout())
    );
  }
}

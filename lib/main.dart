import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/responsive/mobile_screen_layout.dart';
import 'package:instagram_clone/responsive/responsive_layout_screen.dart';
import 'package:instagram_clone/responsive/web_screen_layout.dart';
import 'package:instagram_clone/screens/signup_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if(kIsWeb){
    await Firebase.initializeApp(options: const FirebaseOptions(
        apiKey: "AIzaSyCT5HGZKBjMnFWnGZbaV53gFctyIYpiRUc", 
        appId: "1:694024476508:web:84e104bf686de34429d399", 
        messagingSenderId: "694024476508", 
        projectId: "instagram-clone-7fcb5",
        storageBucket: "instagram-clone-7fcb5.appspot.com"
        ),);
  } else {
    await Firebase.initializeApp(); // pra mobile
  }
    runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Instagram Clone",
      home: SignupScreen()//ResponsiveLayout(webScreenLayout: WebScreenLayout(), mobileScreenLayout: MobileScreenLayout())
    );
  }
}

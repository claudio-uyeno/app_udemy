import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import './screens/chat_screen.dart';
import './screens/auth_screen.dart';
import './screens/splash_screen.dart';

class AppMessaging extends StatefulWidget {
  @override
  _AppMessagingState createState() => _AppMessagingState();
}

class _AppMessagingState extends State<AppMessaging> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: StreamBuilder(stream: FirebaseAuth.instance.onAuthStateChanged, builder: (ctx, userSnapshot) {
        if (userSnapshot.connectionState == ConnectionState.waiting){
          return SplashScreen();
        }
        
        if (userSnapshot.hasData){
          return ChatScreen();
        }

        return AuthScreen();
      },),
      title: 'Chat',
      theme: ThemeData(
        primarySwatch: Colors.cyan,
        backgroundColor: Colors.cyan,
        accentColor: Colors.deepPurple,
        accentColorBrightness: Brightness.dark,
        buttonTheme: ButtonTheme.of(context).copyWith(
          buttonColor: Colors.cyan,
          textTheme: ButtonTextTheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    );
  }
}

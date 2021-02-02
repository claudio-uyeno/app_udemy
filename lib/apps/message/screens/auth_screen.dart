import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../widgets/auth_form.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _auth = FirebaseAuth.instance;
  var _isLoading = false;

  void _submitAuthForm(
    BuildContext ctx,
    String email,
    String username,
    String password,
    File userImage,
    bool isLogin,
  ) async {
    AuthResult result;

    try {
      setState(() {
        _isLoading = true;
      });

      if (isLogin) {
        result = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
      } else {
        result = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        //FirebaseStorage.instance.ref(); //access root cloud storage
        var ref = FirebaseStorage.instance.ref().child('user_image').child(
            '${result.user.uid}.jpg'); //cria uma referencia para depois enviar a imagem
        await ref.putFile(userImage).onComplete;

        var url = await ref.getDownloadURL();

        await Firestore.instance
            .collection('users')
            .document(result.user.uid)
            .setData({'username': username, 'email': email, 'imageUrl': url});
      }
    } on PlatformException catch (e) {
      var message = 'Authentication error!';

      if (e.message != null) {
        message = e.message;
      }

      Scaffold.of(ctx).showSnackBar(SnackBar(
        content: Text(message),
        backgroundColor: Theme.of(ctx).errorColor,
      ));

      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: AuthForm(
        _submitAuthForm,
        _isLoading,
      ),
    );
  }
}

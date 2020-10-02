import 'dart:io';

class HttpException implements Exception {
  final String message;

  HttpException(this.message);

  @override
  String toString(){
    return 'Http error: $message';
  }
}
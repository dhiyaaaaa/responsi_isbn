import 'package:flutter/material.dart';
import 'package:buku_flutter/helpers/user_info.dart';
import 'package:buku_flutter/ui/login_page.dart';
import 'package:buku_flutter/ui/isbn_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Widget page = const CircularProgressIndicator();

  @override
  void initState() {
    super.initState();
    isLogin();
  }

  void isLogin() async {
    var token = await UserInfo().getToken();
    setState(() {
      page = (token != null) ? const IsbnPage() : const LoginPage();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Manajemen Buku',
      debugShowCheckedModeBanner: false,
      home: page,
    );
  }
}
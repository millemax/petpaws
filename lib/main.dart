import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'pages/login_page.dart';

void main() => runApp(MiApp());

class MiApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    debugPaintSizeEnabled = false;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Mi app",
      home: LoginPage(),
    );
  }
}

import 'package:flutter/material.dart';

class UsuriosList extends StatefulWidget {
  UsuriosList({Key key}) : super(key: key);

  @override
  _UsuriosListState createState() => _UsuriosListState();
}

class _UsuriosListState extends State<UsuriosList> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('lista de usuarios'),
    );
  }
}
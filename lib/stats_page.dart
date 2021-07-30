import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'loginlist.dart';

class StatsPage extends StatelessWidget {
  const StatsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Loginlist()),
        );
      },
      child: Text('loginlist'),
    );
  }
}

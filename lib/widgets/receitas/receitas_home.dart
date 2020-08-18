import 'package:flutter/material.dart';

import './screens/abas_screen.dart';
import './screens/abas_screen_bottom.dart';

class ReceitasHome extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ReceitasHomeState();
  }
}

class _ReceitasHomeState extends State<ReceitasHome> {
  @override
  Widget build(BuildContext context) {
    return AbasScreenBottom();
  }
}

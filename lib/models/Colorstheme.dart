import 'dart:ui';

import 'package:hexcolor/hexcolor.dart';

class Colorth {
  int nbr;
  static final dynamic white = HexColor("#FFFFFF");
  static final dynamic black = HexColor("#000000");
  static final dynamic grey = HexColor("#F4F4F5");
  static final dynamic byellow = HexColor("#FFA719");
  static final dynamic cyellow = HexColor("#FFC972");
  static final dynamic fyellow = HexColor("#FFDDA7");
  static final dynamic tyellow = Color.fromRGBO(255, 185, 71, 1);

  Colorth({
    required this.nbr,
  });
}

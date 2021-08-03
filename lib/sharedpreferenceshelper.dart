/*import 'package:shared_preferences/shared_preferences.dart';

import 'databasehelper.dart';
import 'models/User.dart';

class SharedPrefs {
  late User u = new User.init();
  static SharedPreferences? pref;

  Future<SharedPreferences> get prefs async =>
      pref ??= await SharedPreferences.getInstance();

  static bool getLoginStat() {
    bool isLoggedIn = false;

    print("hahaha");

    if (pref!.getBool("isLoggedIn") != null) print("!null");
    return isLoggedIn;
  }

  User getLoggedInUser() {
    Databasehelper db = new Databasehelper();
    late SharedPreferences pref;

    SharedPreferences.getInstance().then((value) async {
      pref = value;
    });

    db.listconnid(pref.getString("UID")!).then((value) => u = value);

    return u;
  }
}*/

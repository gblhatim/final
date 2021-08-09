import 'package:app/models/message.dart';
import 'package:mysql1/mysql1.dart';

import 'models/User.dart';

class Databasehelper {
  static bool userExists = false;

  static ConnectionSettings dataBaseSetting() {
    var settings = new ConnectionSettings(
        host: '10.0.2.2',
        port: 3306,
        user: 'root',
        password: 'gbl',
        db: 'lentonn1_pexicom');

    return settings;
  }

  Future<User> listconn(String email, String password) async {
    var conn = await MySqlConnection.connect(dataBaseSetting());

    var results = await conn.query(
        'select nom, email, id, password, etat from connexion_u where email = ? and password = ?',
        [email, password]);

    conn.close();
    print(results.isNotEmpty);
    if (results.isNotEmpty) {
      User f = new User(
          nom: results.single[0].toString(),
          email: results.single[1].toString(),
          id: results.single[2].toString(),
          password: results.single[3].toString(),
          etat: results.single[4].toString());

      if (f.etat == '1') {
        userExists = true;
      } else {
        userExists = false;
      }

      return f;
    } else {
      User f = new User.init();
      userExists = false;

      return f;
    }
  }

  Future<User> listconnid(String id) async {
    var conn = await MySqlConnection.connect(dataBaseSetting());

    var results = await conn.query(
        'select nom, email, id, password, etat from connexion_u where id = ? ',
        [id]);

    conn.close();

    if (results.isNotEmpty) {
      User f = new User(
          nom: results.single[0].toString(),
          email: results.single[1].toString(),
          id: results.single[2].toString(),
          password: results.single[3].toString(),
          etat: results.single[4].toString());

      return f;
    } else {
      User f = new User.init();

      print("in db " + f.id);

      return f;
    }
  }

  Future<Message> getMessage(String id, bool isEmail, String language) async {
    var conn = await MySqlConnection.connect(dataBaseSetting());

    var results =
        await conn.query('select * from profil_c where uid = ? ', [id]);

    conn.close();

    if (results.isNotEmpty) {
      Message m = new Message(
          id: results.single[0].toString(),
          uid: results.single[1].toString(),
          lien: results.single[2].toString(),
          sujet_e: results.single[3].toString(),
          sujet_e_en: results.single[6].toString(),
          text_e: results.single[5].toString(),
          text_e_en: results.single[8].toString(),
          text_s: results.single[4].toString(),
          text_s_en: results.single[7].toString(),
          isEmail: isEmail,
          language: language);

      return m;
    } else {
      Message m = new Message.init();

      return m;
    }
  }
}

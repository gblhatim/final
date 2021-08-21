import 'dart:convert';

import 'package:app/models/Profiles.dart';
import 'package:app/models/message.dart';
import 'package:http/http.dart' as http;

import '../models/Fields.dart';
import '../models/User.dart';

// ignore: camel_case_types
class apiService {
  static bool userExists = false;
  String url = "https://pexicom.com/avisgoo/avigoapi/api.php?apicall=";
  //
  Future<User> getUserbyID(
    String id,
  ) async {
    User f = new User.init();

    final response = await http.post(
      Uri.parse(url + "getUserbyID"),
      body: {"id": id},
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
      },
      encoding: Encoding.getByName('utf-8'),
    );

    print(response.body);
    bool error = json.decode(response.body)["error"];
    var user = json.decode(response.body)["user"];
    // stopped at implement userexists from old dbhelper

    print(error);

    if (error == false) {
      if (user != []) {
        User u = new User(
            nom: user["nom"].toString(),
            email: user["email"].toString(),
            id: user["id"].toString(),
            password: "",
            etat: user["etat"].toString());
        if (u.etat == '1') {
          userExists = true;
        } else {
          userExists = false;
        }

        return u;
      }
    } else {
      User f = new User.init();
      userExists = false;

      return f;
    }

    return f;
  }

  Future<User> getUser(String email, String password) async {
    User f = new User.init();

    final response = await http.post(
      Uri.parse(url + "getUser"),
      body: {"email": email, "password": password},
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
      },
      encoding: Encoding.getByName('utf-8'),
    );

    print(response.body);
    bool error = json.decode(response.body)["error"];
    var user = json.decode(response.body)["user"];
    // stopped at implement userexists from old dbhelper

    print(error);

    if (error == false) {
      if (user != []) {
        User u = new User(
            nom: user["nom"].toString(),
            email: user["email"].toString(),
            id: user["id"].toString(),
            password: "",
            etat: user["etat"].toString());
        if (u.etat == '1') {
          userExists = true;
        } else {
          userExists = false;
        }

        return u;
      }
    } else {
      User f = new User.init();
      userExists = false;

      return f;
    }

    return f;
  }

  Future<List<Fields>> getHistory(String uid) async {
    final response = await http.post(
      Uri.parse(url + "getHistory"),
      body: {"uid": uid},
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
      },
      encoding: Encoding.getByName('utf-8'),
    );

    Map<String, dynamic> history = json.decode(response.body)["history"];

    List<Fields> h = [];
    history.values.forEach((element) {
      h.add(new Fields(
          id: element["id"].toString(),
          nom: element["nom"].toString(),
          date: element["date"].toString(),
          type: element["type"].toString()));
    });

    return h;
  }

  Future<Profiles> getProfile(String uid) async {
    final response = await http.post(
      Uri.parse(url + "getProfile"),
      body: {"uid": uid},
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
      },
      encoding: Encoding.getByName('utf-8'),
    );

    Map<String, dynamic> profile = json.decode(response.body)["user"];

    Profiles f = new Profiles(
        uid: profile["uid"].toString(),
        enom: profile["nom"].toString(),
        eadresse: profile["adresse"].toString(),
        eville: profile["ville"].toString(),
        eprovince: profile["province"].toString(),
        epays: profile["pays"].toString(),
        tele: profile["tele"].toString(),
        esite: profile["esite"].toString(),
        secteur: profile["secteur"].toString());

    return f;
  }

  Future<bool> addHistory(Fields2 f) async {
    final response = await http.post(
      Uri.parse(url + "addHistory"),
      body: {
        "uid": f.uid,
        "genre": f.genre,
        "nom": f.nom,
        "tele": f.tele,
        "email": f.email,
        "date": f.date,
        "type": f.type
      },
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
      },
      encoding: Encoding.getByName('utf-8'),
    );

    return json.decode(response.body)['error'] as bool;
  }

  Future<Message> getMessage(String uid, bool isEmail, String language) async {
    final response = await http.post(
      Uri.parse(url + "getMessage"),
      body: {"uid": uid},
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
      },
      encoding: Encoding.getByName('utf-8'),
    );

    Map<String, dynamic> message = json.decode(response.body)["history"];

    Message m = new Message(
        id: message["id"].toString(),
        uid: message["uid"].toString(),
        lien: message["lien"].toString(),
        sujet_e: message["sujet_e"].toString(),
        sujet_e_en: message["sujet_e_en"].toString(),
        text_e: message["text_e"].toString(),
        text_e_en: message["text_e_en"].toString(),
        text_s: message["text_s"].toString(),
        text_s_en: message["text_s_en"].toString(),
        isEmail: isEmail,
        language: language);

    return m;
  }

  Future<bool> updateProfile(String a1, String a2, String a3, String a4) async {
    final response = await http.post(
      Uri.parse(url + "updateProfile"),
      body: {"uid": a1, "esite": a2, "eadresse": a3, "tele": a4},
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
      },
      encoding: Encoding.getByName('utf-8'),
    );

    return json.decode(response.body)['error'] as bool;
  }

  Future<List<String>> getstat(dynamic id) async {
    final response = await http.post(
      Uri.parse(url + "stat"),
      body: {"uid": id, "type_e": "1"},
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
      },
      encoding: Encoding.getByName('utf-8'),
    );

    final responsetot = await http.post(
      Uri.parse(url + "stat"),
      body: {"uid": id, "type_e": "3"},
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
      },
      encoding: Encoding.getByName('utf-8'),
    );

    List<String> list = [];

    dynamic email = json.decode(response.body)["count"];
    dynamic sms = json.decode(responsetot.body)["count"];
    String counts = "0";
    String counte = "0";
    counte = email.toString();

    list.add(counte);
    counts = sms.toString();
    counts = (int.parse(counts) + int.parse(counte)).toString();

    list.add(counts);
    return list;
  }
}

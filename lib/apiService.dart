import 'dart:convert';

import 'package:app/models/Profiles.dart';
import 'package:app/models/message.dart';
import 'package:http/http.dart' as http;

import 'models/Fields.dart';
import 'models/User.dart';

// ignore: camel_case_types
class apiService {
  static bool userExists = false;

  /* Future<String> apiDynamic(Object? body, String apicall) async {
    final response = await http.post(
      Uri.parse(
          "https://pexicom.com/avisgoo/avigoapi/api.php?apicall=" + apicall),
      body: body,
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
      },
      encoding: Encoding.getByName('utf-8'),
    );

    return response.body;
  }
}*/

  Future<User> getUserbyID(
    String id,
  ) async {
    User f = new User.init();

    final response = await http.post(
      Uri.parse(//"http://localhost/api.php?apicall=getUserbyID"),
          "https://pexicom.com/avisgoo/avigoapi/api.php?apicall=getUserbyID"),
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
      Uri.parse("https://pexicom.com/avisgoo/avigoapi/api.php?apicall=getUser"
          //"http://localhost/api.php?apicall=getUser"
          ),
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
      Uri.parse(
          "https://pexicom.com/avisgoo/avigoapi/api.php?apicall=getHistory"
          //"http://localhost/api.php?apicall=getHistory"
          ),
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
      Uri.parse(//"http://localhost/api.php?apicall=getProfile"
          "https://pexicom.com/avisgoo/avigoapi/api.php?apicall=getProfile"),
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
      Uri.parse(
          "https://pexicom.com/avisgoo/avigoapi/api.php?apicall=addHistory"
          //"http://localhost/api.php?apicall=addHistory"
          ),
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
      Uri.parse(
          "https://pexicom.com/avisgoo/avigoapi/api.php?apicall=getMessage"
          //"http://localhost/api.php?apicall=getMessage"
          ),
      body: {"uid": uid},
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
      },
      encoding: Encoding.getByName('utf-8'),
    );

    Map<String, dynamic> message = json.decode(response.body)["message"];

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
      Uri.parse(
          "https://pexicom.com/avisgoo/avigoapi/api.php?apicall=updateProfile"
          // "http://localhost/api.php?apicall=updateProfile"
          ),
      body: {"uid": a1, "esite": a2, "eadresse": a3, "tele": a4},
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
      },
      encoding: Encoding.getByName('utf-8'),
    );

    return json.decode(response.body)['error'] as bool;
  }
}

/*
switch (apicall) {
        case "getUser":
          Map<String, dynamic> user = json.decode(value.body)["user"];

          User u = new User(
              nom: user["nom"].toString(),
              email: user["email"].toString(),
              id: user["id"].toString(),
              password: "",
              etat: user["etat"].toString());

          return u;
        case "getHistory":
          Map<String, dynamic> history = json.decode(value.body)["history"];

          List<Fields> h = [];
          history.values.forEach((element) {
            h.add(new Fields(
                id: element["id"].toString(),
                nom: element["nom"].toString(),
                date: element["date"].toString(),
                type: element["type"].toString()));
          });

          return h;
      }*/

import 'dart:convert';

import 'package:app/models/Profiles.dart';
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
      Uri.parse(
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
      Uri.parse("https://pexicom.com/avisgoo/avigoapi/api.php?apicall=getUser"),
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
          "https://pexicom.com/avisgoo/avigoapi/api.php?apicall=getHistory"),
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
      Uri.parse(
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
        esite: profile["site"].toString(),
        secteur: profile["secteur"].toString());

    return f;
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
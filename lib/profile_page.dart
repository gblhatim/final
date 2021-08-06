import 'package:app/databasehelper.dart';
import 'package:app/home.dart';
import 'package:app/models/Profiles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:mysql1/mysql1.dart';

import 'home_page.dart';
import 'models/User.dart';

class ProfilePage extends StatelessWidget {
  final User user;
  late Profiles p;
  static late TextEditingController myController1;
  static late TextEditingController myController3;
  static late TextEditingController myController7;
  static late TextEditingController myController4;
  static late TextEditingController myController5;
  static bool isEditable = false;

  ProfilePage({Key? key, required this.user}) : super(key: key);

  final _formKey = GlobalKey<FormBuilderState>();
  static Widget textfield({
    mcontroller,
    icon,
    @required nom,
  }) {
    return Material(
      elevation: 4,
      shadowColor: Colors.grey,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: FormBuilderTextField(
        readOnly: true,
        name: nom,
        controller: mcontroller,
        decoration: InputDecoration(
            fillColor: Colors.white30,
            filled: true,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide.none)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    /*final myController = TextEditingController();
    final myController1 = TextEditingController(text: user.nom);
    final myController2 =
        TextEditingController(text: p.enom + " - " + p.secteur);
    final myController3 = TextEditingController(text: p.tele);
    final myController4 = TextEditingController(text: user.email);
    final myController5 = TextEditingController(text: p.eadresse);
    final myController6 = TextEditingController();
    final myController7 = TextEditingController();
    @override
    void dispose() {
      // Clean up the controller when the widget is disposed.
      myController.dispose();
      myController1.dispose();
      myController2.dispose();
      myController3.dispose();
      myController4.dispose();
      myController5.dispose();
      myController6.dispose();
      myController7.dispose();
    }*/

    return FutureBuilder(
        future: listconn(),
        builder: (context, AsyncSnapshot<Profiles> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          p = snapshot.data!;

          myController1 = TextEditingController(text: user.nom);
          myController3 = TextEditingController(text: p.tele);
          myController7 = TextEditingController(text: p.esite);
          myController4 = TextEditingController(text: user.email);
          myController5 = TextEditingController(text: p.eadresse);

          return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.white,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(left: 0.5),
                      child: Image.asset(
                        'assets/logo.png',
                        height: 80,
                      ),
                    )
                  ],
                ),
                elevation: 0.0,
                leading: IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage(user)),
                    );
                  },
                ),
              ),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    FormBuilder(
                        key: _formKey,
                        child: Padding(
                          padding: const EdgeInsets.all(32.0),
                          child: Wrap(
                            spacing:
                                20, // to apply margin in the main axis of the wrap
                            runSpacing:
                                20, // to apply margin in the cross axis of the wrap
                            alignment: WrapAlignment.center,
                            children: [
                              SizedBox(
                                height: 25.0,
                              ),
                              textfield(
                                  nom: 'nom',
                                  /*value: user.nom*/
                                  mcontroller: myController1,
                                  icon: Icon(Icons.person)),
                              textfield(
                                  nom: 'société',
                                  /*value: p.enom + " - " + p.secteur*/
                                  mcontroller: TextEditingController(
                                      text: p.enom + " - " + p.secteur),
                                  icon: Icon(Icons.home_work_rounded)),
                              textfield(
                                  nom: 'phone',
                                  /*value: p.tele*/
                                  mcontroller: myController3,
                                  icon: Icon(Icons.phone)),
                              textfield(
                                  nom: 'mail',
                                  /*value: user.email*/
                                  mcontroller: myController4,
                                  icon: Icon(Icons.mail)),
                              textfield(
                                  nom: 'ville',
                                  /* value: p.eadresse*/
                                  mcontroller: myController5,
                                  icon: Icon(Icons.home)),
                              textfield(
                                  nom: 'province',
                                  /*value: p.eville +
                                      ", " +
                                      p.eprovince +
                                      " - " +
                                      p.epays*/
                                  mcontroller: TextEditingController(
                                      text: p.eville +
                                          ", " +
                                          p.eprovince +
                                          " - " +
                                          p.epays),
                                  icon: Icon(Icons.add_location_rounded)),
                              textfield(
                                  nom: 'website',
                                  mcontroller: myController7,
                                  icon: Icon(Icons.language_rounded)
                                  /*value: p.esite*/
                                  ),
                              Container(
                                height: 55,
                                width: double.infinity,
                                child: RaisedButton(
                                  onPressed: () {
                                    save();
                                    user.nom = myController1.text;
                                    user.email = myController4.text;
                                  },
                                  color: Colors.black54,
                                  child: Center(
                                    child: Text(
                                      "Update",
                                      style: TextStyle(
                                        fontSize: 23,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ))
                  ],
                ),
              ));
        });
  }

  Future<Profiles> listconn() async {
    var settings = new ConnectionSettings(
        host: '10.0.2.2',
        port: 3306,
        user: 'root',
        password: 'gbl',
        db: 'lentonn1_pexicom');
    var conn = await MySqlConnection.connect(settings);

    var userId = user.id;
    print(userId);

    var results = await conn.query(
        'select id, enom, eville, eprovince, epays, tele, esite, secteur, eadresse from profil_a where uid = ?',
        [userId]);

    /*print("hahha");
    print(results.isEmpty);*/

    if (results.isNotEmpty) {
      Profiles p = new Profiles(
        uid: results.single[0].toString(),
        enom: results.single[1].toString(),
        eville: results.single[2].toString(),
        eprovince: results.single[3].toString(),
        epays: results.single[4].toString(),
        tele: results.single[5].toString(),
        esite: results.single[6].toString(),
        secteur: results.single[7].toString(),
        eadresse: results.single[8].toString(),
      );
      print(p.uid);

      return p;
    } else {
      print("here?");
      Profiles p = new Profiles.init();

      return p;
    }
  }

  Future save() async {
    var settings = new ConnectionSettings(
        host: '10.0.2.2',
        port: 3306,
        user: 'root',
        password: 'gbl',
        db: 'lentonn1_pexicom');
    var conn = await MySqlConnection.connect(settings);

    var userId = user.id;
    print(userId);

    await conn.query(
        'update profil_a set esite=?,tele=?,eadresse=? where uid=?',
        [myController7.text, myController3.text, myController5.text, userId]);

    await conn.query('update connexion_u set  nom=?, email=?  where id=?',
        [myController1.text, myController4.text, userId]);
    /*await conn.query('update connexion_u set  email=?  where id=?',
        [myController4.text, userId]);*/
  }
}

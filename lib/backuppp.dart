/*import 'package:app/databasehelper.dart';
import 'package:app/models/Profiles.dart';
import 'package:app/models/textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:mysql1/mysql1.dart';

import 'models/User.dart';

class ProfilePage extends StatelessWidget {
  final User user;
  late Profiles p;
  var name = new Textield(nom: "nom");
  var societe = new Textield(nom: "société");
  var phone = new Textield(nom: "phone");
  var mail = new Textield(nom: "mail");
  var ville = new Textield(nom: "ville");
  var province = new Textield(nom: "province");
  var website = new Textield(nom: "website");
  ProfilePage({Key? key, required this.user}) : super(key: key);

  final _formKey = GlobalKey<FormBuilderState>();

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
          return Scaffold(
              appBar: AppBar(
                elevation: 0.0,
                backgroundColor: Color(0xff555555),
                leading: IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                  onPressed: () {},
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
                              name.field(
                                  TextEditingController(text: user.nom))(),
                              societe.field(
                                TextEditingController(
                                    text: p.enom + " - " + p.secteur),
                              ),
                              phone.field(
                                TextEditingController(text: p.tele),
                              ),
                              mail.field(
                                  TextEditingController(text: user.email)),
                              ville.field(
                                TextEditingController(text: p.eadresse),
                              ),
                              province.field(TextEditingController(
                                  text: p.eville +
                                      ", " +
                                      p.eprovince +
                                      " - " +
                                      p.epays)),
                              website
                                  .field(TextEditingController(text: p.esite)),
                              Container(
                                height: 55,
                                width: double.infinity,
                                child: RaisedButton(
                                  onPressed: () {
                                    save();
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

    await conn.query('update profil_a set  esite=? where uid=?',
        [website.mController.text, userId]);
  }
}*/

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _formKey = GlobalKey<FormBuilderState>();
  Widget textfield({@required mcontroller, @required nom}) {
    return Material(
      elevation: 4,
      shadowColor: Colors.grey,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: FormBuilderTextField(
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
    final myController = TextEditingController();
    final myController1 = TextEditingController();
    final myController2 = TextEditingController();
    final myController3 = TextEditingController();
    final myController4 = TextEditingController();
    final myController5 = TextEditingController();
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

      super.dispose();
    }

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
                        textfield(
                          nom: 'nom',
                          mcontroller: myController,
                        ),
                        textfield(
                          nom: 'société',
                          mcontroller: myController1,
                        ),
                        textfield(
                          nom: 'phone',
                          mcontroller: myController2,
                        ),
                        textfield(
                          nom: 'mail',
                          mcontroller: myController3,
                        ),
                        textfield(
                          nom: '',
                          mcontroller: myController4,
                        ),
                        textfield(
                          nom: 'ville',
                          mcontroller: myController5,
                        ),
                        textfield(
                          nom: 'province',
                          mcontroller: myController6,
                        ),
                        textfield(
                          nom: 'website',
                          mcontroller: myController7,
                        ),
                        Container(
                          height: 55,
                          width: double.infinity,
                          child: RaisedButton(
                            onPressed: () {},
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
  }
  /*Future<User> listconn(String email, String password) async {
    var settings = new ConnectionSettings(
        host: '10.0.2.2',
        port: 3306,
        user: 'root',
        password: 'gbl',
        db: 'lentonn1_pexicom');
    var conn = await MySqlConnection.connect(settings);

    var results = await conn.query(
        'select nom, email, id, password, etat from connexion_u where email = ? and password = ?',
        [email, password]);

    /*print("hahha");
    print(results.isEmpty);*/

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
      print("here?");
      User f = new User.init();
      userExists = false;

      return f;
    }
  }
}*/

}

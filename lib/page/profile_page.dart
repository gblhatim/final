import 'package:app/helpers/apiService.dart';
import 'package:app/home.dart';
import 'package:app/models/Profiles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_switch/flutter_switch.dart';
import '../models/Colorstheme.dart';
import '../models/User.dart';

class ProfilePage extends StatefulWidget {
  final User user;

  ProfilePage({Key? key, required this.user}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late Profiles p;
  static bool isEditable = false;

  late TextEditingController myController1;
  static late TextEditingController myController3;
  static late TextEditingController myController7;
  static late TextEditingController myController4;
  static late TextEditingController myController5;
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [],
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.only(left: 0.5),
              child: Image.asset(
                'assets/logo.png',
                height: 70,
                width: 150,
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
              MaterialPageRoute(builder: (context) => HomePage(widget.user)),
            );
          },
        ),
      ),
      body: Container(
        color: Colorth.grey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 32.0, left: 32.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Vos informations :",
                      style: TextStyle(
                        fontSize: 26.0,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 32.0, right: 32.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text("Modifier"),
                    SizedBox(
                      width: 10.0,
                    ),
                    FlutterSwitch(
                        activeText: "Edit",
                        value: isEditable,
                        height: 25,
                        width: 50,
                        activeColor: Colorth.fyellow,
                        onToggle: (val) {
                          setState(() {
                            isEditable = val;
                          });
                        })
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 32.0, top: 32.0),
                child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                  isEditable
                      ? MaterialButton(
                          onPressed: () {
                            apiService().updateProfile(
                                widget.user.id,
                                myController7.text,
                                myController5.text,
                                myController3.text);
                            widget.user.nom = myController1.text;
                            widget.user.email = myController4.text;
                            setState(() {
                              isEditable = false;
                            });
                          },
                          color: Colorth.cyellow, //("#0072ff"),
                          child: Center(
                            child: Text(
                              "Enregistrer",
                              style: TextStyle(
                                fontSize: 17,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        )
                      : Container(),
                ]),
              ),
              FutureBuilder(
                  future: apiService().getProfile(widget.user.id),
                  builder: (context, AsyncSnapshot<Profiles> snapshot) {
                    if (!snapshot.hasData) {
                      return Center(child: CircularProgressIndicator());
                    }
                    p = snapshot.data!;

                    myController1 =
                        TextEditingController(text: widget.user.nom);
                    myController3 = TextEditingController(text: p.tele);
                    myController7 = TextEditingController(text: p.esite);
                    myController4 =
                        TextEditingController(text: widget.user.email);
                    myController5 = TextEditingController(text: p.eadresse);

                    return Column(
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
                                  textfield(
                                    nom: 'nom',
                                    /*value: user.nom*/
                                    mcontroller: myController1,
                                    icon: Icons.person,
                                  ),
                                  textfield(
                                      nom: 'société',
                                      /*value: p.enom + " - " + p.secteur*/
                                      mcontroller: TextEditingController(
                                          text: p.enom + " - " + p.secteur),
                                      icon: Icons.home_work_rounded),
                                  textfield(
                                      nom: 'phone',
                                      /*value: p.tele*/
                                      mcontroller: myController3,
                                      icon: Icons.phone),
                                  textfield(
                                      nom: 'mail',
                                      /*value: user.email*/
                                      mcontroller: myController4,
                                      icon: Icons.mail),
                                  textfield(
                                      nom: 'ville',
                                      /* value: p.eadresse*/
                                      mcontroller: myController5,
                                      icon: Icons.home),
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
                                      icon: Icons.add_location_rounded),
                                  textfield(
                                      nom: 'website',
                                      mcontroller: myController7,
                                      icon: Icons.language_rounded
                                      /*value: p.esite*/
                                      ),
                                ],
                              ),
                            )),
                      ],
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }

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
        readOnly: !isEditable,
        name: nom,
        controller: mcontroller,
        decoration: InputDecoration(
            prefixIcon: Icon(icon, color: Colorth.tyellow),
            prefixStyle: TextStyle(),
            fillColor: Colors.white30,
            filled: true,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide.none)),
      ),
    );
  }
}

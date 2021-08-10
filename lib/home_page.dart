import 'package:app/databasehelper.dart';
import 'package:app/models/Fields.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:twilio_flutter/twilio_flutter.dart';
import 'package:intl/intl.dart';

import 'models/User.dart';
import 'models/message.dart';

bool isSent = false;

// ignore: camel_case_types
class AvisGoo extends StatefulWidget {
  final User user;

  AvisGoo({Key? key, required this.user}) : super(key: key);

  @override
  _AvisGooState createState() => _AvisGooState();
}

class _AvisGooState extends State<AvisGoo> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    final bool showFab = MediaQuery.of(context).viewInsets.bottom != 0.0;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Column(
          children: [
            FormBuilder(
                key: _formKey,
                child: Padding(
                    padding: const EdgeInsets.all(32.0), child: FormTwillio()))
          ],
        ),
      ),
      floatingActionButton: Visibility(
        visible: MediaQuery.of(context).viewInsets.bottom == 0.0,
        child: FAButton(
          formKey: _formKey,
          user: widget.user,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

class FormTwillio extends StatefulWidget {
  const FormTwillio({
    Key? key,
  }) : super(key: key);

  @override
  _FormTwillioState createState() => _FormTwillioState();
}

class _FormTwillioState extends State<FormTwillio> {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 20, // to apply margin in the main axis of the wrap
      runSpacing: 20, // to apply margin in the cross axis of the wrap
      alignment: WrapAlignment.center,
      children: [
        Text(
          "Génération des avis 5 étoiles",
          style: TextStyle(fontSize: 20.0),
        ),
        SizedBox(
          height: 25.0,
        ),
        Row(
          children: [
            Expanded(
              child: FormBuilderChoiceChip(
                spacing: 5.0,
                name: 'radio_group',
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  labelText: 'Choisir',
                ),
                options: [
                  FormBuilderFieldOption(value: 'Fr', child: Text('Fr')),
                  FormBuilderFieldOption(value: 'En', child: Text('En')),
                ],
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(context),
                ]),
              ),
            ),
            SizedBox(
              width: 20,
            ),
            Expanded(
              child: FormBuilderChoiceChip(
                spacing: 5.0,
                name: 'radio_group1',
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  labelText: 'Choisir',
                ),
                options: [
                  FormBuilderFieldOption(value: 'M', child: Text('M')),
                  FormBuilderFieldOption(value: 'Mme', child: Text('Mme')),
                ],
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(context),
                ]),
              ),
            )
          ],
        ),
        FormBuilderTextField(
          name: 'textfield1',
          decoration: InputDecoration(
              hintText: 'Entrer le nom et le prénom',
              hintStyle: TextStyle(fontSize: 12),
              labelText: "Nom",
              icon: Icon(Icons.account_circle),
              border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color.fromRGBO(0, 114, 255, 1),
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(10.0)))),
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.required(context),
          ]),
        ),
        FormBuilderTextField(
          name: 'textfield2',
          initialValue: "+1",
          maxLength: 12,
          decoration: InputDecoration(
              hintText: 'Entrer le numéro de téléphone',
              hintStyle: TextStyle(fontSize: 12),
              labelText: "Télephone",
              icon: Icon(Icons.phone),
              border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color.fromRGBO(0, 114, 255, 1),
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(10.0)))),
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.required(context),
            FormBuilderValidators.numeric(context),
            FormBuilderValidators.minLength(context, 12),
          ]),
        ),
        FormBuilderTextField(
          name: 'textfield3',
          decoration: InputDecoration(
              hintText: "Entrer l'adresse couriel ",
              hintStyle: TextStyle(fontSize: 12),
              labelText: "Email",
              icon: Icon(Icons.email),
              border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color.fromRGBO(0, 114, 255, 1),
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(10.0)))),
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.email(context),
          ]),
        ),
      ],
    );
  }
}

class FAButton extends StatefulWidget {
  const FAButton({
    Key? key,
    required GlobalKey<FormBuilderState> formKey,
    required User user,
  })  : _formKey = formKey,
        _user = user,
        super(key: key);

  final GlobalKey<FormBuilderState> _formKey;
  final User _user;

  @override
  _FAButtonState createState() => _FAButtonState();
}

class _FAButtonState extends State<FAButton> {
  TwilioFlutter twilioFlutter = TwilioFlutter(
      accountSid: '*************************', // replace *** with Account SID
      authToken: 'xxxxxxxxxxxxxxxxxx', // replace xxx with Auth Token
      twilioNumber: '+...............' // replace .... with Twilio Number
      );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.0),
      width: double.infinity,
      child: FloatingActionButton.extended(
        onPressed: () {
          setState(() {});
          Message m = new Message.init();

          if (widget._formKey.currentState!.saveAndValidate()) {
            final formData = widget._formKey.currentState!.value;
            dynamic s = formData.values.elementAt(4);

            bool isEmail;
            if (s == "" || s == null)
              isEmail = false;
            else
              isEmail = true;

            Databasehelper()
                .getMessage(
                    widget._user.id, isEmail, formData.values.elementAt(0))
                .then((value) {
              m = value;

              Map<String, String> message = m.getMessage();

              if (message.values.elementAt(0) == "sms") {
                String messageSMS = message.values.elementAt(1);
                print(messageSMS);
                /*  twilioFlutter.sendSMS(
                    toNumber: formData.values.elementAt(4),
                    messageBody: messageSMS);*/

                final DateTime now = DateTime.now();
                final DateFormat formatter = DateFormat('yyyy-MM-dd');
                final String formatted = formatter.format(now);
                Fields2 f = new Fields2(
                    id: "id",
                    uid: widget._user.id,
                    genre: formData.values.elementAt(1),
                    nom: formData.values.elementAt(2),
                    tele: formData.values.elementAt(3),
                    email: formData.values.elementAt(4) ?? "",
                    date: formatted,
                    type: "1");

                Databasehelper().addHistory(f, widget._user.id);
              } else {
                String messageEMAIL = message.values.elementAt(2);

                //send via twilio and email
              }

              // addto history on message sent
            });

            FocusScopeNode currentScope = FocusScope.of(context);
            if (!currentScope.hasPrimaryFocus && currentScope.hasFocus) {
              FocusManager.instance.primaryFocus!.unfocus();
            }

            s = null;
            widget._formKey.currentState!.reset();
          }
        },
        isExtended: true,
        materialTapTargetSize: MaterialTapTargetSize.padded,
        icon: Icon(Icons.send_outlined),
        label: Text('Envoyer'),
      ),
    );
  }
}

/*
                      
*/

import 'package:app/apiService.dart';
import 'package:app/databasehelper.dart';
import 'package:app/models/Fields.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:twilio_flutter/twilio_flutter.dart';
import 'package:intl/intl.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'models/User.dart';
import 'models/Colorstheme.dart';
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
    return Container(
      color: Colorth.grey,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: Column(
            children: [
              FormBuilder(
                  key: _formKey,
                  child: Padding(
                      padding: const EdgeInsets.all(32.0),
                      child: FormTwillio()))
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
      ),
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
                selectedColor: Colorth.fyellow,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  labelText: 'Choisir',
                ),
                options: [
                  FormBuilderFieldOption(
                      value: 'Fr',
                      child: Text(
                        'Fr',
                        style: TextStyle(color: Colorth.black),
                      )),
                  FormBuilderFieldOption(
                    value: 'En',
                    child: Text(
                      'En',
                      style: TextStyle(color: Colorth.black),
                    ),
                  ),
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
                selectedColor: Colorth.fyellow,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  labelText: 'Choisir',
                ),
                options: [
                  FormBuilderFieldOption(
                      value: 'M',
                      child: Text(
                        'M',
                        style: TextStyle(color: Colorth.black),
                      )),
                  FormBuilderFieldOption(
                      value: 'Mme',
                      child: Text(
                        'Mme',
                        style: TextStyle(color: Colorth.black),
                      )),
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
              fillColor: Colors.white,
              filled: true,
              labelText: "Nom",
              icon: Icon(Icons.account_circle),
              border: OutlineInputBorder(
                  borderSide: BorderSide(),
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
              fillColor: Colors.white,
              filled: true,
              labelText: "Télephone",
              icon: Icon(Icons.phone),
              border: OutlineInputBorder(
                  borderSide: BorderSide(),
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
              fillColor: Colors.white,
              filled: true,
              labelText: "Email",
              icon: Icon(Icons.email),
              border: OutlineInputBorder(
                  borderSide: BorderSide(),
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
      accountSid:
          'ACedb778495ef1739e0a12e64cad0c7c23', // replace *** with Account SID
      authToken:
          '53f74d85d9d9ee3cbff723d657a619d9', // replace xxx with Auth Token
      twilioNumber: '+18722411575' // replace .... with Twilio Number
      );

  @override
  Widget build(BuildContext context) {
    final bool showFab = MediaQuery.of(context).viewInsets.bottom == 0.0;

    return Container(
      padding: EdgeInsets.all(20.0),
      width: double.infinity,
      child: Visibility(
        visible: MediaQuery.of(context).viewInsets.bottom == 0,
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

              apiService()
                  .getMessage(
                      widget._user.id, isEmail, formData.values.elementAt(0))
                  .then((value) {
                m = value;

                Map<String, String> message = m.getMessage();
                String typebd = message.values.elementAt(0);

                if (typebd == "sms") {
                  String messageSMS = message.values.elementAt(1);
                  print(messageSMS);
                  twilioFlutter.sendSMS(
                      toNumber: formData.values.elementAt(3),
                      messageBody: messageSMS);
                } else {
                  String messageSMS = message.values.elementAt(1);
                  String messageEMAIL = message.values.elementAt(2);
                  String subject = message.values.elementAt(3);
                  print(messageSMS);
                  print(messageEMAIL);
                  Future<void> send() async {
                    final Email email = Email(
                      body: messageEMAIL,
                      subject: subject,
                      recipients: [s.toString()],
                      isHTML: true,
                    );

                    String platformResponse;

                    try {
                      await FlutterEmailSender.send(email);
                      platformResponse = 'success';
                    } catch (error) {
                      platformResponse = error.toString();
                    }

                    if (!mounted) return;

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(platformResponse),
                      ),
                    );
                  }

                  send();

                  /*  twilioFlutter.sendSMS(
                      toNumber: formData.values.elementAt(4),
                      messageBody: messageSMS);*/

                  //send via twilio and email
                }
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
                    type: typebd == "sms" ? "1" : "3");

                apiService().addHistory(f);
                // addto history on message sent
              });

              FocusScopeNode currentScope = FocusScope.of(context);
              if (!currentScope.hasPrimaryFocus && currentScope.hasFocus) {
                FocusManager.instance.primaryFocus!.unfocus();
              }

              widget._formKey.currentState!.reset();
            }
          },
          isExtended: true,
          materialTapTargetSize: MaterialTapTargetSize.padded,
          icon: Icon(Icons.send_outlined, color: Colorth.black),
          label: Text(
            'Envoyer',
            style: TextStyle(color: Colorth.black),
          ),
          backgroundColor: Colorth.cyellow,
        ),
      ),
    );
  }
}

/*
                      
*/

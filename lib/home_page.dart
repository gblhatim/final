import 'package:app/databasehelper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'models/message.dart';

// ignore: camel_case_types
class AvisGoo extends StatefulWidget {
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
        child: FAButton(formKey: _formKey),
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
  })  : _formKey = formKey,
        super(key: key);

  final GlobalKey<FormBuilderState> _formKey;

  @override
  _FAButtonState createState() => _FAButtonState();
}

class _FAButtonState extends State<FAButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.0),
      width: double.infinity,
      child: FloatingActionButton.extended(
        onPressed: () {
          setState(() {});
          Message m = new Message.init();
          /* Databasehelper().getMessage("36").then((value) {
            m = value;
            setState(() {});
          });*/

          if (widget._formKey.currentState!.saveAndValidate()) {
            final formData = widget._formKey.currentState!.value;

            print(formData.values.elementAt(4));
            Databasehelper()
                .getMessage(
                    "36",
                    formData.values.elementAt(4) != null,
                    formData.values.elementAt(3) != null,
                    formData.values.elementAt(0))
                .then((value) {
              m = value;

              print(m.getMessage());
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
        icon: Icon(Icons.send_outlined),
        label: Text('Envoyer'),
      ),
    );
  }
}


/*
                      
*/
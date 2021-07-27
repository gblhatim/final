import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

// ignore: camel_case_types
class AvisGoo extends StatelessWidget {
  final _formKey = GlobalKey<FormBuilderState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Column(
          children: [
            FormBuilder(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Wrap(
                    spacing: 20, // to apply margin in the main axis of the wrap
                    runSpacing:
                        20, // to apply margin in the cross axis of the wrap
                    alignment: WrapAlignment.center,
                    children: [
                      FormBuilderChoiceChip(
                        name: 'radio_group',
                        decoration: InputDecoration(
                          labelText: 'Choisir',
                        ),
                        options: [
                          FormBuilderFieldOption(
                              value: 'Fr', child: Text('Fr')),
                          FormBuilderFieldOption(
                              value: 'En', child: Text('En')),
                        ],
                      ),

                      FormBuilderChoiceChip(
                        name: 'radio_group',
                        decoration: InputDecoration(
                          labelText: 'Choisir',
                        ),
                        options: [
                          FormBuilderFieldOption(value: 'M', child: Text('M')),
                          FormBuilderFieldOption(
                              value: 'Mme', child: Text('Mme')),
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
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)))),
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(context),
                        ]),
                      ),
                      FormBuilderTextField(
                        name: 'textfield2',
                        decoration: InputDecoration(
                            hintText: 'Entrer le numéro de téléphone',
                            hintStyle: TextStyle(fontSize: 12),
                            labelText: "Télephone",
                            icon: Icon(Icons.phone),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color.fromRGBO(0, 114, 255, 1),
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)))),
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(context),
                          FormBuilderValidators.numeric(context)
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
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)))),
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(context),
                          FormBuilderValidators.email(context),
                        ]),
                      ),
                      SizedBox(height: 20),
                      RaisedButton(
                        onPressed: () {
                          //
                          if (_formKey.currentState!.saveAndValidate()) {
                            final formData = _formKey.currentState!.value;
                            Scaffold.of(context).showSnackBar(
                              SnackBar(
                                duration: Duration(seconds: 10),
                                content: Row(
                                  children: [
                                    Expanded(
                                      child: Text('$formData',
                                          textScaleFactor: 1.5),
                                    ),
                                    RaisedButton.icon(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(50)),
                                      onPressed: () {
                                        Scaffold.of(context)
                                            .hideCurrentSnackBar();
                                      },
                                      icon: Icon(Icons.close),
                                      label: Text('Close'),
                                    )
                                  ],
                                ),
                              ),
                            );
                          }
                        },
                        child: Text('Submit'),
                      ),
                      SizedBox(height: 20),
                      // Image(
                      //   height: 300,
                      //   image: AssetImage(
                      //       'assets/images/custom_field/change_field_value.png'),
                      // )
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}

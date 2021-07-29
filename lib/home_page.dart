import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:hexcolor/hexcolor.dart';

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
                      Text(
                        "Génération des avis 5 étoiles",
                        style: TextStyle(fontSize: 25.0),
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
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(10.0))),
                                labelText: 'Choisir',
                              ),
                              options: [
                                FormBuilderFieldOption(
                                    value: 'Fr', child: Text('Fr')),
                                FormBuilderFieldOption(
                                    value: 'En', child: Text('En')),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: FormBuilderChoiceChip(
                              spacing: 5.0,
                              name: 'radio_group',
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(10.0))),
                                labelText: 'Choisir',
                              ),
                              options: [
                                FormBuilderFieldOption(
                                    value: 'M', child: Text('M')),
                                FormBuilderFieldOption(
                                    value: 'Mme', child: Text('Mme')),
                              ],
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20.0,
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
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)))),
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
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)))),
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.email(context),
                        ]),
                      ),
                    ],
                  ),
                ))
          ],
        ),
      ),
      floatingActionButton: Container(
        padding: EdgeInsets.all(20.0),
        width: double.infinity,
        child: FloatingActionButton.extended(
          onPressed: () {
            if (_formKey.currentState!.saveAndValidate()) {
              final formData = _formKey.currentState!.value;
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  duration: Duration(seconds: 10),
                  content: Row(
                    children: [
                      Expanded(
                        child: Text('$formData', textScaleFactor: 1.5),
                      ),
                    ],
                  ),
                ),
              );
            }
          },
          isExtended: true,
          materialTapTargetSize: MaterialTapTargetSize.padded,
          icon: Icon(Icons.send_outlined),
          label: Text('Envoyer'),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}


/*

                      
*/
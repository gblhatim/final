import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class Textield {
  final mController = TextEditingController();
  String nom;

  Textield({
    required this.nom,
  });
  field(mcontroller) {
    return /*Material(
      elevation: 4,
      shadowColor: Colors.grey,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child:*/
        FormBuilderTextField(
      readOnly: false,
      name: nom,
      controller: mcontroller,
      decoration: InputDecoration(
          fillColor: Colors.white30,
          filled: true,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide.none)),
    );
  }
}
    /*mcontroller,
    @required nom,)
   {
    return Material(
      elevation: 4,
      shadowColor: Colors.grey,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: FormBuilderTextField(
        readOnly: false,
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
  }*/
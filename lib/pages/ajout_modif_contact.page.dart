import 'package:flutter/material.dart';
import '../model/contact.model.dart';
import '../services/contact.service.dart';
import 'package:snippet_coder_utils/FormHelper.dart';

class AjoutModifContactPage extends StatefulWidget {
  @override
  _AjoutModifContactPageState createState() => _AjoutModifContactPageState();
}

class _AjoutModifContactPageState extends State<AjoutModifContactPage> {
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  Contact contact = Contact();
  ContactService contactService = ContactService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Page Ajouter/Modifier Contact'),
      ),
      body: Form(
        key: globalKey,
        child: _formUI(context),
      ),
      bottomNavigationBar: SizedBox(
        height: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FormHelper.submitButton(
              "Ajouter",
              () {
                if (validateAndSave()) {
                  contactService.ajouterContact(contact!).then((value) {
                    Navigator.pop(context);
                  });
                }
              },
              borderRadius: 10,
              btnColor: Colors.green,
              borderColor: Colors.green,
            ),
            FormHelper.submitButton(
              "Annuler",
              () {
                Navigator.pop(context);
              },
              borderRadius: 10,
              btnColor: Colors.grey,
              borderColor: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }

  _formUI(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            FormHelper.inputFieldWidgetWithLabel(
              context,
              "nom",
              "Nom",
              "",
              (onValidate) {
                if (onValidate.isEmpty) {
                  return "* Required";
                }
                return null;
              },
              (onSaved) {
                contact.nom = onSaved.toString().trim();
              },
              initialValue: "",
              showPrefixIcon: true,
              prefixIcon: const Icon(Icons.text_fields),
              borderRadius: 10,
              contentPadding: 15,
              fontSize: 14,
              labelFontSize: 14,
              paddingLeft: 0,
              paddingRight: 0,
              prefixIconPaddingLeft: 10,
            ),
            FormHelper.inputFieldWidgetWithLabel(
                context, "telephone", "Téléphone", "", (onValidate) {
              if (onValidate.isEmpty) {
                return "* Required";
              }
              return null;
            }, (onSaved) {
              contact.tel = int.parse(onSaved.toString().trim());
            },
                initialValue: "",
                showPrefixIcon: true,
                prefixIcon: const Icon(Icons.numbers),
                borderRadius: 10,
                contentPadding: 15,
                fontSize: 14,
                labelFontSize: 14,
                paddingLeft: 0,
                paddingRight: 0,
                prefixIconPaddingLeft: 10,
                isNumeric: true),
          ],
        ),
      ),
    );
  }

  bool validateAndSave() {
    final form = globalKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }
}

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';


class AddContact extends StatefulWidget {
  const AddContact({ Key? key }) : super(key: key);

  @override
  State<AddContact> createState() => _AddContactState();
}

class _AddContactState extends State<AddContact> {

  bool showSpinner = false;
  TextEditingController contactName = TextEditingController();
  TextEditingController contactPhone = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Contact')
      ),
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextField(
              controller: contactName,
                decoration: const InputDecoration(
                  hintText: 'Contact Name',
                ),
              ),
            ),
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextField(
              controller: contactPhone,
                decoration: const InputDecoration(
                  hintText: 'Phone Number',
                ),
              ),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () async {
                var url = Uri.parse(
                    'https://apps.ashesi.edu.gh/contactmgt/view/add_con_mobi');
                var response = await http.post(url, body: {
                  'uname': contactName.text,
                  'unumber': contactPhone.text
                });

                setState(() {
                  showSpinner = true;
                  Navigator.of(context, rootNavigator: true).pushNamed('/');
                });
              },
              child: const Text('Add Contact'),
            )
          ]
        ),
      )
    );
  }
  
}
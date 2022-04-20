import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';


class UpdateContact extends StatefulWidget {
  const UpdateContact({ Key? key }) : super(key: key);

  @override
  State<UpdateContact> createState() => _UpdateContactState();
}

class _UpdateContactState extends State<UpdateContact> {
  @override
  Widget build(BuildContext context) {
    
    final getMyData = ModalRoute.of(context)!.settings.arguments as EditContact;

    bool showSpinner = false;
    TextEditingController contactName = TextEditingController(text: getMyData.contactName);
    TextEditingController contactPhone = TextEditingController(text: getMyData.contactPhone);

    return Scaffold(
        appBar: AppBar(
          title: const Text('Update Contact'),
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
                    hintText: 'Update Name',
                  ),
                )
              ),
              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextField(
                  controller: contactPhone,
                  decoration: const InputDecoration(
                    hintText: 'Update Phone Number',
                  ),
                )
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () async {
                  var url = Uri.parse(
                      'https://apps.ashesi.edu.gh/contactmgt/view/up_date_con');
                  var response = await http.post(url, body: {
                    'conid': getMyData.contactID,
                    'uname': contactName.text,
                    'unumber': contactPhone.text
                  });

                  setState(() {
                    showSpinner = true;
                    Navigator.of(context, rootNavigator: true).pushNamed('/');
                  });
                },
                child: const Text('Update Contact'),
              )
            ],
          ),
        )
    );
  }
}

class EditContact {
  final String contactID;
  final String contactName;
  final String contactPhone;

  EditContact(this.contactID, this.contactName, this.contactPhone);
}


// Column(
//           children: <Widget>[
//             const Text('Update a Contact'),
//             TextField(
//               controller: contactName,
//               decoration: const InputDecoration(
//                 border: OutlineInputBorder(),
//                 hintText: 'update Name',
//               ),
//             ),
//             TextField(
//               controller: contactPhone,
//               maxLength: 10,
//               decoration: const InputDecoration(
//                 border: OutlineInputBorder(),
//                 hintText: 'update Number',
//               ),
//             ),
//             ElevatedButton(
//               onPressed: () async {
//                 var url = Uri.parse(
//                     'https://apps.ashesi.edu.gh/contactmgt/view/up_date_con');
//                 var response = await http.post(url, body: {
//                   'conid': getMyData.contactID,
//                   'uname': contactName.text,
//                   'unumber': contactPhone.text
//                 });

//                 Navigator.pushNamed(context, '/');
//               },
//               child: const Text('Update Contact'),
//             )
//           ],
//         ));
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lab_crud/view/view_contact_page.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:lab_crud/view/add_contact_page.dart';
import 'package:lab_crud/view/update_contact_page.dart';

class HomeContacts extends StatefulWidget {
  const HomeContacts({Key? key}) : super(key: key);

  @override
  State<HomeContacts> createState() => _HomeContactsState();
}

class _HomeContactsState extends State<HomeContacts> {
    List users = [];
    bool showSpinner = false;


    Future getContacts() async {
      var url = Uri.parse('https://apps.ashesi.edu.gh/contactmgt/view/getallcontact');
      final response = await http.get(url);

      setState((){
        showSpinner = false;
        users = jsonDecode(response.body);
      });   
    }


    void deleteContactMethod(contactID) async {
      var url = Uri.parse('https://apps.ashesi.edu.gh/contactmgt/view/delcontact');
      var response = await http.post(url, body: {'ppid': contactID});

      setState(() {
        showSpinner = false;
        getContacts();
      });
      
    }



    @override
    void initState() {
      super.initState();
      showSpinner = true;
      getContacts();
    }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Contacts'),
      ),
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Container(
          child: ListView.separated(
            separatorBuilder: (BuildContext context, int index) => Divider(height: 2),
            itemCount: users.length,
            itemBuilder: (context, index){
              return ListTile(
                leading: const Icon(Icons.account_circle, size: 50.0),
                title: Text(users[index]['pname']),
                subtitle: Text(users[index]['pphone']),
                onTap: (){
                  Navigator.of(context, rootNavigator:true).pushNamed('view',
                    arguments: OneContact(users[index]['pname'],
                            users[index]['pphone']),
                  );
                },
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    IconButton(
                      onPressed: ()=>{
                        Navigator.of(context, rootNavigator:true).pushNamed('edit',
                          arguments: EditContact(users[index]['pid'],
                            users[index]['pname'],
                            users[index]['pphone']),
                        )
                      }, 
                      icon: const Icon(Icons.edit)
                    ),
                    IconButton(
                      onPressed: ()=>{
                        _showMyDialog(index)
                      }, 
                      icon: const Icon(Icons.delete)
                    ),
                  ],
                ),
              );
            }
          )
        ),
      )
    );
  }


  Future<void> _showMyDialog(index) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Are you sure you want to delete this contact?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Yes', style: TextStyle(color: Colors.green, fontSize:18.0)),
              onPressed: () {
                setState(() {
                  Navigator.of(context).pop();
                  deleteContactMethod(users[index]['pid']);
                  showSpinner = true;
                  
                });
              },
            ),
            TextButton(
              child: const Text('No', style: TextStyle(color: Colors.red, fontSize:18.0)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

}



//delete and update contact as subpages
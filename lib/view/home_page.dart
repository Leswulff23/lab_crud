import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lab_crud/view/add_contact_page.dart';
import 'package:lab_crud/view/update_contact_page.dart';

class HomeContacts extends StatefulWidget {
  const HomeContacts({Key? key}) : super(key: key);

  @override
  State<HomeContacts> createState() => _HomeContactsState();
}

class _HomeContactsState extends State<HomeContacts> {
    List users = [];


    Future getContacts() async {
      var url = Uri.parse('https://apps.ashesi.edu.gh/contactmgt/view/getallcontact');
      final response = await http.get(url);
      if (mounted) { 
        setState((){
          users = jsonDecode(response.body);
        });  
      }
    }

    @override
    void initState() {
      super.initState();
      getContacts();
    }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Contacts'),
      ),
      body: Container(
        child: ListView.separated(
          separatorBuilder: (BuildContext context, int index) => Divider(height: 2),
          itemCount: users.length,
          itemBuilder: (context, index){
            return ListTile(
              leading: const Icon(Icons.account_circle, size: 50.0),
              title: Text(users[index]['pname']),
              subtitle: Text(users[index]['pphone']),
              onTap: (){
                
              },
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  IconButton(
                    onPressed: ()=>{
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const UpdateContact(),
                        ),
                      )
                    }, 
                    icon: const Icon(Icons.edit)
                  ),
                  IconButton(
                    onPressed: ()=>{
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AddContact(),
                        ),
                      )
                    }, 
                    icon: const Icon(Icons.delete)
                  ),
                ],
              ),
            );
          }
        )
      )
    );
  }
}



//delete and update contact as subpages
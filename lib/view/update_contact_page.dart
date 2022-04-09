import 'package:flutter/material.dart';


class UpdateContact extends StatefulWidget {
  const UpdateContact({ Key? key }) : super(key: key);

  @override
  State<UpdateContact> createState() => _UpdateContactState();
}

class _UpdateContactState extends State<UpdateContact> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Contact')
      ),

    );
  }
}
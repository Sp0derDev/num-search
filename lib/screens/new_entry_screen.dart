import 'dart:async';
import 'dart:html';

import 'package:flutter/material.dart';
import 'package:num_search/components/constants.dart';
import 'package:num_search/components/standard_text_field.dart';
import 'package:num_search/models/entry_record.dart';
import 'package:num_search/models/query_response.dart';
import 'package:num_search/models/user.dart';
import 'package:num_search/services/database.dart';
import 'package:provider/provider.dart';
// import 'package:rounded_loading_button/rounded_loading_button.dart';

class NewEntryScreen extends StatefulWidget {
  @override
  _NewEntryScreenState createState() => _NewEntryScreenState();
}

class _NewEntryScreenState extends State<NewEntryScreen> {
  TextEditingController titleFieldController = TextEditingController();
  TextEditingController numberFieldController = TextEditingController();
  TextEditingController linkFieldController = TextEditingController();
  Database db = Database();
  // final RoundedLoadingButtonController _addBtnController =
  //     new RoundedLoadingButtonController();

  @override
  Widget build(BuildContext context) {
    SiteUser user = Provider.of<SiteUser>(context);
    // Future _addToDb(EntryRecord record) async {
    //   _addBtnController.start();
    //   QueryResponse response = await db.addEntryRecord(record, user);
    //   if (response.sucess) {
    //     _addBtnController.success();
    //     Timer(Duration(seconds: 2), () {
    //       Navigator.pushReplacementNamed(context, '/dashboard');
    //     });
    //   } else {
    //     _addBtnController.error();
    //     Timer(Duration(seconds: 2), () {
    //       _addBtnController.reset();
    //     });
    //   }
    // }

    return Scaffold(
      appBar: AppBar(title: Text('New Entry')),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            StandardTextField(
                controller: titleFieldController,
                icon: Icons.title,
                hintText: 'Title',
                keyboardType: TextInputType.text,
                topBorders: 20,
                maxLength: 100),
            SizedBox(
              height: 10,
            ),
            StandardTextField(
                controller: numberFieldController,
                icon: Icons.dialpad,
                hintText: 'Number',
                keyboardType: TextInputType.number,
                topBorders: 0,
                maxLength: 100),
            SizedBox(
              height: 10,
            ),
            StandardTextField(
                controller: linkFieldController,
                icon: Icons.link,
                hintText: 'Link',
                keyboardType: TextInputType.number,
                topBorders: 0,
                maxLength: 100),
            SizedBox(
              height: 30,
            ),
            // RoundedLoadingButton(
            //   controller: _addBtnController,
            //   width: MediaQuery.of(context).size.width * 0.7,
            //   height: 50,
            //   color: kThemeColor,
            //   onPressed: () => _addToDb(EntryRecord(
            //       title: titleFieldController.value.text,
            //       type: EntryType.Link,
            //       number: int.parse(numberFieldController.value.text),
            //       url: linkFieldController.value.text)),
            //   child: Text(
            //     "Add To Database",
            //     style: TextStyle(
            //         color: Colors.white,
            //         fontSize: 16,
            //         fontWeight: FontWeight.w700),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}

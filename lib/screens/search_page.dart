import 'dart:async';

import 'package:flutter/material.dart';
import 'package:num_search/components/constants.dart';
import 'package:num_search/components/standard_text_field.dart';
import 'package:num_search/models/query_response.dart';
import 'package:num_search/services/auth.dart';
import 'package:num_search/services/database.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:url_launcher/url_launcher.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController numberFieldController = TextEditingController();
  Database db = Database();
  final RoundedLoadingButtonController _searchBtnController =
      new RoundedLoadingButtonController();

  Future _findEntry() async {
    _searchBtnController.start();
    QueryResponse response = await db.findEntry('Eud1aZTzdDhy2RjJYVNl659yVj93',
        int.parse(numberFieldController.value.text));
    if (response.sucess) {
      _searchBtnController.success();
      Timer(Duration(seconds: 2), () {
        launch(response.result.url);
        _searchBtnController.reset();
      });
    } else {
      _searchBtnController.error();
      Timer(Duration(seconds: 2), () {
        _searchBtnController.reset();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search'),
        automaticallyImplyLeading: false,
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            StandardTextField(
                controller: numberFieldController,
                icon: Icons.dialpad,
                hintText: 'Number',
                keyboardType: TextInputType.number,
                topBorders: 0,
                maxLength: 5),
            SizedBox(
              height: 10,
            ),
            RoundedLoadingButton(
              controller: _searchBtnController,
              width: MediaQuery.of(context).size.width * 0.4,
              height: 50,
              color: kThemeColor,
              onPressed: () => _findEntry(),
              child: Text(
                "View Content",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w700),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

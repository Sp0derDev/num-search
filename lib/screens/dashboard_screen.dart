import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:num_search/components/constants.dart';
import 'package:num_search/models/entry_record.dart';
import 'package:num_search/models/query_response.dart';
import 'package:num_search/models/user.dart';
import 'package:num_search/services/database.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  Database db = Database();
  EntryRecord record = EntryRecord(
      number: 710,
      type: EntryType.Link,
      title: 'InstagramAccount',
      url: 'https://instagram.com/710x');
  @override
  List<EntryRecord> records = [];

  Widget build(BuildContext context) {
    SiteUser user = Provider.of<SiteUser>(context);
    Future<List<EntryRecord>> _getAllRecords() async {
      QueryResponse response = await db.getAllRecords(user);
      return response.result;
    }

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(CupertinoIcons.plus),
        onPressed: () => Navigator.pushNamed(context, '/new_entry'),
      ),
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              height: 500,
              margin: EdgeInsets.all(20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color(0xFFE7E5E5)),
              child: FutureBuilder<List<EntryRecord>>(
                future: _getAllRecords(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        padding: EdgeInsets.all(8),
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext context, int index) {
                          return EntryCard(
                            record: snapshot.data[index],
                          );
                        });
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ))
        ],
      ),
    );
  }
}

class EntryCard extends StatelessWidget {
  EntryRecord record;
  EntryCard({Key key, this.record}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15.0),
        child: ListTile(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          onTap: () {},
          title: Text(
            record.title,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
          ),
          subtitle: Text(record.url,
              style: TextStyle(
                  color: Colors.white70, fontWeight: FontWeight.w500)),
          leading: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Color(0xFF164451)),
            alignment: Alignment.center,
            width: 70,
            height: 200,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                record.number.toString(),
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w900),
              ),
            ),
          ),
          trailing: Icon(
            Icons.share_outlined,
            color: Colors.white,
          ),
          tileColor: Color(0xFFF2784B),
        ),
      ),
    );
  }
}

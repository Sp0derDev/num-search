import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:num_search/components/constants.dart';
import 'package:num_search/models/entry_record.dart';
import 'package:num_search/models/query_response.dart';
import 'package:num_search/models/user.dart';
import 'package:num_search/services/auth.dart';
import 'package:num_search/services/database.dart';
import 'package:provider/provider.dart';
import 'package:tinycolor/tinycolor.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  Database db = Database();
  AuthService auth = AuthService();
  // EntryRecord record = EntryRecord(
  //     number: 710,
  //     type: EntryType.Link,
  //     title: 'InstagramAccount',
  //     url: 'https://instagram.com/710x');
  @override
  List<EntryRecord> records = [];

  Widget build(BuildContext context) {
    // SiteUser streamUser = Provider.of<SiteUser>(context);
    Future<List<EntryRecord>> _getAllRecords(SiteUser user) async {
      QueryResponse response = await db.getAllRecords(user);
      return response.result;
    }

    // Future<void> deleteFromDataBase(int index) async {
    //   Future.delayed(Duration(milliseconds: 500)).then((_) {
    //     lst.removeAt(index);
    //   });
    // }

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(CupertinoIcons.plus),
        onPressed: () => Navigator.pushNamed(context, '/new_entry'),
      ),
      body: FutureBuilder<SiteUser>(
          future: auth.getUser,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              SiteUser user = snapshot.data;
              return Center(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Color(0xff6441A5), Color(0xff2a0845)],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          margin: EdgeInsets.all(20),
                          padding: EdgeInsets.all(20),
                          constraints: BoxConstraints(maxWidth: 500),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Color(0xFFF3F3F3)),
                          alignment: Alignment.centerLeft,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.only(right: 15),
                                child: CachedNetworkImage(
                                  imageUrl: user.profilePic,
                                  progressIndicatorBuilder:
                                      (context, url, downloadProgress) =>
                                          CircularProgressIndicator(
                                              value: downloadProgress.progress),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
                                  imageBuilder: (context, imageProvider) =>
                                      CircleAvatar(
                                    radius: 40,
                                    backgroundImage: imageProvider,
                                  ),
                                ),
                              ),
                              Text(
                                'Hello, ',
                                style: GoogleFonts.roboto(
                                    fontWeight: FontWeight.w600, fontSize: 30),
                              ),
                              Text(
                                user.username,
                                style: GoogleFonts.roboto(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 30,
                                    color: Colors.deepPurple),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          )),
                      Container(
                        height: 500,
                        width: 500,
                        margin: EdgeInsets.all(20),
                        constraints: BoxConstraints(maxWidth: 500),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white),
                        child: FutureBuilder<List<EntryRecord>>(
                          future: _getAllRecords(user),
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            if (snapshot.hasData) {
                              return ListView.builder(
                                  padding: EdgeInsets.all(8),
                                  itemCount: snapshot.data.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return EntryCard(
                                      record: snapshot.data[index],
                                      index: index,
                                    );
                                  });
                            } else {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                          },
                        ),
                      ),
                      ElevatedButton(
                          onPressed: () async {
                            await auth.signOut();
                            Navigator.of(context).pushNamedAndRemoveUntil(
                                '/', (Route<dynamic> route) => false);
                          },
                          child: Text('Sign Out'))
                    ],
                  ),
                ),
              );
            } else {
              return Container(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
          }),
    );
  }
}

class EntryCard extends StatelessWidget {
  EntryRecord record;
  int index;
  EntryCard({Key key, this.record, this.index}) : super(key: key);
  List<Color> colors = [kLightOrange, kLightPurple, kLightBlue, kLightPink];
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [Colors.white, TinyColor(colors[index]).darken(8).color],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight),
        borderRadius: BorderRadius.circular(20),
      ),
      child: ListTile(
        title: Text(
          record.title,
          style: TextStyle(
              color: TinyColor(colors[index]).darken(30).color,
              fontWeight: FontWeight.w500),
        ),
        subtitle: Text(record.url,
            style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w500)),
        leading: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: TinyColor(colors[index]).darken(30).color),
          alignment: Alignment.center,
          width: 80,
          height: 200,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              record.number.toString(),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
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
        // tileColor: Color(0xFFF2784B),
      ),
    );
  }
}

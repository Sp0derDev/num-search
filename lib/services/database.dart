import 'package:num_search/models/entry_record.dart';
import 'package:num_search/models/query_response.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:num_search/models/user.dart';

class Database {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  Future<QueryResponse> addEntryRecord(
      EntryRecord record, SiteUser user) async {
    //Todo: Add num check

    try {
      DocumentReference usersRef = _db.collection('users').doc(user.uid);
      // Map<String, dynamic> oldData =
      //     await usersRef.get().then((snapshot) => snapshot.data());
      //  {record.number:FieldValue.arrayUnion([record.toMap]}
      await usersRef
          .update({'numbers.' + record.number.toString(): record.toMap});

      return QueryResponse(sucess: true);
    } catch (error) {
      print(error);
      return QueryResponse(sucess: false, errorMessage: error.toString());
    }
  }

  Future<QueryResponse> getAllRecords(SiteUser user) async {
    //Todo: Add num check

    try {
      DocumentReference usersRef = await _db.collection('users').doc(user.uid);
      Map<String, dynamic> userData =
          await usersRef.get().then((snapshot) => snapshot.data());

      List<EntryRecord> entries =
          new Map<String, dynamic>.from(userData["numbers"])
              .values
              .map((e) => EntryRecord.fromMap(e))
              .toList();

      return QueryResponse(sucess: true, result: entries);
    } catch (error) {
      print(error);
      return QueryResponse(sucess: false, errorMessage: error.toString());
    }
  }

  Future<QueryResponse> findEntry(String pageName, int number) async {
    //Todo: Add num check

    try {
      DocumentReference usersRef = await _db.collection('users').doc(pageName);
      Map<String, dynamic> userData =
          await usersRef.get().then((snapshot) => snapshot.data());

      Map entry = (userData["numbers"][number.toString()]);
      if (entry == null) {
        return QueryResponse(sucess: false, errorMessage: 'Number Not Found');
      }
      EntryRecord entryRecord = EntryRecord.fromMap(entry);
      print(entryRecord.title);
      return QueryResponse(sucess: true, result: entryRecord);
    } catch (error) {
      print(error);
      return QueryResponse(sucess: false, errorMessage: error.toString());
    }
  }
}

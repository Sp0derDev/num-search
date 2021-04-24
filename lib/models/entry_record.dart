import 'package:num_search/components/constants.dart';

class EntryRecord {
  final int number;
  final EntryType type;
  final String title;
  final String url;

  EntryRecord({this.number, this.type, this.title, this.url});
  Map get toMap => {
        'number': this.number,
        'title': this.title,
        'url': this.url,
        'type': this.type.stringType,
      };

  factory EntryRecord.fromMap(Map data) {
    print(data['number']);
    return EntryRecord(
        number: data['number'] ?? 'N/A',
        type:
            (data['type'] == 'link' ? EntryType.Link : EntryType.Text) ?? 'N/A',
        url: data['url'],
        title: data['title']);
  }
}

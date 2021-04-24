class SiteUser {
  final String uid;
  final String username;
  final String profilePic;
  final String email;
  String pageName;

  SiteUser({
    this.uid,
    this.profilePic,
    this.username,
    this.email,
  });

  factory SiteUser.fromMap(Map data) {
    print(data);
    return SiteUser(
        uid: data['uid'] ?? 'N/A',
        profilePic: data['profilePic'] ?? 'N/A',
        username: data['username'] ?? 'N/A',
        email: data['email'] ?? 'N/A');
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/firebase.dart';

import 'package:firebase/firebase.dart' as firebase;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:num_search/models/user.dart';

class AuthService {
  final Auth _auth = firebase.auth();
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  final GoogleSignIn _googleSignIn = GoogleSignIn();

  SiteUser _customModelForFirebaseUser(User user) {
    print(user);
    print(user.displayName);
    return user != null
        ? SiteUser(
            uid: user.uid ?? 'N/A',
            username: user.displayName ?? 'N/A',
            profilePic: user.photoURL ?? 'N/A',
            email: user.email ?? 'N/A')
        : null;
  }

  // auth changed user stream
  Stream<SiteUser> get user {
    return _auth.onAuthStateChanged.map(_customModelForFirebaseUser);
  }

  //User get getUser => FirebaseAuth.instance.currentUser;
  Future<SiteUser> get getUser async =>
      _customModelForFirebaseUser(await _auth.currentUserAsync);

  //Stream<FirebaseUser> get user => _auth.onAuthStateChanged;

  Future<User> googleSignIn() async {
    try {
      GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
      GoogleSignInAuthentication googleAuth =
          await googleSignInAccount.authentication;

      final OAuthCredential credential = GoogleAuthProvider.credential(
        googleAuth.idToken,
        googleAuth.accessToken,
      );
      UserCredential result = await _auth.signInWithCredential(credential);
      User user = result.user;
      updateUserData(user);
      return user;
    } catch (error) {
      print(error);
      return null;
    }
  }

  Future<void> updateUserData(User user) async {
    DocumentReference usersRef = _db.collection('users').doc(user.uid);
    Map<String, dynamic> oldData =
        await usersRef.get().then((snapshot) => snapshot.data());
    if (oldData['numbers'] == null) {
      print('New User!');
      return usersRef.set(
        {'uid': user.uid, 'lastActivity': DateTime.now(), 'numbers': []},
        SetOptions(merge: true),
      );
    } else {
      print('Existing User');
      return usersRef.set(
        {'uid': user.uid, 'lastActivity': DateTime.now()},
        SetOptions(merge: true),
      );
    }
  }

  Future<void> signOut() {
    return _auth.signOut();
  }
}

import 'package:eden_tech_test/domain/models/authorized_user.dart';
import 'package:eden_tech_test/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

final class FbAuthService {
  // static const _scopes = <String>[
  //   'email',
  //   // 'profile',
  // ];
  static final instance = FbAuthService._();

  late final FirebaseAuth _auth;

  Stream<AuthorizedUser?> get authorizedUserStream => FirebaseAuth.instance
      .authStateChanges()
      .map(
        (e) => e?.toAuthorizedUser(),
      )
      .asBroadcastStream();

  FbAuthService._();

  Future<void> init() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    _auth = FirebaseAuth.instance;
  }

  Future<User?> signInWithGoogle() async {
    final googleSignIn = GoogleSignIn();
    final googleUser = await googleSignIn.signIn();
    if (googleUser == null) {
      return null;
    }

    final googleAuth = await googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final userCredential = await _auth.signInWithCredential(credential);
    return userCredential.user;
  }

  Future<void> signOut() async {
    await _auth.signOut();
    final googleSignIn = GoogleSignIn();
    await googleSignIn.signOut();
  }
}

extension on User {
  AuthorizedUser toAuthorizedUser() {
    return AuthorizedUser(
      id: uid,
      email: email ?? '',
      displayName: displayName ?? '',
      photoUrl: photoURL ?? '',
    );
  }
}

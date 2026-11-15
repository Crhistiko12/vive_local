import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInDataSource {
  bool _initialized = false;

  Future<GoogleSignInAccount> authenticate() async {
    final googleSignIn = GoogleSignIn.instance;
    if (!_initialized) {
      await googleSignIn.initialize();
      _initialized = true;
    }
    return googleSignIn.authenticate();
  }

  Future<void> signOut() async {
    if (!_initialized) {
      return;
    }
    await GoogleSignIn.instance.signOut();
  }
}

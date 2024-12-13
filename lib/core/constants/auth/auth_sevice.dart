import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

final authServicesProvider =  AuthServices(
    auth: FirebaseAuth.instance,
    googleSignIn: GoogleSignIn(),
  );

class AuthServices {
  FirebaseAuth auth;
  GoogleSignIn googleSignIn;
  AuthServices({required this.auth, required this.googleSignIn});

  Future<User?> signInWithGoogle() async {
    try {
      // Memulai proses Google Sign-In
      final user = await googleSignIn.signIn();

      if (user == null) {
        // Pengguna membatalkan proses Google Sign-In
        throw Exception('Google Sign-In was cancelled.');
      }

      // Mendapatkan autentikasi Google
      final googleAuth = await user.authentication;

      // Membuat kredensial Firebase
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Masuk ke Firebase menggunakan kredensial Google
      final userCredential = await auth.signInWithCredential(credential);

      return userCredential.user;
    } catch (e) {
      // Menangkap error dan menampilkannya
      print('Error during Google Sign-In: $e');
      rethrow;
    }
  }
   Future<void> signOut() async {
    try {
      await auth.signOut();
      await googleSignIn.signOut();
      print('User signed out successfully.');
    } catch (e) {
      print('Error during sign-out: $e');
    }
  }
}

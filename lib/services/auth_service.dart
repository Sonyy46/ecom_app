import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // Stream of user changes
  Stream<User?> get userChanges => _firebaseAuth.userChanges();

  // Get current user
  User? get currentUser => _firebaseAuth.currentUser;

  // Sign in with email and password
  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  // Create user with email and password
  Future<void> createUserWithEmailAndPassword({
    required String email,
    required String password,
    String? displayName,
  }) async {
    print('DEBUG: Creating user with displayName: $displayName'); // Debug
    final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    // Update display name if provided
    if (displayName != null && displayName.isNotEmpty) {
      print('DEBUG: Updating display name to: $displayName'); // Debug
      await userCredential.user?.updateDisplayName(displayName);
      // Reload the user to get the updated profile
      await userCredential.user?.reload();
      // Force refresh the current user instance
      await _firebaseAuth.currentUser?.reload();
      print(
        'DEBUG: Display name after update: ${_firebaseAuth.currentUser?.displayName}',
      ); // Debug
    }
  }

  // Send password reset email
  Future<void> sendPasswordResetEmail({required String email}) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email);
  }

  // Sign out
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}

import 'package:ecom_app/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Provider for AuthService
final authServiceProvider = Provider<AuthService>((ref) {
  return AuthService();
});

// Stream of authentication state changes
final authStateProvider = StreamProvider<User?>((ref) {
  final authService = ref.watch(authServiceProvider);
  return authService.userChanges;
});

// Controller to handle Auth UI actions (Sign In, Sign Up, Sign Out, Reset Password)
// Using AsyncNotifier to easily handle loading/error states in UI
class AuthController extends AsyncNotifier<void> {
  @override
  Future<void> build() async {
    // No initial state to build
  }

  Future<void> signIn(String email, String password) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      try {
        await ref
            .read(authServiceProvider)
            .signInWithEmailAndPassword(email: email, password: password);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found' || e.code == 'invalid-credential') {
          throw 'Account does not exist or incorrect details. Please create an account or check your input.';
        } else if (e.code == 'wrong-password') {
          throw 'Incorrect password. Please try again.';
        } else if (e.code == 'invalid-email') {
          throw 'The email address is badly formatted.';
        } else if (e.code == 'user-disabled') {
          throw 'This user account has been disabled.';
        }
        throw e.message ?? 'An error occurred during sign in.';
      } catch (e) {
        throw 'An unexpected error occurred: ${e.toString()}';
      }
    });
  }

  Future<void> signUp(
    String email,
    String password, {
    String? displayName,
  }) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      try {
        print('DEBUG: Signing up with displayName: $displayName'); // Debug
        await ref
            .read(authServiceProvider)
            .createUserWithEmailAndPassword(
              email: email,
              password: password,
              displayName: displayName,
            );
        print('DEBUG: Signup completed'); // Debug
      } on FirebaseAuthException catch (e) {
        if (e.code == 'email-already-in-use') {
          throw 'An account already exists for that email.';
        } else if (e.code == 'weak-password') {
          throw 'The password provided is too weak.';
        } else if (e.code == 'invalid-email') {
          throw 'The email address is badly formatted.';
        }
        throw e.message ?? 'An error occurred during sign up.';
      } catch (e) {
        throw 'An unexpected error occurred: ${e.toString()}';
      }
    });
  }

  Future<void> resetPassword(String email) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      try {
        await ref
            .read(authServiceProvider)
            .sendPasswordResetEmail(email: email);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          throw 'No account found with this email.';
        } else if (e.code == 'invalid-email') {
          throw 'The email address is badly formatted.';
        }
        throw e.message ?? 'An error occurred during password reset.';
      } catch (e) {
        throw 'An unexpected error occurred: ${e.toString()}';
      }
    });
  }

  Future<void> signOut() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref.read(authServiceProvider).signOut(),
    );
  }
}

final authControllerProvider = AsyncNotifierProvider<AuthController, void>(() {
  return AuthController();
});

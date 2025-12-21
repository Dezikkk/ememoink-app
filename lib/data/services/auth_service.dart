import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:async';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:extension_google_sign_in_as_googleapis_auth/extension_google_sign_in_as_googleapis_auth.dart';
import 'package:googleapis_auth/googleapis_auth.dart' as auth;

class GoogleAuthService {
  static final String? webClientId = dotenv.env['GOOGLE_WEB_CLIENT_ID'];
  static final String? webClientSecret = dotenv.env['GOOGLE_WEB_CLIENT_SECRET'];

  static const List<String> scopes = <String>[
    'https://www.googleapis.com/auth/calendar.events',
    'https://www.googleapis.com/auth/tasks',
  ];

  final _googleSignIn = GoogleSignIn.instance;
  bool _isInitialized = false;

  Future<void> get isInitialized => _ensureGoogleSignInInitialized();

  GoogleAuthService() {
    _initializeGoogleSignIn();
  }

  Stream<GoogleSignInAuthenticationEvent> get authenticationEvents =>
      _googleSignIn.authenticationEvents;

  Future<void> _initializeGoogleSignIn() async {
    if (_isInitialized) return;

    try {
      await _googleSignIn.initialize(serverClientId: webClientId).then((_) {});
      _isInitialized = true;
      debugPrint('Google Sign-In initialized successfully');
    } catch (e) {
      debugPrint('Failed to initialize Google Sign-In: $e');
      rethrow;
    }
  }

  /// Always check Google sign in initialization before use
  Future<void> _ensureGoogleSignInInitialized() async {
    if (!_isInitialized) {
      await _initializeGoogleSignIn();
    }
  }

  Future<GoogleSignInAccount?> authenticate() async {
    await _ensureGoogleSignInInitialized();

    try {
      final account = await _googleSignIn.authenticate(scopeHint: scopes);
      debugPrint('Authentication successful: ${account.email}');
      return account;
    } on GoogleSignInException catch (e) {
      debugPrint(
        'Google Sign In error: code: ${e.code.name} description:${e.description} details:${e.details}, error: $e',
      );
      rethrow;
    } catch (error) {
      debugPrint('Unexpected Google Sign-In error: $error');
      rethrow;
    }
  }

  Future<void> signOut() async {
    await _ensureGoogleSignInInitialized();

    try {
      await _googleSignIn.signOut();
    } catch (e) {
      debugPrint('Sign-out error: $e');
      rethrow;
    }
  }

  Future<void> disconnect() async {
    await _ensureGoogleSignInInitialized();

    try {
      await _googleSignIn.disconnect();
    } catch (e) {
      debugPrint('Disconnect error: $e');
      rethrow;
    }
  }

  Future<GoogleSignInAccount?> attemptSilentSignIn() async {
    await _ensureGoogleSignInInitialized();

    try {
      final result = _googleSignIn.attemptLightweightAuthentication();

      if (result is Future<GoogleSignInAccount?>) {
        return await result;
      } else {
        return result as GoogleSignInAccount?;
      }
    } catch (error) {
      debugPrint('Silent sign-in failed: $error');
      return null;
    }
  }

  Future<auth.AuthClient?> getAuthClient() async {
    await _ensureGoogleSignInInitialized();

    try {
      final authClient = _googleSignIn.authorizationClient;
      var authorization = await authClient.authorizationForScopes(scopes);

      if (authorization == null) {
        debugPrint('No authorization - requesting scopes');
        authorization = await authClient.authorizeScopes(scopes);
      }

      debugPrint('Authorization successful');
      return authorization.authClient(scopes: scopes);
    } catch (error) {
      debugPrint('Failed to get auth client for scopes: $error');
      return null;
    }
  }
}

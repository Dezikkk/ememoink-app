import 'dart:async';
import 'package:flutter/material.dart';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis_auth/googleapis_auth.dart' as auth;

import 'package:ememoink/config/di.dart';
import 'package:ememoink/data/services/auth_service.dart';

class GoogleAuthRepository extends ChangeNotifier {
  final GoogleAuthService _googleAuthService;

  GoogleSignInAccount? _currentUser;
  String? _error;
  bool _isLoading = false;
  StreamSubscription<GoogleSignInAuthenticationEvent>? _authSubscription;

  GoogleSignInAccount? get currentUser => _currentUser;
  String? get userName => _currentUser?.displayName;
  String? get userEmail => _currentUser?.email;
  String? get userPhotoUrl => _currentUser?.photoUrl;
  bool get isSignedIn => _currentUser != null;
  String? get error => _error;
  bool get isLoading => _isLoading;

  GoogleAuthRepository({GoogleAuthService? googleAuthService})
    : _googleAuthService = googleAuthService ?? getIt<GoogleAuthService>() {
    init();
  }

  void init() {
    _authSubscription = _googleAuthService.authenticationEvents.listen(
      _handleAuthenticationEvent,
      onError: _handleAuthenticationError,
    );

    _attemptSilentSignIn();
  }

  void _handleAuthenticationEvent(GoogleSignInAuthenticationEvent event) {
    switch (event) {
      case GoogleSignInAuthenticationEventSignIn():
        _currentUser = event.user;
        debugPrint('User signed in: ${event.user.email}');
        notifyListeners();
        break;

      case GoogleSignInAuthenticationEventSignOut():
        _currentUser = null;
        debugPrint('User signed out');
        notifyListeners();
        break;
    }
  }

  void _handleAuthenticationError(Object error) {
    debugPrint('Authentication error: $error');
    _error = 'Authentication error: $error';
    notifyListeners();
  }

  Future<void> _attemptSilentSignIn() async {
    _currentUser = await _googleAuthService.attemptSilentSignIn();

    if (_currentUser != null) {
      debugPrint('Session restored: ${_currentUser!.email}');
      notifyListeners();
    }
  }

  Future<bool> signIn() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _currentUser = await _googleAuthService.authenticate();
      return true;
    } on GoogleSignInException catch (e) {
      if (e.code != GoogleSignInExceptionCode.canceled) {
        _error = 'Sign in error: ${e.code.name}';
      }
      return false;
    } catch (e) {
      _error = 'Unexpected error: $e';
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> signOut() async {
    _isLoading = true;
    notifyListeners();

    try {
      await _googleAuthService.signOut();
      _currentUser = null;
    } catch (e) {
      _error = 'Logout error: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<auth.AuthClient?> getAuthorizedClient() async {
    if (_currentUser == null) await _attemptSilentSignIn();
    if (_currentUser == null) return null;
    return await _googleAuthService.getAuthClient();
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }

  @override
  void dispose() {
    _authSubscription?.cancel();
    super.dispose();
  }
}

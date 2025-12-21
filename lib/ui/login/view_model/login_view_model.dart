import 'package:ememoink/config/di.dart';
import 'package:ememoink/data/repositories/auth_repository.dart';
import 'package:flutter/material.dart';

class LoginViewModel extends ChangeNotifier {
  final GoogleAuthRepository authRepo;

  LoginViewModel({GoogleAuthRepository? authRepo})
    : authRepo = authRepo ?? getIt<GoogleAuthRepository>();
}

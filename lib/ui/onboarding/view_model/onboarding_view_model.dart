import 'package:ememoink/config/di.dart';
import 'package:ememoink/data/services/onboarding_service.dart';
import 'package:ememoink/ui/login/login_screen.dart';
import 'package:flutter/material.dart';

class OnboardingViewModel extends ChangeNotifier {
  OnboardingViewModel();

  final controller = PageController();

  int _currentPage = 0;
  final int _pageCount = 2;
  final int _animDuration = 600;

  int get currentPage => _currentPage;
  int get animDuration => _animDuration;
  int get pageCount => _pageCount;

  bool get isFirstPage => _currentPage == 0;
  bool get isLastPage => _currentPage >= _pageCount;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void nextPage(BuildContext context) {
    if (_currentPage < _pageCount) {
      _currentPage++;
      controller.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: _animDuration),
        curve: Curves.easeInOut,
      );
      notifyListeners();
    } else if (currentPage >= _pageCount) {
      getIt<OnboardingService>().complete();

      Navigator.of(
        context,
      ).pushReplacement(MaterialPageRoute(builder: (_) => const LoginScreen()));
    }
  }

  void previousPage() {
    if (_currentPage > 0) {
      _currentPage--;
      controller.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: _animDuration),
        curve: Curves.easeInOut,
      );
      notifyListeners();
    }
  }

  void skipToEnd() {
    _currentPage = _pageCount;
    controller.jumpToPage(_pageCount);
    notifyListeners();
  }
}

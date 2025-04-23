import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stem_vault/Core/appColors.dart';
import 'package:stem_vault/features/role_selection_page.dart';
import '../../Shared/DotIndicator.dart';
import 'FirstPage.dart';
import 'SecondPage.dart';
import 'ThirdPage.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({super.key});

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  final PageController pageController = PageController();
  int _currentPage = 0;

  void _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  Future<void> _onboardingComplete() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('onboardingComplete', true);
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) =>RoleSelectionPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: pageController,
            onPageChanged: _onPageChanged,
            children: [
              FirstPage(),
              SecondPage(),
              ThirdPage(),
            ],
          ),
          Positioned(
            top: 50,
            right: 20,
            child: TextButton(
              onPressed: _onboardingComplete,
              child: Text("Skip",
                  style: TextStyle(fontSize: 16, color: Colors.grey)),
            ),
          ),
          Positioned(
            bottom: 80,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                  3, (index) => DotIndicator(isActive: index == _currentPage)),
            ),
          ),
          Positioned(
            bottom: 30,
            right: 20,
            child: FloatingActionButton(
              backgroundColor: AppColors.theme,
              onPressed: () {
                if (_currentPage == 2) {
                  _onboardingComplete();
                } else {
                  pageController.nextPage(
                      duration: Duration(milliseconds: 500),
                      curve: Curves.ease);
                }
              },
              child: Icon(
                _currentPage == 2 ? Icons.check : Icons.arrow_forward,
                color: Colors.black54,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

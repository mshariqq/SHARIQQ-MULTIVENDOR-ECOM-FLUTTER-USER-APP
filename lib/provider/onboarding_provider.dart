import 'package:flutter/material.dart';
import 'package:shariqq_multivendor_ecom_userapp/data/model/response/base/api_response.dart';
import 'package:shariqq_multivendor_ecom_userapp/data/model/response/onboarding_model.dart';
import 'package:shariqq_multivendor_ecom_userapp/data/repository/onboarding_repo.dart';
import 'package:shariqq_multivendor_ecom_userapp/helper/api_checker.dart';

class OnBoardingProvider with ChangeNotifier {
  final OnBoardingRepo onboardingRepo;

  OnBoardingProvider({@required this.onboardingRepo});

  List<OnboardingModel> _onBoardingList = [];
  List<OnboardingModel> get onBoardingList => _onBoardingList;

  int _selectedIndex = 0;
  int get selectedIndex => _selectedIndex;

  changeSelectIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }

  void initBoardingList(BuildContext context) async {
    ApiResponse apiResponse = await onboardingRepo.getOnBoardingList(context);
    if (apiResponse.response != null &&
        apiResponse.response.statusCode == 200) {
      _onBoardingList.clear();
      _onBoardingList.addAll(apiResponse.response.data);
    } else {
      ApiChecker.checkApi(context, apiResponse);
    }
    notifyListeners();
  }
}

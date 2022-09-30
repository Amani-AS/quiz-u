import 'package:flutter/cupertino.dart';
import 'package:phone_number/phone_number.dart';

import 'package:quiz_u/data/apis/api_preparing/apiresult.dart';
import 'package:quiz_u/data/apis/login_api.dart';
import 'package:quiz_u/data/apis/newname_api.dart';
import 'package:quiz_u/data/apis/token_api.dart';

import 'package:quiz_u/data/models/login/login_mdel.dart';

import 'package:quiz_u/data/models/name/newname_model.dart';

import 'package:quiz_u/rout/rout_names_constant.dart';

enum LogInState { initial, loading, loaded, error }

class Item {
  Item(this.flag, this.region);


  final String? flag;

  final RegionInfo? region;
}

class LogInProvider with ChangeNotifier {
  LogInState state = LogInState.initial;
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController otpCode1 = TextEditingController();
  final TextEditingController otpCode2 = TextEditingController();
  final TextEditingController otpCode3 = TextEditingController();
  final TextEditingController otpCode4 = TextEditingController();
  reSetControllers(){
    phoneController.text="";
    nameController.text="";
    otpCode1.text="";
    otpCode2.text="";
    otpCode3.text="";
    otpCode4.text="";



  }

  bool isValid = true;
  String? code;
  LogIn? logIn;
  NewName? name;


  APIResult result = APIResult();
  String? errorMessage;

  singIn() async {
    await LogInApi.logIn(
        "${otpCode1.text}${otpCode2.text}${otpCode3.text}${otpCode4.text}",
        phoneController.text);

    result = LogInApi.result1;
    logIn = result.data;
    if (!result.hasError) {
      logIn = result.data;
      print(result.data);
      setState(LogInState.loaded);
      notifyListeners();
    } else {
      errorMessage = result.message;
      setState(LogInState.error);
      notifyListeners();
    }
  }

  checkToken() async {
    await TokenApi.token();

    result = TokenApi.result1;

    if (!result.hasError) {
      setState(LogInState.loaded);
      notifyListeners();
    } else {
      errorMessage = result.message;
      setState(LogInState.error);
      notifyListeners();
    }
  }

  setName() async {
    await NewNameApi.name(nameController.text);

    result = NewNameApi.result1;

    if (!result.hasError) {
      name = result.data;

      setState(LogInState.loaded);
      notifyListeners();
    } else {
      errorMessage = result.message;
      setState(LogInState.error);
      notifyListeners();
    }
  }

  setOTPCode1(v) {
    otpCode1.text = v;
    notifyListeners();
  }

  setOTPCode2(v) {
    otpCode2.text = v;
    notifyListeners();
  }

  setOTPCode3(v) {
    otpCode3.text = v;
    notifyListeners();
  }

  setOTPCode4(v) {
    otpCode3.text = v;
    notifyListeners();
  }

  setCode(v) {
    code = v;
    notifyListeners();
  }

  setPhoneController(v) {
    phoneController.text = v;
    notifyListeners();
  }

  setNameController(v) {
    nameController.text = v;
    notifyListeners();
  }

  validation(code) async {
    isValid = await PhoneNumberUtil()
        .validate(phoneController.text, regionCode: code);
  }

  String flag = "🇸🇦";
  List<Item> countries = [
    Item("🇸🇦", const RegionInfo(code: "SA", prefix: 966, name: 'SauiArabia')),
    Item("🇺🇸", const RegionInfo(code: "US", prefix: 1, name: "United State")),
  ];

  changeCountry(v) {
    flag = v;
    notifyListeners();
  }

  setState(state) {
    this.state = state;
    notifyListeners();
  }

  void onSubmitPhone(formKey, context) async {
    if (formKey.currentState!.validate()) {
      ;
      Navigator.pushReplacementNamed(context, otp);
    }
  }

  void onSubmit(formKey, context) async {
    if (formKey.currentState!.validate()) {
      await singIn();
      if (state == LogInState.loaded) {
        if (logIn?.userStatus == "new") {
          Navigator.pushReplacementNamed(context, addName);
          setState(LogInState.initial);
        } else {
          Navigator.pushReplacementNamed(context, mainScreen);
          setState(LogInState.initial);
        }
      }
    }
  }

  void onNameSubmit(formKey, context) async {
    if (formKey.currentState.validate()) {
      await setName();
      if (state == LogInState.loaded) {
        Navigator.pushReplacementNamed(context, mainScreen);
        setState(LogInState.initial);
      }
    }
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:quiz_u/data/providers/login_provider.dart';

import 'package:quiz_u/ui/widgets/buttons.dart';

import 'package:quiz_u/ui/widgets/logo.dart';

import 'package:quiz_u/ui/widgets/Texts.dart';

class OTPScreen extends StatelessWidget {
  OTPScreen({Key? key}) : super(key: key);
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    LogInProvider provider = Provider.of<LogInProvider>(context);
    setController(index) {
      switch (index) {
        case 0:
          {
            return provider.otpCode1;
          }
        case 1:
          {
            return provider.otpCode2;
          }
        case 2:
          {
            return provider.otpCode3;
          }
        case 3:
          {
            return provider.otpCode4;
          }
      }
    }

    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: Center(
          child: Container(
            height: height * 0.7,
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Logo(),
                const Texts(
                  text: "Pleas enter the OTP sent to your mobile",
                ),
                Form(
                  key: formKey,
                  child: Directionality(
                    textDirection: TextDirection.ltr,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(
                          4,
                          (index) => Container(
                              height: height * 0.06,
                              width: height * 0.06,
                              margin: EdgeInsets.symmetric(
                                  horizontal: width * 0.007),
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.white, width: 1),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(4))),
                              child: TextFormField(
                                controller: setController(index),
                                validator: (v) {
                                  if (v!.isEmpty) {
                                    return "";
                                  }
                                  return null;
                                },
                                onChanged: (v) {
                                  if (v.length == 1 && index != 3) {
                                    FocusScope.of(context).nextFocus();
                                  }
                                },
                                onFieldSubmitted: (v) {
                                  switch (index) {
                                    case 0:
                                      {
                                        provider.setOTPCode1(v);
                                      }
                                      break;
                                    case 1:
                                      {
                                        provider.setOTPCode2(v);
                                      }
                                      break;
                                    case 2:
                                      {
                                        provider.setOTPCode3(v);
                                      }
                                      break;
                                    case 3:
                                      {
                                        provider.setOTPCode4(v);
                                      }
                                      break;
                                  }
                                },
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(1),
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                                textAlign: TextAlign.center,
                                showCursor: false,
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                    border: InputBorder.none),
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700),
                              ))),
                    ),
                  ),
                ),
                provider.errorMessage != null
                    ? const Text(
                        "invalid code",
                        style: TextStyle(color: Colors.red),
                      )
                    : const SizedBox(),
                Buttons(
                  text: "Check",
                  onTap: () {
                    provider.onSubmit(formKey, context);
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

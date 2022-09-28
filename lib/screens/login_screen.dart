import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_u/data/providers/login_provider.dart';
import 'package:quiz_u/data/providers/provider_list/providers_export.dart';
import 'package:quiz_u/ui/widgets/buttons.dart';
import 'package:quiz_u/ui/widgets/logo.dart';

class LogInScreen extends StatelessWidget {
  LogInScreen({Key? key}) : super(key: key);
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    LogInProvider provider = Provider.of<LogInProvider>(context);
    TapsProvider tapsProvider=Provider.of<TapsProvider>(context);
    OutlineInputBorder outlineInputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(6.0),
      borderSide: const BorderSide(color: Colors.white),
    );

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
                Form(
                    key: formKey,
                    child: TextFormField(
                      style: const TextStyle(color: Colors.white70),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      textDirection: TextDirection.ltr,
                      keyboardType: TextInputType.number,
                      onChanged: (v) async {
                        // provider.setController();
                        provider.setPhoneController(v);
                        provider.setCode(provider.countries
                            .firstWhere((e) => e.flag == provider.flag)
                            .region!
                            .code);

                        await provider.validation(provider.code);
                      },
                      validator: (v) {
                        if (v!.isEmpty) {
                          return "* Required";
                        }
                        if (!provider.isValid) {
                          return "Add valid number";
                        }

                        return null;
                      },
                      controller: TextEditingController.fromValue(
                          TextEditingValue(
                              text: provider.phoneController.text,
                              selection: TextSelection.collapsed(
                                  offset:
                                      provider.phoneController.text.length))),
                      decoration: InputDecoration(
                          errorStyle: const TextStyle(color: Colors.red),
                          prefixIcon: DropdownButtonHideUnderline(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 6),
                              child: DropdownButton<String>(
                                style: const TextStyle(fontSize: 30),
                                iconDisabledColor: Colors.white,
                                iconEnabledColor: Colors.white,
                                value: provider.flag,
                                items: provider.countries
                                    .map((e) => DropdownMenuItem<String>(
                                          value: e.flag,
                                          child: Text(e.flag!),
                                        ))
                                    .toList(),
                                onChanged: (Object? value) {
                                  provider.changeCountry(value);
                                },
                              ),
                            ),
                          ),
                          hintText: provider.flag == "🇸🇦"
                              ? "535555555"
                              : "4155555555",
                          hintStyle: const TextStyle(
                            color: Colors.white30,
                            fontWeight: FontWeight.w400,
                            fontSize: 20,
                          ),
                          focusedBorder: outlineInputBorder,
                          errorBorder: outlineInputBorder,
                          focusedErrorBorder: outlineInputBorder,
                          enabledBorder: outlineInputBorder),
                    )),
                Buttons(
                  text: "Start",
                  onTap: () {
                    provider.onSubmitPhone(formKey, context);
                    tapsProvider.setPage(0);
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

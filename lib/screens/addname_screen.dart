import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_u/data/providers/login_provider.dart';

import 'package:quiz_u/ui/widgets/buttons.dart';

import 'package:quiz_u/ui/widgets/logo.dart';

import 'package:quiz_u/ui/widgets/Texts.dart';

class AddNameScreen extends StatelessWidget {
  AddNameScreen({Key? key}) : super(key: key);
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    LogInProvider provider = Provider.of<LogInProvider>(context);
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
                const Texts(
                  text: "What's your name?",
                ),
                Form(
                    key: formKey,
                    child: TextFormField(
                      style: const TextStyle(color: Colors.white),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      textDirection: TextDirection.ltr,
                      keyboardType: TextInputType.text,
                      onChanged: (v) async {
                        // provider.setController();
                        provider.setNameController(v);
                      },
                      validator: (v) {
                        if (v!.isEmpty) {
                          return "* Required";
                        }

                        return null;
                      },
                      controller: TextEditingController.fromValue(
                          TextEditingValue(
                              text: provider.nameController.text,
                              selection: TextSelection.collapsed(
                                  offset:
                                      provider.nameController.text.length))),
                      decoration: InputDecoration(
                          errorStyle: const TextStyle(color: Colors.red),
                          focusedBorder: outlineInputBorder,
                          errorBorder: outlineInputBorder,
                          focusedErrorBorder: outlineInputBorder,
                          enabledBorder: outlineInputBorder),
                    )),
                Buttons(
                  onTap: () {
                    provider.onNameSubmit(formKey, context);
                  },
                  text: "Done",
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

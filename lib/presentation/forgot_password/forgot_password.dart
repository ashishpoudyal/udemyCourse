import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../resources/value_manager.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
            Padding(
                  padding: EdgeInsets.only(
                      left: AppPadding.p20, right: AppPadding.p20),
                  child: StreamBuilder<bool>(
                      stream: _viewModel.outputIsPasswordValid,
                      builder: (context, snapshot) {
                        return TextFormField(
                          controller: _passwordController,
                          decoration: InputDecoration(
                            hintText: "Password",
                            labelText: "Password",
                            errorText: (snapshot.data ?? true)
                                ? null
                                : "Password is wrong",
                          ),
                        );
                      }),
                ),

      ],
    );
  }
}

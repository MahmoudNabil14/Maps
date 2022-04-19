import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maps/modules/phone%20auth/otp_screen.dart';
import 'package:maps/modules/phone%20auth/phone%20auth%20cubit/phone_auth_cubit.dart';
import 'package:maps/modules/phone%20auth/phone%20auth%20cubit/phone_auth_states.dart';
import 'package:maps/shared/Styles/colors.dart';

// ignore: must_be_immutable
class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController _controller = TextEditingController();

  String generateCountryFlag() {
    String countryCode = 'eg';
    String flag = countryCode.toUpperCase().replaceAllMapped(RegExp(r'[A-Z]'),
        (match) => String.fromCharCode(match.group(0)!.codeUnitAt(0) + 127397));
    return flag;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PhoneAuthCubit, PhoneAuthStates>(
      listener: (context, state) {
        if (state is PhoneEnteredCorrectlyState) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => OtpScreen(phoneNumber: _controller.text,)));
        }
      },
      builder: (context, state) => SingleChildScrollView(
        child: SafeArea(
          child: Scaffold(
              body: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 80.0, horizontal: 40.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "What is your phone number?",
                  style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w900),
                ),
                const SizedBox(
                  height: 40.0,
                ),
                const Text(
                  "Please enter your phone number to create your account",
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
                const SizedBox(
                  height: 30.0,
                ),
                Row(
                  children: [
                    Expanded(
                        flex: 1,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12.0, vertical: 16.0),
                          child: Text(
                            generateCountryFlag() + " +20",
                            style: const TextStyle(
                                fontSize: 18.0, letterSpacing: 2.0),
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(color: MyColors.lightGrey),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        )),
                    const SizedBox(
                      width: 16.0,
                    ),
                    Expanded(
                      flex: 2,
                      child: Form(
                        key: formKey,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12.0, vertical: 2.0),
                          decoration: BoxDecoration(
                              border: Border.all(color: MyColors.lightGrey),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(5.0))),
                          child: TextFormField(
                            controller: _controller,
                            autofocus: true,
                            cursorColor: Colors.black,
                            style: const TextStyle(
                                fontSize: 18.0, letterSpacing: 1.2),
                            keyboardType: TextInputType.phone,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Phone number cannot be empty";
                              } else if (value.length != 11) {
                                return "Phone number must be 11 digits";
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30.0,
                ),
                Align(
                  alignment: AlignmentDirectional.centerEnd,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size(120, 50),
                        primary: Colors.black,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0))),
                    child: const Text(
                      "Next",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        PhoneAuthCubit.get(context).authenticate(_controller.text.toString());
                      }
                    },
                  ),
                ),
              ],
            ),
          )),
        ),
      ),
    );
  }
}

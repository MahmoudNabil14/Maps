import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maps/modules/phone%20auth/phone%20auth%20cubit/phone_auth_cubit.dart';
import 'package:maps/shared/Styles/colors.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

// ignore: must_be_immutable
class OtpScreen extends StatelessWidget {
  OtpScreen({Key? key, required this.phoneNumber}) : super(key: key);

  final phoneNumber ;
  late String _otpCode;

  void _login(BuildContext context) {
    BlocProvider.of<PhoneAuthCubit>(context).submitOTP(_otpCode);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
      listener: (context, state) {},
      builder: (context, state){
        return SafeArea(
          child: Scaffold(
            backgroundColor: Colors.white,
            body: Padding(
              padding: const EdgeInsets.only(
                  right: 32.0, top: 70.0, bottom: 20.0, left: 32.0),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: (Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Please verify your phone number?",
                      style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w900),
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),
                    RichText(
                        text: TextSpan(children: <TextSpan>[
                          const TextSpan(
                            text: "Please enter 6 digits number sent to ",
                            style: TextStyle(fontSize: 17.0, color: Colors.black),
                          ),
                          TextSpan(
                            text: phoneNumber,
                            style: const TextStyle(
                                fontSize: 16.0, height: 1.8, color: Colors.blue),
                          ),
                        ])),
                    const SizedBox(
                      height: 50.0,
                    ),
                    PinCodeTextField(
                      appContext: context,
                      cursorColor: Colors.black,
                      autoFocus: true,
                      length: 6,
                      keyboardType: TextInputType.number,
                      obscureText: false,
                      animationType: AnimationType.fade,
                      pinTheme: PinTheme(
                          shape: PinCodeFieldShape.box,
                          borderRadius: BorderRadius.circular(5),
                          borderWidth: 1.0,
                          fieldHeight: 50,
                          fieldWidth: 40,
                          activeFillColor: MyColors.lightBlue,
                          activeColor: MyColors.blue,
                          inactiveFillColor: Colors.white,
                          inactiveColor: Colors.blue,
                          selectedColor: MyColors.blue,
                          selectedFillColor: Colors.white),
                      animationDuration: const Duration(milliseconds: 300),
                      backgroundColor: Colors.white,
                      enableActiveFill: true,
                      onCompleted: (code) {
                        _otpCode = code;
                      },
                      onChanged: (value) {},
                    ),
                    const SizedBox(
                      height: 50.0,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: MaterialButton(
                          color: Colors.black,
                          height: 70.0,
                          minWidth: 120.0,
                          onPressed: () {
                            _login(context);
                          },
                          child: const Text(
                            "Verify",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
              ),
            ),
          ),
        );
      },
    );
  }
}

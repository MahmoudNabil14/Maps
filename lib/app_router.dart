import 'package:flutter/material.dart';
import 'package:maps/modules/map_screen.dart';
import 'package:maps/shared/constants.dart';
import 'modules/phone auth/login_screen.dart';
import 'modules/phone auth/otp_screen.dart';
import 'modules/phone auth/phone auth cubit/phone_auth_cubit.dart';

class AppRouter {
  PhoneAuthCubit? phoneAuthCubit;

  AppRouter() {
    phoneAuthCubit = PhoneAuthCubit();
  }

  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case mapScreen:
        return MaterialPageRoute(
          builder: (_) =>  const MapScreen(),
        );

      case loginScreen:
        return MaterialPageRoute(
          builder: (_) =>  LoginScreen(),
        );

      case otpScreen:
        final phoneNumber = settings.arguments;
        return MaterialPageRoute(
          builder: (_) =>  OtpScreen(phoneNumber: phoneNumber),

        );
    }
    return null;
  }
}
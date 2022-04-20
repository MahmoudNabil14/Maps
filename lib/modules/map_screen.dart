import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maps/modules/phone%20auth/phone%20auth%20cubit/phone_auth_cubit.dart';
import 'package:maps/modules/phone%20auth/phone%20auth%20cubit/phone_auth_states.dart';
import 'package:maps/shared/constants.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PhoneAuthCubit, PhoneAuthStates>(
      listener: (context, state) {},
      builder: (context, state){
        return Scaffold(
          body:  Center(
            child: Container(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: MaterialButton(
                color: Colors.black,
                height: 50.0,
                minWidth: 120.0,
                onPressed: () {
                  PhoneAuthCubit.get(context).signOut();
                  Navigator.of(context).pushReplacementNamed(loginScreen);
                },
                child: const Text(
                  "Sign Out",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

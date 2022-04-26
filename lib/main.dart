import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maps/app_router.dart';
import 'package:maps/modules/map_screen.dart';
import 'package:maps/modules/phone%20auth/login_screen.dart';
import 'package:maps/modules/phone%20auth/phone%20auth%20cubit/phone_auth_cubit.dart';
import 'package:maps/shared/constants.dart';

late String? initialRoute;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  FirebaseAuth.instance.authStateChanges().listen((user) {
    if (user == null) {
      initialRoute = mapScreen;
    } else {
      initialRoute = mapScreen;
    }
  });

  BlocOverrides.runZoned(
    () => runApp(MyApp(
      appRouter: AppRouter(),
    )),
    blocObserver: AppBlocObserver(),
  );
}

class AppBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    if (bloc is Cubit) print(change);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print(transition);
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.appRouter}) : super(key: key);

  final AppRouter appRouter;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context)=> PhoneAuthCubit())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const MapScreen(),
        onGenerateRoute: appRouter.generateRoute,
        initialRoute: initialRoute,
      ),
    );
  }
}

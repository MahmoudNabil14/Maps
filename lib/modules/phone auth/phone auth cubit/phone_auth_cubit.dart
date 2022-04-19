import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maps/modules/phone%20auth/phone%20auth%20cubit/phone_auth_states.dart';

class PhoneAuthCubit extends Cubit<PhoneAuthStates>{
  PhoneAuthCubit() : super(AuthInitState());

  late String verificationId;

  static PhoneAuthCubit get(context)=> BlocProvider.of(context);


  Future<void> authenticate (String phoneNumber)async {
    emit(AuthLoadingState());

    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: "+2$phoneNumber",
      timeout: const Duration(seconds: 15),
      verificationCompleted: verificationCompleted,
      verificationFailed: verificationFailed,
      codeSent: codeSent,
      codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
    );
  }

  void verificationCompleted (PhoneAuthCredential credential) async{
    await signIn(credential);
    emit(CodeEnteredCorrectlyState());
  }

  void verificationFailed(FirebaseAuthException error) {
    if (error.code == 'invalid-phone-number') {
      print('The provided phone number is not valid.');
    }
    AuthErrorState(error.toString());
  }

  void codeSent (String verificationId, int? resendToken) {
    this.verificationId = verificationId;
    emit(PhoneEnteredCorrectlyState());
  }

  void codeAutoRetrievalTimeout (String verificationId) {

  }

  Future<void> signIn(PhoneAuthCredential credential) async {
    try {
      await FirebaseAuth.instance.signInWithCredential(credential);
      emit(CodeEnteredCorrectlyState());
    } catch (error) {
      emit(AuthErrorState(error.toString()));
    }
  }

  Future<void> submitOTP(String otpCode) async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId, smsCode: otpCode);
    await signIn(credential);
  }

  Future<void> logOut() async {
    await FirebaseAuth.instance.signOut();
  }

  User getLoggedInUser() {
    User firebaseUser = FirebaseAuth.instance.currentUser!;
    return firebaseUser;
  }
}
abstract class PhoneAuthStates{}

class AuthInitState extends PhoneAuthStates{}

class AuthLoadingState extends PhoneAuthStates{}

class PhoneEnteredCorrectlyState extends PhoneAuthStates{}

class CodeEnteredCorrectlyState extends PhoneAuthStates{}

class AuthErrorState extends PhoneAuthStates{
   final String error;

  AuthErrorState(this.error);
}
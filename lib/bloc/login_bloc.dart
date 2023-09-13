import 'dart:async';
import 'package:login_register_bloc/bloc/validator.dart';
import 'package:rxdart/rxdart.dart';

class LoginBloc with Validators {
  final _loginEmail = BehaviorSubject<String>();
  final _loginPassword = BehaviorSubject<String>();

  //Getter
  Stream<String> get loginEmail => _loginEmail.stream.transform(emailValidator);
  Stream<String> get loginPassword =>
      _loginPassword.stream.transform(loginPasswordValidator);
  Stream<bool> get isValid =>
      Rx.combineLatest2(loginEmail, loginPassword, (a, b) => true);
//setter
  Function(String) get changeLoginEmail => _loginEmail.sink.add;
  Function(String) get changePassword => _loginPassword.sink.add;

  void submit() {
    print(_loginEmail.value);
    print(_loginPassword.value);
  }
//Transformer

  void dispose() {
    _loginEmail.close();
    _loginPassword.close();
  }
}

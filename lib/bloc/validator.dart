import 'dart:async';

mixin Validators {
  var emailValidator = StreamTransformer<String, String>.fromHandlers(
    handleData: (email, sink) {
      if (email.isEmpty) {
        return sink.addError('This cannot be empty');
      } else if (!RegExp(
              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
          .hasMatch(email)) {
        return sink.addError("not a valid Email");
      } else {
        sink.add(email);
      }
    },
  );
  var loginPasswordValidator = StreamTransformer<String, String>.fromHandlers(
    handleData: (password, sink) {
      if (password.isEmpty) {
        return sink.addError('This cannot be empty');
      } else if (password.length < 8) {
        return sink.addError("not a valid password : less than 8 char");
      } else {
        sink.add(password);
      }
    },
  );
  var passwordValidator = StreamTransformer<String, String>.fromHandlers(
    handleData: (password, sink) {
      if (password.isEmpty) {
        return sink.addError('This cannot be empty');
      } else if (password.length < 8) {
        return sink.addError("not a valid password : less than 8 char");
      } else if (!RegExp(
              r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[^\da-zA-Z]).{8,15}$")
          .hasMatch(password)) {
        return sink.addError("not a valid password : less than 8 char");
      } else {
        sink.add(password);
      }
    },
  );
  var nameValidator = StreamTransformer<String, String>.fromHandlers(
    handleData: (name, sink) {
      if (name.isEmpty) {
        return sink.addError('This cannot be empty');
      } else if (!RegExp(r"^[a-zA-Z]+(([',. -][a-zA-Z ])?[a-zA-Z]*)*$")
          .hasMatch(name)) {
        return sink.addError("not a valid Name");
      } else {
        sink.add(name);
      }
    },
  );
  var phoneValidator = StreamTransformer<String, String>.fromHandlers(
    handleData: (phone, sink) {
      if (phone.isEmpty) {
        return sink.addError('This cannot be empty');
      } else if (!RegExp(r"[0-9]{10}").hasMatch(phone)) {
        return sink.addError("not a valid Phone Number");
      } else if (phone.length < 11) {
        return sink.addError("not a valid Phone Number");
      } else if (phone.length > 11) {
        return sink.addError("not a valid Phone Number");
      } else {
        sink.add(phone);
      }
    },
  );
}

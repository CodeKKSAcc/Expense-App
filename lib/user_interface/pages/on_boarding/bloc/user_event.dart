import 'package:expense_app/data/model/user_model.dart';

abstract class UserEvent {}

class UserLoginEvent extends UserEvent {
  String email, password;

  UserLoginEvent({required this.email, required this.password});
}

class UserSignUpEvent extends UserEvent {
  UserModel newUser;

  UserSignUpEvent({required this.newUser});
}
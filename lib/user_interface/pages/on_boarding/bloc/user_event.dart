

import 'package:expense_app/data/model/user_model.dart';

abstract class UserEvent {}

class UserLoginEvent extends UserEvent{
  UserModel varifiedUser;
  UserLoginEvent({required this.varifiedUser});
}

class UserSignUpEvent extends UserEvent{
  UserModel newUser;
  UserSignUpEvent({required this.newUser});
}
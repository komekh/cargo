part of 'user_bloc.dart';

@immutable
abstract class UserEvent {}

class SignInUser extends UserEvent {
  final SignInParams params;
  SignInUser(this.params);
}

class SignOutUser extends UserEvent {}

class CheckUser extends UserEvent {}

class GetRemoteUser extends UserEvent {}

class GetUser extends UserEvent {}

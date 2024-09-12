part of 'user_bloc.dart';

@immutable
abstract class UserState extends Equatable {}

class UserInitial extends UserState {
  @override
  List<Object> get props => [];
}

class UserLoading extends UserState {
  @override
  List<Object> get props => [];
}

class UserLogged extends UserState {
  final String token;
  UserLogged(this.token);
  @override
  List<Object> get props => [token];
}

class UserFetched extends UserState {
  final User user;
  UserFetched(this.user);
  @override
  List<Object> get props => [user];
}

class UserLoggedFail extends UserState {
  final Failure failure;
  UserLoggedFail(this.failure);
  @override
  List<Object> get props => [failure];
}

class UserLoggedOut extends UserState {
  @override
  List<Object> get props => [];
}

class AccountDeleted extends UserState {
  @override
  List<Object> get props => [];
}

class UserRegistered extends UserState {
  @override
  List<Object> get props => [];
}

class UserAlreadyRegistered extends UserState {
  @override
  List<Object> get props => [];
}

class DeleteLoading extends UserState {
  @override
  List<Object> get props => [];
}

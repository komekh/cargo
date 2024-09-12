import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/core.dart';
import '../../domain/domain.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final GetCachedUserUseCase _getCachedUserUseCase;
  final GetRemoteUserUsecase _getRemoteUserUseCase;
  final SignInUseCase _signInUseCase;
  final SignUpUseCase _signUpUseCase;
  final SignOutUseCase _signOutUseCase;
  final DeleteAccountUseCase _deleteAccountUseCase;
  UserBloc(
    this._signInUseCase,
    this._signUpUseCase,
    this._getCachedUserUseCase,
    this._getRemoteUserUseCase,
    this._signOutUseCase,
    this._deleteAccountUseCase,
  ) : super(UserInitial()) {
    on<SignInUser>(_onSignIn);
    on<SignUpUser>(_onSignUp);
    on<CheckUser>(_onCheckUser);
    on<GetRemoteUser>(_onGetRemoteUser);
    on<SignOutUser>(_onSignOut);
    on<GetUser>(_onGetUser);
    on<DeleteAccount>(_onDeleteAccount);
  }

  void _onSignIn(SignInUser event, Emitter<UserState> emit) async {
    try {
      emit(UserLoading());
      // await Future.delayed(const Duration(seconds: 3));
      final result = await _signInUseCase(event.params);
      result.fold(
        (failure) => emit(UserLoggedFail(failure)),
        (token) => emit(UserLogged(token)),
      );
    } catch (e) {
      emit(UserLoggedFail(ExceptionFailure()));
    }
  }

  void _onSignUp(SignUpUser event, Emitter<UserState> emit) async {
    try {
      emit(UserLoading());
      // await Future.delayed(const Duration(seconds: 3));
      final result = await _signUpUseCase(event.params);
      result.fold(
        (failure) => emit(UserLoggedFail(failure)),
        (code) {
          if (code == 200) {
            emit(UserRegistered());
          } else if (code == 409) {
            emit(UserAlreadyRegistered());
          } else {
            emit(UserLoggedFail(ExceptionFailure()));
          }
        },
      );
    } catch (e) {
      emit(UserLoggedFail(ExceptionFailure()));
    }
  }

  void _onCheckUser(CheckUser event, Emitter<UserState> emit) async {
    try {
      emit(UserLoading());
      final result = await _getCachedUserUseCase(NoParams());
      result.fold(
        (failure) => emit(UserLoggedFail(failure)),
        (user) => emit(UserFetched(user)),
      );
    } catch (e) {
      emit(UserLoggedFail(ExceptionFailure()));
    }
  }

  void _onSignOut(SignOutUser event, Emitter<UserState> emit) async {
    try {
      emit(UserLoading());
      await _signOutUseCase(NoParams());
      emit(UserLoggedOut());
    } catch (e) {
      emit(UserLoggedFail(ExceptionFailure()));
    }
  }

  void _onDeleteAccount(DeleteAccount event, Emitter<UserState> emit) async {
    try {
      emit(DeleteLoading());
      final result = await _deleteAccountUseCase(NoParams());
      result.fold(
        (failure) => emit(_mapFailureToState(failure)),
        (code) {
          if (code == 204) {
            emit(AccountDeleted());
          } else {
            emit(UserLoggedFail(ExceptionFailure()));
          }
        },
      );
    } catch (e) {
      emit(UserLoggedFail(ExceptionFailure()));
    }
  }

  FutureOr<void> _onGetRemoteUser(
    GetRemoteUser event,
    Emitter<UserState> emit,
  ) async {
    try {
      emit(UserLoading());
      final result = await _getRemoteUserUseCase(NoParams());
      result.fold(
        (failure) => emit(_mapFailureToState(failure)),
        (user) => emit(UserFetched(user)),
      );
    } catch (e) {
      emit(UserLoggedFail(ExceptionFailure()));
    }
  }

  UserState _mapFailureToState(Failure failure) {
    debugPrint('FAIL');
    if (failure is ServerFailure) {
      return UserLoggedFail(ServerFailure());
    } else if (failure is CacheFailure) {
      return UserLoggedFail(CacheFailure());
    } else if (failure is NetworkFailure) {
      return UserLoggedFail(NetworkFailure());
    } else if (failure is CredentialFailure) {
      return UserLoggedFail(CredentialFailure());
    } else if (failure is AuthenticationFailure) {
      return UserLoggedFail(AuthenticationFailure());
    } else {
      return UserLoggedFail(ExceptionFailure());
    }
  }

  /// get the user
  FutureOr<void> _onGetUser(GetUser event, Emitter<UserState> emit) async {
    try {
      emit(UserLoading());
      // await Future.delayed(const Duration(seconds: 3));
      final user = await _getUserFromCacheOrRemote();
      emit(UserFetched(user));
    } catch (failure) {
      emit(_mapFailureToState(failure as Failure));
    }
  }

  Future<User> _getUserFromCacheOrRemote() async {
    try {
      final cacheResult = await _getCachedUserUseCase(NoParams());
      return cacheResult.fold(
        (failure) => throw failure,
        (user) => user,
      );
    } catch (_) {
      return await _getUserFromRemote();
    }
  }

  Future<User> _getUserFromRemote() async {
    final remoteResult = await _getRemoteUserUseCase(NoParams());
    return remoteResult.fold(
      (failure) => throw failure,
      (user) => user,
    );
  }
}

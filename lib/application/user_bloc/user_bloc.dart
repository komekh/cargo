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
  final SignOutUseCase _signOutUseCase;
  UserBloc(
    this._signInUseCase,
    this._getCachedUserUseCase,
    this._getRemoteUserUseCase,
    this._signOutUseCase,
  ) : super(UserInitial()) {
    on<SignInUser>(_onSignIn);
    on<CheckUser>(_onCheckUser);
    on<GetRemoteUser>(_onGetRemoteUser);
    on<SignOutUser>(_onSignOut);
    on<GetUser>(_onGetUser);
  }

  void _onSignIn(SignInUser event, Emitter<UserState> emit) async {
    try {
      emit(UserLoading());
      final result = await _signInUseCase(event.params);
      result.fold(
        (failure) => emit(UserLoggedFail(failure)),
        (token) => emit(UserLogged(token)),
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

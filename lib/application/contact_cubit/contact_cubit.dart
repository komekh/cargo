import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/core.dart';
import '../../domain/domain.dart';

part 'contact_state.dart';

class ContactCubit extends Cubit<ContactState> {
  final GetContactsUseCase _getContactsUseCase;

  ContactCubit(this._getContactsUseCase) : super(ContactInitial());

  Future<void> getContacts() async {
    try {
      emit(ContactLoading());
      final result = await _getContactsUseCase(NoParams());
      result.fold(
        (failure) => emit(ContactError()),
        (response) => emit(
          ContactLoaded(contacts: response.contacts),
        ),
      );
    } catch (e) {
      emit(ContactError());
    }
  }
}

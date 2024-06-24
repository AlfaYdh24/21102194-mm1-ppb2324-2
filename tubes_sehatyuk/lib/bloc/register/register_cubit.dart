import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../repositories/auth_repo.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());

  final _repo = AuthRepo();

  Future<void> register({
    required String email,
    required String password,
    required String name,
    required String phoneNumber,
  }) async {
    emit(RegisterLoading());

    try {
      await _repo.register(
        email: email,
        password: password,
        name: name,
        phoneNumber: phoneNumber,
      );

      emit(RegisterSuccess('Registration successful!'));
    } catch (e) {
      print(e);
      emit(RegisterFailure(e.toString()));
    }
  }
}

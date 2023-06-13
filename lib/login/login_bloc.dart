import 'package:bloc/bloc.dart';
import 'package:sample_bloc/login/login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(InitLoginState()) {
    on<InitLoginEvent>((event, emit) {
      loginEventToState(event: event, emit: emit);
    });
    on<LoginLoadedEvent>(
        (event, emit) => loadedLoginEventToState(event: event, emit: emit));
  }

  Future<void> loginEventToState(
      {required LoginEvent event, required Emitter<LoginState> emit}) async {
    if (event is InitLoginEvent) {
      emit(LoginLoadingState());
      await Future.delayed(Duration(seconds: 3));

      /// call api
      add(LoginLoadedEvent());
    } else {
      emit(LoginErrorState());
    }
  }

  Future<void> loadedLoginEventToState(
      {required LoginEvent event, required Emitter<LoginState> emit}) async {
    if (event is LoginLoadedEvent) {
      print("bloc method success");

      emit(LoginSuccessState());
    }
  }
}

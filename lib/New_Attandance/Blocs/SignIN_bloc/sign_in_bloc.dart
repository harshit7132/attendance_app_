
import 'package:attendance_app/New_Attandance/Blocs/SignIN_bloc/sign_in_event.dart';
import 'package:attendance_app/New_Attandance/Blocs/SignIN_bloc/sign_in_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  SignInBloc() : super(SignInState()) {
    on<EmailEvent>(_emailEvent);
    on<PasswordEvent>(_passwordEvent);
    on<PhoneEvent>(_phoneEvent);
  }

  void _emailEvent(EmailEvent event,Emitter<SignInState> emit) {
    emit (state.copyWith(email: event.email));
  }

  void _passwordEvent(PasswordEvent event,Emitter<SignInState> emit) {
    emit (state.copyWith(password: event.password));
  }
  void _phoneEvent(PhoneEvent event,Emitter<SignInState> emit) {
    emit (state.copyWith(password: event.phone));
  }
}

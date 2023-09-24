import 'package:attendance_app/New_Attandance/Blocs/Login_bloc/LogIn_Events.dart';
import 'package:bloc/bloc.dart';
import 'LogIn_State.dart';

class LogIn_bloc extends Bloc<LogIn_Events, LogIn_State> {
  LogIn_bloc():super(LogIn_State()) {

    on<EmailEvent>(_emailEvent);
    on<PasswordEvent>(_passEvent);
  }
  void _emailEvent(EmailEvent event,Emitter<LogIn_State> emit){
    emit (state.copyWith(email: event.email));
  }
  void _passEvent(PasswordEvent event,Emitter<LogIn_State> emit){
    emit (state.copyWith(password: event.password));
  }
}
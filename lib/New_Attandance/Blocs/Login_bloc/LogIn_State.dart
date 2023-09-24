
 class LogIn_State {
  final String email;
  final String password;
  LogIn_State({ this.email = "", this.password=""});

  LogIn_State copyWith({String? email, String? password}) {
   return LogIn_State(
       email: email ?? this.email,
       password: password ?? this.password
   );
  }
 }

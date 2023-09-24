
 class SignInState {
  final String email;
  final String password;
  final String phone;
  SignInState({ this.email = "", this.password="",this.phone =""});

  SignInState copyWith({String? email, String? password}) {
    return SignInState(
      email: email ?? this.email,
      password: password ?? this.password,
      phone: phone ?? this.phone
    );
  }
 }

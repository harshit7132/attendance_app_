
abstract class SignInEvent {
  const SignInEvent();
}

class EmailEvent extends SignInEvent {
  final String email;
  const EmailEvent (this.email);
}

class PasswordEvent extends SignInEvent {
  final String password;
  const PasswordEvent (this.password);
}


class PhoneEvent extends SignInEvent {
  final String phone;
  const PhoneEvent (this.phone);
}


abstract class LogIn_Events{
  const LogIn_Events();
}

class EmailEvent extends LogIn_Events {
  final String email;
  const EmailEvent (this.email);
}

class PasswordEvent extends LogIn_Events {
  final String password;
  const PasswordEvent (this.password);
}


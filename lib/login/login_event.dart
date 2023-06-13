abstract class LoginEvent{}

class InitLoginEvent extends LoginEvent{
  final String email;
  final String password;

  InitLoginEvent({required this.email, required this.password});
}
class LoginLoadedEvent extends LoginEvent{

}


import 'package:streams_provider/streams_provider.dart';
import 'package:survey/services/locator/locator_register.dart';
import 'package:survey/services/auth/auth_service.dart';

abstract class LoginVM implements StreamsProvidable {
  ValueStream<LoginState> get state;

  ValueStream<String?> get email;

  ValueStream<String?> get password;

  ValueStream<Object?> get error;

  ValueStream<bool> get isValid;

  void setEmail(String value);

  void setPassword(String value);

  void login();
}

class LoginVMImpl implements LoginVM {
  final AuthService _authService = locator.get();

  final _state = MutableValueStream<LoginState>(LoginState.initial);
  @override
  ValueStream<LoginState> get state => _state;

  final _email = MutableValueStream<String>("");
  @override
  ValueStream<String?> get email => _email;

  final _password = MutableValueStream<String>("");
  @override
  ValueStream<String?> get password => _password;

  final _error = MutableValueStream<Object?>();
  @override
  ValueStream<Object?> get error => _error;

  final _isValid = MutableValueStream<bool>(false);
  @override
  ValueStream<bool> get isValid => _isValid;

  late final _disposeBag =
      StreamsDisposeBag([_state, _email, _password, _error]);

  LoginVMImpl() {
    final subscription = [_password, _email].combineLatest().listen((data) {
      _isValid.value = data[0].isNotEmpty && data[1].isNotEmpty;
    });
    _disposeBag.add(subscription);
  }

  @override
  void setEmail(String value) {
    _email.value = value;
  }

  @override
  void setPassword(String value) {
    _password.value = value;
  }

  @override
  void login() {
    Future.microtask(() async {
      _state.value = LoginState.logging;
      final params = AuthLoginParams(
        email: _email.value,
        password: _password.value,
      );

      try {
        await _authService.login(params: params);
        _state.value = LoginState.completed;
      } on Exception catch (e) {
        _error.value = e;
        _state.value = LoginState.error;
      }
    });
  }

  @override
  Future<void> dispose() {
    return _disposeBag.dispose();
  }
}

enum LoginState { initial, animating, ready, logging, completed, error }

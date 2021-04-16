import 'package:streams_provider/streams_provider.dart';
import 'package:survey/core/classes/localized_exception.dart';
import 'package:survey/services/locator/locator_register.dart';
import 'package:survey/services/auth/auth_service.dart';

abstract class LandingVM implements StreamsProvidable {
  ValueStream<LandingState> get state;

  ValueStream<Object?> get error;

  ValueStream<LandingAnimationState> get animationState;

  ValueStream<bool> get isAuthenticated;

  void begin();

  void markAsAnimationCompleted();
}

class LandingVMImpl implements LandingVM {
  final AuthService _authService = locator.get();

  late final _disposeBag = StreamsDisposeBag([_state]);

  final _state = MutableValueStream<LandingState>(LandingState.initial);
  @override
  ValueStream<LandingState> get state => _state;

  final _animationState =
      MutableValueStream<LandingAnimationState>(LandingAnimationState.initial);
  @override
  ValueStream<LandingAnimationState> get animationState => _animationState;

  final _error = MutableValueStream<Object?>();
  @override
  ValueStream<Object?> get error => _error;

  final _isAuthenticated = MutableValueStream<bool>(false);
  @override
  ValueStream<bool> get isAuthenticated => _isAuthenticated;

  @override
  void begin() {
    [
      _authService.attemptAndFetchUser().asStream(),
      _animationState.where((event) => event == LandingAnimationState.completed)
    ].zip().listen((event) {
      _isAuthenticated.value = _authService.isAuthenticated;
      _state.value = LandingState.completed;
    }, onError: (_) {
      _error.value = LandingException.unknown;
      _state.value = LandingState.error;
    });
    _animationState.value = LandingAnimationState.animating;
  }

  @override
  void markAsAnimationCompleted() {
    _animationState.value = LandingAnimationState.completed;
  }

  @override
  Future<void> dispose() async {
    await _disposeBag.dispose();
  }
}

enum LandingState { initial, loading, completed, error }
enum LandingAnimationState { initial, animating, completed }

class LandingException extends LocalizedException {
  static const unknown = LandingException("Unable to connect to server");

  const LandingException(String message) : super(message);
}

import 'dart:async';

extension StreamVoidExtensions on Stream<void> {
  StreamSubscription<void> voidListen(void Function() onData) {
    return listen((_) {
      onData();
    });
  }
}

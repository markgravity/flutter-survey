import 'dart:async';

extension StreamExtensions<T> on Stream<T> {
  Stream<T> handleOnlyException() {
    final controller = StreamController<T>();
    listen((event) {
      controller.sink.add(event);
    }, onError: (error) {
      if (error is! Error) {
        controller.sink.addError(error as Object);
        return;
      }

      throw error;
    });

    return controller.stream;
  }
}

extension StreamVoidExtensions on Stream<void> {
  StreamSubscription<void> voidListen(void Function() onData) {
    return listen((_) {
      onData();
    });
  }
}

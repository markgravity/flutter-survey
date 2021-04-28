import 'dart:async';

import 'package:mockito/mockito.dart';
import 'package:streams_provider/streams_provider.dart';

class FakeStreamSubscription<T> extends Fake implements StreamSubscription<T> {}

class FakeValueStream<T> extends Fake implements ValueStream<T> {
  @override
  StreamSubscription<T> listen(void Function(T event)? onData,
      {Function? onError, void Function()? onDone, bool? cancelOnError}) {
    return FakeStreamSubscription();
  }
}

import 'package:streams_provider/streams_provider.dart';

class BehaviorSubjectGenerator {
  final Map<int, BehaviorSubject> subjects = {};

  BehaviorSubject<T> make<T>(int i) {
    if (!subjects.containsKey(i)) {
      subjects[i] = BehaviorSubject<T>();
    }

    return subjects[i]! as BehaviorSubject<T>;
  }
}

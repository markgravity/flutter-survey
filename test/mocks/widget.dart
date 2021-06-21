import 'package:flutter/foundation.dart';
import 'package:mockito/mockito.dart';

class MockWidget extends Mock {
  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.debug}) {
    return super.toString();
  }
}

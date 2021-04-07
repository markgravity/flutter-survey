class Environment {
  static const Environment staging = Environment();
  static const Environment production = Environment();
  static Environment _current;

  const Environment();
  void set() {
    Environment._current = this;
  }

  static Environment get() {
    return _current;
  }
}

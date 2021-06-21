enum FlavorValue {
  production,
  staging,
}

// ignore: avoid_classes_with_only_static_members
class Flavour {
  static FlavorValue? current;
}

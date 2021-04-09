enum Flavor {
  PRODUCTION,
  STAGING,
}

class F {
  static Flavor appFlavor;

  static String get title {
    switch (appFlavor) {
      case Flavor.PRODUCTION:
        return 'Survey';
      case Flavor.STAGING:
        return 'Survey-Staging';
      default:
        return 'title';
    }
  }
}

part of 'package:survey/gen/configs.gen.dart';

class _AppConfig {
  const _AppConfig();

  _Api get api => const _Api();
}

class _Api {
  const _Api();

  String get baseUrl {
    switch (Flavour.current) {
      case FlavorValue.production:
        return "https://survey-api.nimblehq.co/api/v1";
      case FlavorValue.staging:
      default:
        return "https://nimble-survey-web-staging.herokuapp.com/api/v1";
    }
  }

  String get clientId {
    switch (Flavour.current) {
      case FlavorValue.production:
        return "4gg3bokkvPnMxWz7HHTdM_wf1RNg9k8iA6sZ2ZrA7EA";
      case FlavorValue.staging:
      default:
        return "z9iUamZLvRgtVVtRJ8UqItg2vmncGyEi30p1eWEddnA";
    }
  }

  String get clientSecret {
    switch (Flavour.current) {
      case FlavorValue.production:
        return "y_GgV-GEjWd3VTzbZBS6tqEco0E68QuqHQv0QND2vKo";
      case FlavorValue.staging:
      default:
        return "1vqRNMxq-Yx83A61GNjLb17qxCGKxHDb8EmB3MKdxqA";
    }
  }
}

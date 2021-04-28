part of 'api_service.dart';

class ApiServiceRegister {
  final ApiService _apiService = locator.get();
  ApiServiceRegister() {
    Mappable.factories = Configs.factories;
    _apiService.configureGlobalBaseUrl(Configs.app.api.baseUrl);
  }
}

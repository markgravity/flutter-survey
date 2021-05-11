import 'package:get_it/get_it.dart';
import 'package:survey/services/api/api_service.dart';
import 'package:survey/services/api/auth/auth_api_service.dart';
import 'package:survey/repositories/auth_repository.dart';
import 'package:survey/services/auth_local_storage/auth_local_storage_service.dart';
import 'package:survey/services/http/http_service.dart';
import 'package:survey/services/api/user/user_api_service.dart';

part 'locator_service_register.dart';

final locator = GetIt.instance;

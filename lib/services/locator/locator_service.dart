import 'package:get_it/get_it.dart';
import 'package:flutter/cupertino.dart';
import 'package:survey/modules/forgot_password/forgot_password_module.dart';
import 'package:survey/modules/home/home_module.dart';
import 'package:survey/modules/landing/landing_module.dart';
import 'package:survey/modules/login/login_module.dart';
import 'package:survey/services/api/api_service.dart';
import 'package:survey/services/api/auth/auth_api_service.dart';
import 'package:survey/repositories/auth_repository.dart';
import 'package:survey/services/local_storage/local_storage_service.dart';
import 'package:survey/services/api/survey/survey_api_service.dart';
import 'package:survey/services/http/http_service.dart';
import 'package:survey/services/api/user/user_api_service.dart';

part 'locator_service_register.dart';

final locator = GetIt.instance..allowReassignment = true;

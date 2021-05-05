import 'package:get_it/get_it.dart';
import 'package:flutter/cupertino.dart';
import 'package:streams_provider/streams_provider.dart';
import 'package:survey/modules/forgot_password/forgot_password_module.dart';
import 'package:survey/modules/landing/landing_module.dart';
import 'package:survey/modules/login/login_module.dart';
import 'package:survey/services/api/api_service.dart';
import 'package:survey/services/auth/auth_service.dart';
import 'package:survey/services/http/http_service.dart';
import 'package:survey/services/user/user_service.dart';

part 'locator_service_register.dart';

final locator = GetIt.instance..allowReassignment = true;

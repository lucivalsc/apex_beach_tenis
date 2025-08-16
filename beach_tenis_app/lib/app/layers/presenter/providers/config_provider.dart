import 'package:beach_tenis_app/app/common/usecase.dart';
import 'package:beach_tenis_app/app/layers/domain/usecases/config/load_addresses_usecase.dart';
import 'package:beach_tenis_app/app/layers/domain/usecases/config/load_company_usecase.dart';
import 'package:beach_tenis_app/app/layers/domain/usecases/config/load_config_usecase.dart';
import 'package:beach_tenis_app/app/layers/domain/usecases/config/load_last_logged_email.dart';
import 'package:beach_tenis_app/app/layers/domain/usecases/config/load_last_logged_password.dart';
import 'package:beach_tenis_app/app/layers/domain/usecases/config/save_addresses_usecase.dart';
import 'package:beach_tenis_app/app/layers/domain/usecases/config/save_company_usecase.dart';
import 'package:beach_tenis_app/app/layers/domain/usecases/config/save_config_usecase.dart';
import 'package:beach_tenis_app/app/layers/domain/usecases/config/save_last_logged_email.dart';
import 'package:beach_tenis_app/app/layers/domain/usecases/config/save_last_logged_password.dart';
import 'package:beach_tenis_app/app/layers/domain/usecases/config/version_usecase.dart';
import 'package:flutter/cupertino.dart';

class ConfigProvider extends ChangeNotifier {
  final LoadAddressesUsecase _loadAddressesUsecase;
  final SaveAddressesUsecase _saveAddressesUsecase;
  final LoadLastLoggedEmailUsecase _loadLastLoggedEmailUsecase;
  final SaveLastLoggedEmailUsecase _saveLastLoggedEmailUsecase;
  final LoadLastLoggedPasswordUsecase _loadLastLoggedPasswordUsecase;
  final SaveLastLoggedPasswordUsecase _saveLastLoggedPasswordUsecase;
  final VersionUsecase _versionUsecase;
  final CompanyUsecase _companyUsecase;
  final LoadCompanyUsecase _loadCompanyUsecase;
  final SaveConfigUsecase _saveConfigUsecase;
  final LoadConfigUsecase _loadConfigUsecase;
  String? _apiAddress, _environment, _socketAddress;
  bool loaded = false;

  ConfigProvider(
    this._loadAddressesUsecase,
    this._saveAddressesUsecase,
    this._loadLastLoggedEmailUsecase,
    this._saveLastLoggedEmailUsecase,
    this._loadLastLoggedPasswordUsecase,
    this._saveLastLoggedPasswordUsecase,
    this._versionUsecase,
    this._companyUsecase,
    this._loadCompanyUsecase,
    this._saveConfigUsecase,
    this._loadConfigUsecase,
  );

  // Setters:
  set setApiAddress(String string) => _apiAddress = string;
  set setEnvironment(String string) => _environment = string;
  set setSocketAddress(String string) => _socketAddress = string;

  // Getters:
  // String get apiAddress => _apiAddress ?? Endpoints.apiAddress;
  // String get environment => _environment ?? Endpoints.environment;
  // String get socketAddress => _socketAddress ?? Endpoints.socketAddress;

  Future<void> loadAddresses() async {
    await _loadAddressesUsecase(NoParams()).then((result) {
      result.fold(
        (l) {
          // _apiAddress = Endpoints.apiAddress;
          // _environment = Endpoints.environment;
          // _socketAddress = Endpoints.socketAddress;
          loaded = true;
        },
        (r) {
          // _apiAddress = r?['apiAddress'] ?? Endpoints.apiAddress;
          // _environment = r?['environment'] ?? Endpoints.environment;
          // _socketAddress = r?['socketAddress'] ?? Endpoints.socketAddress;
          loaded = true;
        },
      );
    });
  }

  Future<void> saveApiAddresses() async {
    var addresses = {
      'apiAddress': _apiAddress!,
      'environment': _environment!,
      'socketAddress': _socketAddress!,
    };

    await _saveAddressesUsecase(addresses).then((result) {
      result.fold(
        (l) => throw l,
        (r) => null,
      );
    });
  }

  Future<String> loadLastLoggedEmail() async {
    return await _loadLastLoggedEmailUsecase(NoParams()).then((result) {
      return result.fold(
        (l) => throw l,
        (r) => r ?? "",
      );
    });
  }

  Future<void> saveLastLoggedEmail(String email) async {
    await _saveLastLoggedEmailUsecase(email).then((result) {
      result.fold(
        (l) => throw l,
        (r) => null,
      );
    });
  }

  Future<String> loadLastLoggedPassword() async {
    return await _loadLastLoggedPasswordUsecase(NoParams()).then((result) {
      return result.fold(
        (l) => throw l,
        (r) => r ?? "",
      );
    });
  }

  Future<void> saveLastLoggedPassword(String password) async {
    await _saveLastLoggedPasswordUsecase(password).then((result) {
      result.fold(
        (l) => throw l,
        (r) => null,
      );
    });
  }

  // Métodos para salvar e carregar o tipo de usuário
  Future<void> saveUserType(String userType) async {
    await _saveConfigUsecase('user_type:$userType').then((result) {
      result.fold(
        (l) => throw l,
        (r) => null,
      );
    });
  }

  Future<String> loadUserType() async {
    return await _loadConfigUsecase(NoParams()).then((result) {
      return result.fold(
        (l) => '',
        (r) {
          if (r.startsWith('user_type:')) {
            return r.substring('user_type:'.length);
          }
          return '';
        },
      );
    });
  }

  String versionBuild = '';
  Future<String> version() async {
    return await _versionUsecase(NoParams()).then((result) {
      return result.fold(
        (l) => throw l,
        (r) => versionBuild = r,
      );
    });
  }

  Future<void> saveCompany(String value) async {
    await _companyUsecase(value).then((result) {
      result.fold(
        (l) => throw l,
        (r) => null,
      );
    });
  }

  Future<String> loadCompany() async {
    return await _loadCompanyUsecase(NoParams()).then((result) {
      return result.fold(
        (l) => throw l,
        (r) => r,
      );
    });
  }

  Future<void> saveConfig(String value) async {
    await _saveConfigUsecase(value).then((result) {
      result.fold(
        (l) => throw l,
        (r) => null,
      );
    });
  }

  Future<String> loadConfig() async {
    return await _loadConfigUsecase(NoParams()).then((result) {
      return result.fold(
        (l) => throw l,
        (r) => r,
      );
    });
  }
}

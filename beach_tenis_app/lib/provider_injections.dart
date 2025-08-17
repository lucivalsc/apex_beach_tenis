import 'package:beach_tenis_app/app/layers/data/datasources/local/config_datasource.dart';
import 'package:beach_tenis_app/app/layers/data/datasources/local/config_datasource_implementation.dart';
import 'package:beach_tenis_app/app/layers/data/datasources/remote/remote_data_datasource.dart';
import 'package:beach_tenis_app/app/layers/data/datasources/remote/remote_data_datasource_implementation.dart';
import 'package:beach_tenis_app/app/layers/data/repositories/chat_repository_implementation.dart';
import 'package:beach_tenis_app/app/layers/data/repositories/config_repository_implementation.dart';
import 'package:beach_tenis_app/app/layers/data/repositories/data_repository_implementation.dart';
import 'package:beach_tenis_app/app/layers/data/repositories/demandante_repository_implementation.dart';
import 'package:beach_tenis_app/app/layers/data/repositories/donor_repository_implementation.dart';
import 'package:beach_tenis_app/app/layers/data/repositories/match_repository_implementation.dart';
import 'package:beach_tenis_app/app/layers/data/repositories/user_repository_implementation.dart';
import 'package:beach_tenis_app/app/layers/domain/repositories/chat_repository.dart';
import 'package:beach_tenis_app/app/layers/domain/repositories/config_repository.dart';
import 'package:beach_tenis_app/app/layers/domain/repositories/data_repository.dart';
import 'package:beach_tenis_app/app/layers/domain/repositories/demandante_repository.dart';
import 'package:beach_tenis_app/app/layers/domain/repositories/donor_repository.dart';
import 'package:beach_tenis_app/app/layers/domain/repositories/match_repository.dart';
// Importações específicas do Fertilink
import 'package:beach_tenis_app/app/layers/domain/repositories/user_repository.dart';
import 'package:beach_tenis_app/app/layers/domain/usecases/chat/chat_usecases.dart';
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
import 'package:beach_tenis_app/app/layers/domain/usecases/data/datas_usecase.dart';
import 'package:beach_tenis_app/app/layers/domain/usecases/data/get_sync_datas.dart';
import 'package:beach_tenis_app/app/layers/domain/usecases/donor/get_donors_usecase.dart';
import 'package:beach_tenis_app/app/layers/domain/usecases/match/match_usecases.dart';
import 'package:beach_tenis_app/app/layers/domain/usecases/user/user_profile_usecases.dart';
import 'package:beach_tenis_app/app/layers/presenter/providers/config_provider.dart';
import 'package:beach_tenis_app/app/layers/presenter/providers/data_provider.dart';
import 'package:beach_tenis_app/app/layers/presenter/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import 'app/common/http/http_client.dart';
import 'app/common/http/http_client_implementation.dart';
import 'app/layers/data/datasources/remote/auth_datasource.dart';
import 'app/layers/data/datasources/remote/auth_datasource_implementation.dart';
import 'app/layers/data/repositories/auth_repository_implementation.dart';
import 'app/layers/domain/repositories/auth_repository.dart';
import 'app/layers/domain/usecases/auth/sign_in_usecase.dart';
import 'app/layers/presenter/providers/auth_provider.dart';
import 'app/layers/presenter/screens/logged_in/professors_list/professors_list_provider.dart';
import 'app/layers/presenter/screens/logged_in/statistics/statistics_provider.dart';
import 'app/common/providers/theme_provider.dart';

List<SingleChildWidget> providers = [
  ...independentServices,
  ...dependentServices,
  ...consumableProviders,
];

List<SingleChildWidget> independentServices = [
  Provider<IHttpClient>(create: (_) => HttpClientImplementation()),
  Provider<IConfigDatasource>(create: (context) => ConfigDatasourceImplementation()),
  Provider<IConfigRepository>(create: (context) => ConfigRepositoryImplementation(context.read())),
];

List<SingleChildWidget> dependentServices = [
  Provider<IAuthDatasource>(
    create: (context) => AuthDatasourceImplementation(context.read()),
  ),
  Provider<IAuthRepository>(
    create: (context) => AuthRepositoryImplementation(context.read()),
  ),
  // Provider<IUserDatasource>(
  //     create: (context) => UserDatasourceImplementation(context.read())),
  // Provider<IUserRepository>(
  //     create: (context) => UserRepositoryImplementation(context.read())),
  // Provider<IStorageRepository>(
  //     create: (context) => StorageRepositoryImplementation(context.read())),
  // Provider<ILocalDataDatasource>(
  //     create: (context) => LocalDataDatasourceImplementation()),
  Provider<IRemoteDataDatasource>(create: (context) => RemoteDataDatasourceImplementation(context.read())),
  Provider<IDataRepository>(create: (context) => DataRepositoryImplementation(context.read())),

  ////////////////////////////CONFING_DATASOURCE////////////////////////////////
  Provider(create: (context) => LoadAddressesUsecase(context.read())),
  Provider(create: (context) => SaveAddressesUsecase(context.read())),
  Provider(create: (context) => LoadLastLoggedEmailUsecase(context.read())),
  Provider(create: (context) => SaveLastLoggedEmailUsecase(context.read())),
  Provider(create: (context) => LoadLastLoggedPasswordUsecase(context.read())),
  Provider(create: (context) => SaveLastLoggedPasswordUsecase(context.read())),
  Provider(create: (context) => VersionUsecase(context.read())),
  Provider(create: (context) => CompanyUsecase(context.read())),
  Provider(create: (context) => LoadCompanyUsecase(context.read())),
  Provider(create: (context) => SaveConfigUsecase(context.read())),
  Provider(create: (context) => LoadConfigUsecase(context.read())),

  ////////////////////////////AUTH_DATASOURCE///////////////////////////////////
  Provider(create: (context) => SignInUsecase(context.read())),

  ////////////////////////////DATA_PROVIDER/////////////////////////////////////
  Provider(create: (context) => DatasUsecase(context.read())),
  Provider(create: (context) => GetSyncDatasUsecase(context.read())),

  ////////////////////////////FERTILINK_REPOSITORIES/////////////////////////
  Provider<IUserRepository>(
    create: (context) => UserRepositoryImplementation(context.read()),
  ),
  Provider<IDonorRepository>(
    create: (context) => DonorRepositoryImplementation(context.read()),
  ),
  Provider<IMatchRepository>(
    create: (context) => MatchRepositoryImplementation(context.read()),
  ),
  Provider<IDemandanteRepository>(
    create: (context) => DemandanteRepositoryImplementation(context.read()),
  ),
  Provider<IChatRepository>(
    create: (context) => ChatRepositoryImplementation(context.read()),
  ),

  ////////////////////////////FERTILINK_USECASES////////////////////////////
  Provider(create: (context) => GetAvailableDonorsUseCase(context.read())),
  Provider(create: (context) => SearchDonorsUseCase(context.read())),
  Provider(create: (context) => CreateMatchUseCase(context.read())),
  Provider(create: (context) => GetMatchesUseCase(context.read())),
  Provider(
      create: (context) => GetUserProfileUseCase(
            context.read(),
            context.read(),
            context.read(),
          )),
  Provider(create: (context) => SendMessageUseCase(context.read())),
  Provider(create: (context) => GetChatMessagesUseCase(context.read())),
];

List<SingleChildWidget> consumableProviders = [
  ChangeNotifierProvider(
    create: (context) => ThemeProvider(),
  ),
  ChangeNotifierProvider(
    create: (context) => ProfessorsListProvider(),
  ),
  ChangeNotifierProvider(
    create: (context) => StatisticsProvider(),
  ),
  ChangeNotifierProvider(
    create: (context) => ConfigProvider(
      context.read(),
      context.read(),
      context.read(),
      context.read(),
      context.read(),
      context.read(),
      context.read(),
      context.read(),
      context.read(),
      context.read(),
      context.read(),
    ),
  ),
  ChangeNotifierProvider(
    create: (context) => AuthProvider(
      context.read(),
    ),
  ),
  ChangeNotifierProxyProvider<ConfigProvider, UserProvider>(
    create: (context) => UserProvider(),
    update: (_, configProvider, userProvider) => userProvider!..setConfigProvider(configProvider),
  ),
  ChangeNotifierProxyProvider2<ConfigProvider, UserProvider, AuthProvider>(
    create: (context) => AuthProvider(
      context.read(),
    ),
    update: (_, configProvider, userProvider, authProvider) {
      authProvider!.setConfigProvider(configProvider);
      authProvider.setUserProvider(userProvider);
      return authProvider;
    },
  ),
  ChangeNotifierProxyProvider3<ConfigProvider, UserProvider, AuthProvider, DataProvider>(
      create: (context) => DataProvider(
            context.read(),
            context.read(),
            // Casos de uso específicos do Fertilink
            getAvailableDonorsUseCase: context.read(),
            searchDonorsUseCase: context.read(),
            createMatchUseCase: context.read(),
            getMatchesUseCase: context.read(),
            getUserProfileUseCase: context.read(),
            sendMessageUseCase: context.read(),
            getChatMessagesUseCase: context.read(),
          ),
      update: (_, configProvider, userProvider, authProvider, dataProvider) {
        dataProvider!.setConfigProvider(configProvider);
        dataProvider.setUserProvider(userProvider);
        dataProvider.setAuthProvider(authProvider);
        return dataProvider;
      }),
];

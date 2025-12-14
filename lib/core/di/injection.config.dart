// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../features/add_product/data/repository/product_repository_impl.dart'
    as _i651;
import '../../features/add_product/domain/repository/product_repository.dart'
    as _i567;
import '../../features/add_product/domain/usecases/add_product_usecase.dart'
    as _i161;
import '../../features/add_product/domain/usecases/update_product_usecase.dart'
    as _i1056;
import '../../features/add_product/presentation/controllers/bloc/product_bloc.dart'
    as _i640;
import '../../features/auth/data/data_sources/local/auth_local_data_source.dart'
    as _i485;
import '../../features/auth/data/repositories/auth_repository_impl.dart'
    as _i153;
import '../../features/auth/data/repositories/dashboard_repository_impl.dart'
    as _i499;
import '../../features/auth/domain/repositories/auth_repository.dart' as _i787;
import '../../features/auth/domain/repositories/dashboard_repository.dart'
    as _i1029;
import '../../features/auth/domain/usecases/add_user_usecase.dart' as _i816;
import '../../features/auth/domain/usecases/login_usecase.dart' as _i188;
import '../../features/auth/domain/usecases/logout_usecase.dart' as _i48;
import '../../features/auth/domain/usecases/update_password_usecase.dart'
    as _i387;
import '../../features/auth/presentation/controller/auth_bloc.dart' as _i954;
import '../../features/barcode_reader/data/datasources/socket_data_source.dart'
    as _i200;
import '../../features/barcode_reader/data/repositories/chat_repository_impl.dart'
    as _i769;
import '../../features/barcode_reader/data/repositories/socket_repository_impl.dart'
    as _i199;
import '../../features/barcode_reader/domain/repositories/chat_repository.dart'
    as _i774;
import '../../features/barcode_reader/domain/repositories/socket_repository.dart'
    as _i98;
import '../../features/barcode_reader/domain/usecases/auto_connect_to_server.dart'
    as _i391;
import '../../features/barcode_reader/domain/usecases/connect_to_server.dart'
    as _i362;
import '../../features/barcode_reader/domain/usecases/disconnect.dart' as _i3;
import '../../features/barcode_reader/domain/usecases/get_clients.dart'
    as _i856;
import '../../features/barcode_reader/domain/usecases/get_massage.dart'
    as _i495;
import '../../features/barcode_reader/domain/usecases/handle_client_disconnect.dart'
    as _i587;
import '../../features/barcode_reader/domain/usecases/send_message.dart'
    as _i603;
import '../../features/barcode_reader/domain/usecases/start_server.dart'
    as _i36;
import '../../features/barcode_reader/presentation/controller/chat_bloc.dart'
    as _i673;
import '../../features/exports/data/repositories/export_repository_impl.dart'
    as _i1053;
import '../../features/exports/domain/repositories/export_repository.dart'
    as _i36;
import '../../features/exports/domain/usecases/export_to_excel_usecase.dart'
    as _i1021;
import '../../features/exports/domain/usecases/export_to_pdf_usecase.dart'
    as _i566;
import '../../features/exports/presentation/controller/export_bloc.dart'
    as _i689;
import '../../features/get_product/data/repository/product_repository_impl.dart'
    as _i675;
import '../../features/get_product/domain/repository/product_repository.dart'
    as _i85;
import '../../features/get_product/domain/usecases/get_product_usecase.dart'
    as _i830;
import '../../features/get_product/domain/usecases/get_products_usecase.dart'
    as _i642;
import '../../features/get_product/presentation/controllers/bloc/get_product_bloc.dart'
    as _i295;
import '../../features/purchase/data/data_sources/purchase_local_data_source.dart'
    as _i588;
import '../../features/purchase/data/repositories/purchase_repository_impl.dart'
    as _i254;
import '../../features/purchase/domain/repositories/purchase_repository.dart'
    as _i220;
import '../../features/purchase/presentation/controller/purchase_bloc.dart'
    as _i796;
import '../../features/reports/data/data_sources/reports_local_data_source.dart'
    as _i260;
import '../../features/reports/data/repositories/reports_repository_impl.dart'
    as _i227;
import '../../features/reports/domain/repositories/reports_repository.dart'
    as _i808;
import '../../features/reports/presentation/controller/reports_bloc.dart'
    as _i241;
import '../../features/sales/data/data_sources/sales_local_data_source.dart'
    as _i929;
import '../../features/sales/data/repositories/sales_repository_impl.dart'
    as _i779;
import '../../features/sales/domain/repositories/sales_repository.dart'
    as _i434;
import '../../features/sales/presentation/controller/sales_bloc.dart' as _i292;
import '../../features/upgrader/data/datasource/version_remote_data_source.dart'
    as _i863;
import '../../features/upgrader/data/repositories/version_repository_impl.dart'
    as _i171;
import '../../features/upgrader/data/services/update_service.dart' as _i22;
import '../../features/upgrader/domain/repositories/version_repository.dart'
    as _i85;
import '../../features/upgrader/domain/usecases/check_for_update.dart' as _i701;
import '../../features/upgrader/domain/usecases/download_and_install_update.dart'
    as _i418;
import '../../features/upgrader/presentation/controllers/bloc/update_bloc.dart'
    as _i169;
import '../database/app_database.dart' as _i982;
import '../database/daos/event_dao.dart' as _i565;
import '../database/daos/language_dao.dart' as _i192;
import '../database/daos/product_dao.dart' as _i924;
import '../database/daos/purchase_dao.dart' as _i257;
import '../database/daos/sales_dao.dart' as _i340;
import '../database/daos/theme_dao.dart' as _i905;
import '../database/daos/user_dao.dart' as _i794;
import '../services/event_service.dart' as _i273;
import '../shared/localization/data/data_sources/local/language_local_data_source.dart'
    as _i149;
import '../shared/localization/data/repositories/language_repository_impl.dart'
    as _i789;
import '../shared/localization/domain/repositories/language_repository.dart'
    as _i645;
import '../shared/localization/domain/usecases/get_language_usecase.dart'
    as _i924;
import '../shared/localization/domain/usecases/save_language_usecase.dart'
    as _i383;
import '../shared/localization/presentation/controller/language_bloc.dart'
    as _i32;
import '../shared/product/data/repositories/product_stock_repository_impl.dart'
    as _i436;
import '../shared/product/domain/repositories/product_stock_repository.dart'
    as _i990;
import '../shared/theme/data/data_sources/local/theme_local_data_source.dart'
    as _i222;
import '../shared/theme/data/repositories/theme_repository_impl.dart' as _i107;
import '../shared/theme/domain/repositories/theme_repository.dart' as _i1012;
import '../shared/theme/domain/usecases/get_theme_usecase.dart' as _i473;
import '../shared/theme/domain/usecases/save_theme_usecase.dart' as _i374;
import '../shared/theme/presentation/controller/theme_bloc.dart' as _i1026;
import 'register_module.dart' as _i291;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final registerModule = _$RegisterModule();
    await gh.singletonAsync<_i982.AppDatabase>(
      () => registerModule.database,
      preResolve: true,
    );
    gh.lazySingleton<_i361.Dio>(() => registerModule.dio);
    gh.lazySingleton<_i200.SocketDataSource>(() => _i200.SocketDataSource());
    gh.lazySingleton<_i863.VersionRemoteDataSource>(
      () => _i863.VersionRemoteDataSourceImpl(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i98.SocketRepository>(
      () => _i199.SocketRepositoryImpl(gh<_i200.SocketDataSource>()),
    );
    gh.lazySingleton<_i774.ChatRepository>(
      () => _i769.ChatRepositoryImpl(gh<_i200.SocketDataSource>()),
    );
    gh.lazySingleton<_i22.UpdateService>(
      () => _i22.UpdateService(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i36.ExportRepository>(
      () => _i1053.ExportRepositoryImpl(),
    );
    gh.factory<_i1021.ExportToExcelUseCase>(
      () => _i1021.ExportToExcelUseCase(gh<_i36.ExportRepository>()),
    );
    gh.factory<_i566.ExportToPDFUseCase>(
      () => _i566.ExportToPDFUseCase(gh<_i36.ExportRepository>()),
    );
    gh.factory<_i856.GetClientsUseCase>(
      () => _i856.GetClientsUseCase(gh<_i98.SocketRepository>()),
    );
    gh.factory<_i689.ExportBloc>(
      () => _i689.ExportBloc(
        gh<_i566.ExportToPDFUseCase>(),
        gh<_i1021.ExportToExcelUseCase>(),
      ),
    );
    gh.factory<_i391.AutoConnectToServerUseCase>(
      () => _i391.AutoConnectToServerUseCase(gh<_i774.ChatRepository>()),
    );
    gh.factory<_i362.ConnectToServerUseCase>(
      () => _i362.ConnectToServerUseCase(gh<_i774.ChatRepository>()),
    );
    gh.factory<_i3.DisconnectUseCase>(
      () => _i3.DisconnectUseCase(gh<_i774.ChatRepository>()),
    );
    gh.factory<_i495.GetMessagesUseCase>(
      () => _i495.GetMessagesUseCase(gh<_i774.ChatRepository>()),
    );
    gh.factory<_i587.HandleClientDisconnectionUseCase>(
      () => _i587.HandleClientDisconnectionUseCase(gh<_i774.ChatRepository>()),
    );
    gh.factory<_i603.SendMessageUseCase>(
      () => _i603.SendMessageUseCase(gh<_i774.ChatRepository>()),
    );
    gh.factory<_i36.StartServerUseCase>(
      () => _i36.StartServerUseCase(gh<_i774.ChatRepository>()),
    );
    gh.lazySingleton<_i924.ProductDao>(
      () => registerModule.productDao(gh<_i982.AppDatabase>()),
    );
    gh.lazySingleton<_i794.UserDao>(
      () => registerModule.userDao(gh<_i982.AppDatabase>()),
    );
    gh.lazySingleton<_i905.ThemeDao>(
      () => registerModule.themeDao(gh<_i982.AppDatabase>()),
    );
    gh.lazySingleton<_i192.LanguageDao>(
      () => registerModule.languageDao(gh<_i982.AppDatabase>()),
    );
    gh.lazySingleton<_i340.SalesDao>(
      () => registerModule.salesDao(gh<_i982.AppDatabase>()),
    );
    gh.lazySingleton<_i257.PurchaseDao>(
      () => registerModule.purchaseDao(gh<_i982.AppDatabase>()),
    );
    gh.lazySingleton<_i565.EventDao>(
      () => registerModule.eventDao(gh<_i982.AppDatabase>()),
    );
    gh.lazySingleton<_i85.VersionRepository>(
      () => _i171.VersionRepositoryImpl(
        gh<_i863.VersionRemoteDataSource>(),
        gh<_i22.UpdateService>(),
      ),
    );
    gh.lazySingleton<_i273.EventService>(
      () => _i273.EventService(gh<_i565.EventDao>()),
    );
    gh.lazySingleton<_i149.LanguageLocalDataSource>(
      () => _i149.LanguageLocalDataSource(gh<_i192.LanguageDao>()),
    );
    gh.factory<_i588.PurchaseLocalDataSource>(
      () => _i588.PurchaseLocalDataSource(
        gh<_i257.PurchaseDao>(),
        gh<_i924.ProductDao>(),
      ),
    );
    gh.factory<_i990.ProductStockRepository>(
      () => _i436.ProductStockRepositoryImpl(gh<_i924.ProductDao>()),
    );
    gh.lazySingleton<_i85.ProductRepository>(
      () => _i675.ProductRepositoryImpl(gh<_i924.ProductDao>()),
    );
    gh.factory<_i260.ReportsLocalDataSource>(
      () => _i260.ReportsLocalDataSource(
        gh<_i340.SalesDao>(),
        gh<_i924.ProductDao>(),
      ),
    );
    gh.factory<_i929.SalesLocalDataSource>(
      () => _i929.SalesLocalDataSource(
        gh<_i340.SalesDao>(),
        gh<_i924.ProductDao>(),
      ),
    );
    gh.factory<_i701.CheckForUpdate>(
      () => _i701.CheckForUpdate(gh<_i85.VersionRepository>()),
    );
    gh.factory<_i418.DownloadAndInstallUpdate>(
      () => _i418.DownloadAndInstallUpdate(gh<_i85.VersionRepository>()),
    );
    gh.factory<_i808.ReportsRepository>(
      () => _i227.ReportsRepositoryImpl(gh<_i260.ReportsLocalDataSource>()),
    );
    gh.factory<_i241.ReportsBloc>(
      () => _i241.ReportsBloc(gh<_i808.ReportsRepository>()),
    );
    gh.lazySingleton<_i222.ThemeLocalDataSource>(
      () => _i222.ThemeLocalDataSource(gh<_i905.ThemeDao>()),
    );
    gh.lazySingleton<_i485.AuthLocalDataSource>(
      () => _i485.AuthLocalDataSource(gh<_i794.UserDao>()),
    );
    gh.factory<_i830.GetProductBySerialUseCase>(
      () => _i830.GetProductBySerialUseCase(gh<_i85.ProductRepository>()),
    );
    gh.factory<_i642.GetProductsUseCase>(
      () => _i642.GetProductsUseCase(gh<_i85.ProductRepository>()),
    );
    gh.factory<_i673.ChatBloc>(
      () => _i673.ChatBloc(
        sendMessageUseCase: gh<_i603.SendMessageUseCase>(),
        startServerUseCase: gh<_i36.StartServerUseCase>(),
        connectToServerUseCase: gh<_i362.ConnectToServerUseCase>(),
        autoConnectToServerUseCase: gh<_i391.AutoConnectToServerUseCase>(),
        disconnectUseCase: gh<_i3.DisconnectUseCase>(),
        getMessagesUseCase: gh<_i495.GetMessagesUseCase>(),
        getClientsUseCase: gh<_i856.GetClientsUseCase>(),
        handleClientDisconnectionUseCase:
            gh<_i587.HandleClientDisconnectionUseCase>(),
      ),
    );
    gh.factory<_i1029.DashboardRepository>(
      () => _i499.DashboardRepositoryImpl(
        gh<_i924.ProductDao>(),
        gh<_i340.SalesDao>(),
      ),
    );
    gh.lazySingleton<_i567.ProductRepository>(
      () => _i651.ProductRepositoryImpl(
        gh<_i924.ProductDao>(),
        gh<_i273.EventService>(),
      ),
    );
    gh.factory<_i161.AddProduct>(
      () => _i161.AddProductUsecase(gh<_i567.ProductRepository>()),
    );
    gh.lazySingleton<_i787.AuthRepository>(
      () => _i153.AuthRepositoryImpl(gh<_i485.AuthLocalDataSource>()),
    );
    gh.factory<_i188.LoginUseCase>(
      () => _i188.LoginUseCase(gh<_i787.AuthRepository>()),
    );
    gh.factory<_i387.UpdatePasswordUseCase>(
      () => _i387.UpdatePasswordUseCase(gh<_i787.AuthRepository>()),
    );
    gh.factory<_i434.SalesRepository>(
      () => _i779.SalesRepositoryImpl(
        gh<_i929.SalesLocalDataSource>(),
        gh<_i990.ProductStockRepository>(),
        gh<_i273.EventService>(),
      ),
    );
    gh.lazySingleton<_i645.LanguageRepository>(
      () => _i789.LanguageRepositoryImpl(gh<_i149.LanguageLocalDataSource>()),
    );
    gh.factory<_i169.UpdateBloc>(
      () => _i169.UpdateBloc(
        checkForUpdate: gh<_i701.CheckForUpdate>(),
        downloadAndInstallUpdate: gh<_i418.DownloadAndInstallUpdate>(),
      ),
    );
    gh.factory<_i220.PurchaseRepository>(
      () => _i254.PurchaseRepositoryImpl(
        gh<_i588.PurchaseLocalDataSource>(),
        gh<_i990.ProductStockRepository>(),
        gh<_i273.EventService>(),
      ),
    );
    gh.factory<_i816.AddUserUseCase>(
      () => _i816.AddUserUseCase(gh<_i787.AuthRepository>()),
    );
    gh.factory<_i48.LogoutUseCase>(
      () => _i48.LogoutUseCase(gh<_i787.AuthRepository>()),
    );
    gh.factory<_i292.SalesBloc>(
      () => _i292.SalesBloc(gh<_i434.SalesRepository>()),
    );
    gh.factory<_i1056.UpdateProductUseCase>(
      () => _i1056.UpdateProductUseCase(gh<_i567.ProductRepository>()),
    );
    gh.lazySingleton<_i1012.ThemeRepository>(
      () => _i107.ThemeRepositoryImpl(gh<_i222.ThemeLocalDataSource>()),
    );
    gh.factory<_i473.GetThemeUseCase>(
      () => _i473.GetThemeUseCase(gh<_i1012.ThemeRepository>()),
    );
    gh.factory<_i374.SaveThemeUseCase>(
      () => _i374.SaveThemeUseCase(gh<_i1012.ThemeRepository>()),
    );
    gh.factory<_i295.GetProductBloc>(
      () => _i295.GetProductBloc(
        getProductsUseCase: gh<_i642.GetProductsUseCase>(),
        getProductBySerialUseCase: gh<_i830.GetProductBySerialUseCase>(),
      ),
    );
    gh.factory<_i924.GetLanguageUseCase>(
      () => _i924.GetLanguageUseCase(gh<_i645.LanguageRepository>()),
    );
    gh.factory<_i383.SaveLanguageUseCase>(
      () => _i383.SaveLanguageUseCase(gh<_i645.LanguageRepository>()),
    );
    gh.factory<_i954.AuthBloc>(
      () => _i954.AuthBloc(
        loginUseCase: gh<_i188.LoginUseCase>(),
        updatePasswordUseCase: gh<_i387.UpdatePasswordUseCase>(),
        logoutUseCase: gh<_i48.LogoutUseCase>(),
        addUserUseCase: gh<_i816.AddUserUseCase>(),
      ),
    );
    gh.factory<_i32.LanguageBloc>(
      () => _i32.LanguageBloc(
        getLanguageUseCase: gh<_i924.GetLanguageUseCase>(),
        saveLanguageUseCase: gh<_i383.SaveLanguageUseCase>(),
      ),
    );
    gh.factory<_i1026.ThemeBloc>(
      () => _i1026.ThemeBloc(
        getThemeUseCase: gh<_i473.GetThemeUseCase>(),
        saveThemeUseCase: gh<_i374.SaveThemeUseCase>(),
      ),
    );
    gh.factory<_i796.PurchaseBloc>(
      () => _i796.PurchaseBloc(gh<_i220.PurchaseRepository>()),
    );
    gh.factory<_i640.ProductBloc>(
      () => _i640.ProductBloc(
        addProduct: gh<_i161.AddProduct>(),
        updateProduct: gh<_i1056.UpdateProductUseCase>(),
      ),
    );
    return this;
  }
}

class _$RegisterModule extends _i291.RegisterModule {}

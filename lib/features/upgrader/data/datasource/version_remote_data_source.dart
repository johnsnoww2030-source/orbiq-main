import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:orbiq/core/env/env_config.dart';
import 'package:orbiq/features/upgrader/data/model/version_info_model.dart';

abstract class VersionRemoteDataSource {
  Future<VersionInfoModel> getVersionInfo();
}

class VersionRemoteDataSourceImpl implements VersionRemoteDataSource {
  final Dio dio;

  VersionRemoteDataSourceImpl(this.dio);

  @override
  Future<VersionInfoModel> getVersionInfo() async {
    try {
      final response = await dio.get(EnvConfig.versionUrl);
      if (response.statusCode == 200 && response.data != null) {
        return VersionInfoModel.fromJson(jsonDecode(response.data));
      }
      throw DioException(
        requestOptions: RequestOptions(path: EnvConfig.versionUrl),
        error: 'Invalid response format',
      );
    } on DioException catch (e) {
      throw Exception('Network error: ${e.message}');
    } catch (e) {
      throw Exception('Failed to parse version info: $e');
    }
  }
}

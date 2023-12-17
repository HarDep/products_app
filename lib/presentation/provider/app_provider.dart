import 'package:flutter/material.dart';
import 'package:products_app/domain/repository/api_repository.dart';
import 'package:products_app/domain/repository/local_storage_repository.dart';

class AppProvider extends ChangeNotifier {
  final LocalRepositoryInterface? localRepositoryInterface;
  final ApiRepositoryInterface? apiRepositoryInterface;

  AppProvider({this.localRepositoryInterface, this.apiRepositoryInterface});

  /* void validateSesion() async {
    final String? token = await localRepositoryInterface!.getToken();
  } */
}

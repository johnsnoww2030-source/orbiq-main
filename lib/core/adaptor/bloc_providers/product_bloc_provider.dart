import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orbiq/core/database/app_database.dart';
import 'package:orbiq/features/add_product/data/repository/product_repository_impl.dart'
    as add_repo;
import 'package:orbiq/features/get_product/data/repository/product_repository_impl.dart'
    as get_repo;
import 'package:orbiq/features/add_product/domain/usecases/add_product_usecase.dart';
import 'package:orbiq/features/add_product/domain/usecases/update_product_usecase.dart';
import 'package:orbiq/features/get_product/domain/usecases/get_product_usecase.dart';
import 'package:orbiq/features/get_product/domain/usecases/get_products_usecase.dart';
import 'package:orbiq/features/add_product/presentation/controllers/bloc/product_bloc.dart';
import 'package:orbiq/features/get_product/presentation/controllers/bloc/get_product_bloc.dart';

List<BlocProvider> productBlocProviders(AppDatabase database) {
  final productDao = database.productDao;
  final addProductRepository = add_repo.ProductRepositoryImpl(productDao);
  final getProductRepository = get_repo.ProductRepositoryImpl(productDao);

  // ایجاد UpdateProductUseCase
  final updateProductUseCase = UpdateProductUseCase(addProductRepository);

  return [
    BlocProvider<ProductBloc>(
      create: (context) => ProductBloc(
        addProduct: AddProductUsecase(addProductRepository),
        getProductsUseCase: GetProductsUseCase(getProductRepository),
        updateProduct: updateProductUseCase,
      ),
    ),
    BlocProvider<GetProductBloc>(
      create: (context) => GetProductBloc(
        getProductsUseCase: GetProductsUseCase(getProductRepository),
        getProductBySerialUseCase: GetProductBySerialUseCase(
          getProductRepository,
        ),
      ),
    ),
  ];
}

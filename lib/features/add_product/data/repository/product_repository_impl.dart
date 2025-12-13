import 'package:injectable/injectable.dart';
import 'package:orbiq/core/database/daos/product_dao.dart';
import 'package:orbiq/core/shared/product/data/mappers/product_mapper.dart';
import 'package:orbiq/core/shared/product/domain/entities/product_entity.dart';
import 'package:orbiq/core/services/event_service.dart';
import 'package:orbiq/features/add_product/domain/repository/product_repository.dart';

@LazySingleton(as: ProductRepository)
class ProductRepositoryImpl implements ProductRepository {
  final ProductDao _productDao;
  final EventService _eventService;

  ProductRepositoryImpl(this._productDao, this._eventService);

  @override
  Future<void> addProduct(ProductEntity product) async {
    final companion = ProductMapper.toCompanion(product);
    await _productDao.insertProduct(companion);

    // Log event
    await _eventService.logProductCreated(
      productId: product.uuid ?? companion.productUuid.value,
      productName: product.name,
    );
  }

  @override
  Future<void> updateProduct(ProductEntity product) async {
    if (product.uuid != null) {
      final existing = await _productDao.getProductByUuid(product.uuid!);
      if (existing != null) {
        final companion = ProductMapper.toCompanion(
          product,
          existingUuid: product.uuid,
        );
        await _productDao.updateProductByUuid(product.uuid!, companion);

        // Log event with changes
        await _eventService.logProductUpdated(
          productId: product.uuid!,
          productName: product.name,
          changes: {
            'name': product.name != existing.name
                ? {'old': existing.name, 'new': product.name}
                : null,
            'price': product.originalPrice != existing.originalPrice
                ? {'old': existing.originalPrice, 'new': product.originalPrice}
                : null,
          }..removeWhere((_, v) => v == null),
        );
      }
    }
  }
}

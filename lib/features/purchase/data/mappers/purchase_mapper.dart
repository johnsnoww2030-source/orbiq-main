import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';
import 'package:orbiq/core/database/app_database.dart';
import 'package:orbiq/features/purchase/domain/entities/purchase_entity.dart';

/// Mapper to convert between Drift database models and domain entities
class PurchaseMapper {
  static const _uuid = Uuid();

  /// Convert Drift PurchaseInvoice to domain PurchaseEntity
  static PurchaseEntity fromDrift(
    PurchaseInvoice invoice, [
    List<PurchaseItemEntity> items = const [],
  ]) {
    return PurchaseEntity(
      purchaseUuid: invoice.purchaseUuid,
      supplierName: invoice.supplierName,
      purchaseDate: invoice.purchaseDate,
      totalCost: invoice.totalCost,
      additionalCosts: invoice.additionalCosts,
      finalTotal: invoice.finalTotal,
      notes: invoice.notes,
      syncStatus: invoice.syncStatus,
      createdAt: invoice.createdAt,
      updatedAt: invoice.updatedAt,
      items: items,
    );
  }

  /// Convert domain PurchaseEntity to Drift Companion for insert
  static PurchaseInvoicesCompanion toCompanion(PurchaseEntity entity) {
    final uuid = entity.purchaseUuid.isEmpty ? _uuid.v4() : entity.purchaseUuid;
    final now = DateTime.now();

    return PurchaseInvoicesCompanion(
      purchaseUuid: Value(uuid),
      supplierName: Value(entity.supplierName),
      purchaseDate: Value(entity.purchaseDate),
      totalCost: Value(entity.totalCost),
      additionalCosts: Value(entity.additionalCosts),
      finalTotal: Value(entity.finalTotal),
      notes: Value(entity.notes),
      syncStatus: Value(entity.syncStatus),
      createdAt: Value(
        entity.createdAt == DateTime(1970) ? now : entity.createdAt,
      ),
      updatedAt: Value(now),
    );
  }

  /// Convert Drift PurchaseItem to domain PurchaseItemEntity
  static PurchaseItemEntity itemFromDrift(
    PurchaseItem item, [
    String? productName,
  ]) {
    return PurchaseItemEntity(
      itemUuid: item.itemUuid,
      purchaseUuid: item.purchaseUuid,
      productUuid: item.productUuid,
      productName: productName,
      quantity: item.quantity,
      unitBuyPrice: item.unitBuyPrice,
      totalPrice: item.totalPrice,
      // Phase 2: Currency fields
      currencyCode: item.currencyCode,
      exchangeRateAtPurchase: item.exchangeRateAtPurchase,
      costInBaseCurrency: item.costInBaseCurrency,
    );
  }

  /// Convert domain PurchaseItemEntity to Drift Companion for insert
  static PurchaseItemsCompanion itemToCompanion(
    PurchaseItemEntity entity,
    String purchaseUuid,
  ) {
    final uuid = entity.itemUuid.isEmpty ? _uuid.v4() : entity.itemUuid;

    return PurchaseItemsCompanion(
      itemUuid: Value(uuid),
      purchaseUuid: Value(purchaseUuid),
      productUuid: Value(entity.productUuid),
      quantity: Value(entity.quantity),
      unitBuyPrice: Value(entity.unitBuyPrice),
      totalPrice: Value(entity.totalPrice),
      // Phase 2: Currency fields
      currencyCode: Value(entity.currencyCode),
      exchangeRateAtPurchase: Value(entity.exchangeRateAtPurchase),
      costInBaseCurrency: Value(entity.costInBaseCurrency),
    );
  }
}

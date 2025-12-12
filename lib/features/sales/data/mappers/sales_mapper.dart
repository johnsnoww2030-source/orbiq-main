import 'package:drift/drift.dart';
import 'package:orbiq/core/database/app_database.dart';
import 'package:orbiq/features/sales/domain/entities/sales_entity.dart';
import 'package:uuid/uuid.dart';

/// Mapper for converting between Drift Sales models and domain entities
class SalesMapper {
  static const _uuid = Uuid();

  /// Convert Drift SalesInvoice to domain SalesEntity
  static SalesEntity fromDrift(
    SalesInvoice invoice, [
    List<SalesItemEntity> items = const [],
  ]) {
    return SalesEntity(
      invoiceUuid: invoice.invoiceUuid,
      customerInfo: invoice.customerInfo,
      invoiceDate: invoice.invoiceDate,
      totalAmount: invoice.totalAmount,
      salesSource: invoice.salesSource,
      status: invoice.status,
      userUuid: invoice.userUuid,
      notes: invoice.notes,
      syncStatus: invoice.syncStatus,
      createdAt: invoice.createdAt,
      updatedAt: invoice.updatedAt,
      items: items,
    );
  }

  /// Convert domain SalesEntity to Drift SalesInvoicesCompanion
  static SalesInvoicesCompanion toCompanion(SalesEntity entity) {
    final uuid = entity.invoiceUuid.isEmpty ? _uuid.v4() : entity.invoiceUuid;
    final now = DateTime.now();

    return SalesInvoicesCompanion(
      invoiceUuid: Value(uuid),
      customerInfo: Value(entity.customerInfo),
      invoiceDate: Value(entity.invoiceDate),
      totalAmount: Value(entity.totalAmount),
      salesSource: Value(entity.salesSource),
      status: Value(entity.status),
      userUuid: Value(entity.userUuid),
      notes: Value(entity.notes),
      syncStatus: Value(entity.syncStatus),
      createdAt: Value(
        entity.createdAt == DateTime(1970) ? now : entity.createdAt,
      ),
      updatedAt: Value(now),
    );
  }

  /// Convert Drift SalesItem to domain SalesItemEntity
  static SalesItemEntity itemFromDrift(SalesItem item, [String? productName]) {
    return SalesItemEntity(
      itemUuid: item.itemUuid,
      invoiceUuid: item.invoiceUuid,
      productUuid: item.productUuid,
      productName: productName,
      quantity: item.quantity,
      unitSellPrice: item.unitSellPrice,
      costAtSale: item.costAtSale,
      totalPrice: item.totalPrice,
      profit: item.profit,
    );
  }

  /// Convert domain SalesItemEntity to Drift SalesItemsCompanion
  static SalesItemsCompanion itemToCompanion(
    SalesItemEntity entity,
    String invoiceUuid,
  ) {
    final uuid = entity.itemUuid.isEmpty ? _uuid.v4() : entity.itemUuid;
    final totalPrice = entity.quantity * entity.unitSellPrice;
    final profit = (entity.unitSellPrice - entity.costAtSale) * entity.quantity;

    return SalesItemsCompanion(
      itemUuid: Value(uuid),
      invoiceUuid: Value(invoiceUuid),
      productUuid: Value(entity.productUuid),
      quantity: Value(entity.quantity),
      unitSellPrice: Value(entity.unitSellPrice),
      costAtSale: Value(entity.costAtSale),
      totalPrice: Value(totalPrice),
      profit: Value(profit),
    );
  }
}

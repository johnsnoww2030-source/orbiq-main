import 'dart:convert';
import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:uuid/uuid.dart';
import 'package:orbiq/core/database/daos/event_dao.dart';
import 'package:orbiq/core/database/app_database.dart';

/// Event types for audit trail
/// Based on PRD 1.1 Phase 6
enum EventType {
  // Product events
  productCreated,
  productUpdated,
  priceChanged,

  // Purchase events
  purchaseCreated,
  purchaseDeleted,
  stockAdded,

  // Sales events
  saleCreated,
  stockRemoved,
}

/// Entity types for categorization
enum EntityType { product, purchase, sale }

/// Extension to get string representation
extension EventTypeExtension on EventType {
  String get value {
    switch (this) {
      case EventType.productCreated:
        return 'PRODUCT_CREATED';
      case EventType.productUpdated:
        return 'PRODUCT_UPDATED';
      case EventType.priceChanged:
        return 'PRICE_CHANGED';
      case EventType.purchaseCreated:
        return 'PURCHASE_CREATED';
      case EventType.stockAdded:
        return 'STOCK_ADDED';
      case EventType.purchaseDeleted:
        return 'PURCHASE_DELETED';
      case EventType.saleCreated:
        return 'SALE_CREATED';
      case EventType.stockRemoved:
        return 'STOCK_REMOVED';
    }
  }
}

extension EntityTypeExtension on EntityType {
  String get value {
    switch (this) {
      case EntityType.product:
        return 'Product';
      case EntityType.purchase:
        return 'Purchase';
      case EntityType.sale:
        return 'Sale';
    }
  }
}

/// EventService - Injectable singleton for logging events
/// Provides audit trail and preparation for future AI features
@lazySingleton
class EventService {
  final EventDao _eventDao;
  static const _uuid = Uuid();

  EventService(this._eventDao);

  /// Log an event to the database
  ///
  /// [type] - The type of event
  /// [entityType] - The type of entity (Product, Purchase, Sale)
  /// [entityId] - The UUID of the entity
  /// [payload] - Map of data to store (will be JSON encoded)
  /// [userUuid] - Optional user UUID
  /// [metadata] - Optional additional metadata
  Future<void> logEvent({
    required EventType type,
    required EntityType entityType,
    required String entityId,
    required Map<String, dynamic> payload,
    String? userUuid,
    Map<String, dynamic>? metadata,
  }) async {
    try {
      final event = EventsCompanion(
        eventId: Value(_uuid.v4()),
        eventType: Value(type.value),
        entityType: Value(entityType.value),
        entityId: Value(entityId),
        payload: Value(jsonEncode(payload)),
        userUuid: Value(userUuid),
        timestamp: Value(DateTime.now()),
        metadata: Value(metadata != null ? jsonEncode(metadata) : null),
      );

      await _eventDao.insertEvent(event);
      debugPrint(
        '📝 Event logged: ${type.value} for ${entityType.value}:$entityId',
      );
    } catch (e) {
      debugPrint('⚠️ Error logging event: $e');
      // Don't throw - event logging should not break main flow
    }
  }

  /// Convenience method for product created event
  Future<void> logProductCreated({
    required String productId,
    required String productName,
    String? userUuid,
  }) {
    return logEvent(
      type: EventType.productCreated,
      entityType: EntityType.product,
      entityId: productId,
      payload: {'productName': productName},
      userUuid: userUuid,
    );
  }

  /// Convenience method for product updated event
  Future<void> logProductUpdated({
    required String productId,
    required String productName,
    required Map<String, dynamic> changes,
    String? userUuid,
  }) {
    return logEvent(
      type: EventType.productUpdated,
      entityType: EntityType.product,
      entityId: productId,
      payload: {'productName': productName, 'changes': changes},
      userUuid: userUuid,
    );
  }

  /// Convenience method for price changed event
  Future<void> logPriceChanged({
    required String productId,
    required String productName,
    required double oldPrice,
    required double newPrice,
    String? userUuid,
  }) {
    return logEvent(
      type: EventType.priceChanged,
      entityType: EntityType.product,
      entityId: productId,
      payload: {
        'productName': productName,
        'oldPrice': oldPrice,
        'newPrice': newPrice,
      },
      userUuid: userUuid,
    );
  }

  /// Convenience method for purchase created event
  Future<void> logPurchaseCreated({
    required String purchaseId,
    required String supplierName,
    required double totalCost,
    required int itemCount,
    String? userUuid,
  }) {
    return logEvent(
      type: EventType.purchaseCreated,
      entityType: EntityType.purchase,
      entityId: purchaseId,
      payload: {
        'supplierName': supplierName,
        'totalCost': totalCost,
        'itemCount': itemCount,
      },
      userUuid: userUuid,
    );
  }

  /// Convenience method for stock added event
  Future<void> logStockAdded({
    required String productId,
    required String productName,
    required int quantity,
    required double unitPrice,
    String? purchaseId,
    String? userUuid,
  }) {
    return logEvent(
      type: EventType.stockAdded,
      entityType: EntityType.product,
      entityId: productId,
      payload: {
        'productName': productName,
        'quantity': quantity,
        'unitPrice': unitPrice,
      },
      metadata: purchaseId != null ? {'purchaseId': purchaseId} : null,
      userUuid: userUuid,
    );
  }

  /// Convenience method for sale created event
  Future<void> logSaleCreated({
    required String saleId,
    required double totalSales,
    required double profit,
    required int itemCount,
    String? userUuid,
  }) {
    return logEvent(
      type: EventType.saleCreated,
      entityType: EntityType.sale,
      entityId: saleId,
      payload: {
        'totalSales': totalSales,
        'profit': profit,
        'itemCount': itemCount,
      },
      userUuid: userUuid,
    );
  }

  /// Convenience method for stock removed event
  Future<void> logStockRemoved({
    required String productId,
    required String productName,
    required int quantity,
    required double unitPrice,
    String? saleId,
    String? userUuid,
  }) {
    return logEvent(
      type: EventType.stockRemoved,
      entityType: EntityType.product,
      entityId: productId,
      payload: {
        'productName': productName,
        'quantity': quantity,
        'unitPrice': unitPrice,
      },
      metadata: saleId != null ? {'saleId': saleId} : null,
      userUuid: userUuid,
    );
  }

  /// Convenience method for purchase deleted event
  Future<void> logPurchaseDeleted({
    required String purchaseId,
    required String supplierName,
    required double totalCost,
    required int itemCount,
    String? userUuid,
  }) {
    return logEvent(
      type: EventType.purchaseDeleted,
      entityType: EntityType.purchase,
      entityId: purchaseId,
      payload: {
        'supplierName': supplierName,
        'totalCost': totalCost,
        'itemCount': itemCount,
      },
      userUuid: userUuid,
    );
  }

  /// Log an error message (for debugging/audit purposes)
  void logError({required String message}) {
    debugPrint('⚠️ Error: $message');
  }

  /// Get recent events
  Future<List<Event>> getRecentEvents({int limit = 50}) {
    return _eventDao.getRecentEvents(limit: limit);
  }

  /// Get events for a specific entity
  Future<List<Event>> getEventsForEntity(String entityId) {
    return _eventDao.getEventsByEntityId(entityId);
  }
}

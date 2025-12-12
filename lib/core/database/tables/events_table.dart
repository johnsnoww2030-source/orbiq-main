import 'package:drift/drift.dart';

/// Events table - for event sourcing and audit trail
/// From PRD section 4.5
class Events extends Table {
  TextColumn get eventId => text()();
  TextColumn get eventType => text()(); // PRODUCT_ADDED, SALE_COMPLETED, etc.
  TextColumn get entityType => text()(); // Product, SalesInvoice, etc.
  TextColumn get entityId => text()();
  TextColumn get payload => text()(); // JSON data
  TextColumn get userUuid => text().nullable()();
  DateTimeColumn get timestamp => dateTime()();
  TextColumn get metadata => text().nullable()(); // Additional info as JSON

  @override
  Set<Column> get primaryKey => {eventId};
}

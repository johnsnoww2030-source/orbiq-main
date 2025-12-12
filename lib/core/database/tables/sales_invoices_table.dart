import 'package:drift/drift.dart';
import 'users_table.dart';

/// Sales Invoices table - replaces old Payments
/// From PRD section 4.3
class SalesInvoices extends Table {
  TextColumn get invoiceUuid => text()();
  TextColumn get customerInfo => text().nullable()();
  DateTimeColumn get invoiceDate => dateTime()();
  RealColumn get totalAmount => real().withDefault(const Constant(0.0))();
  TextColumn get salesSource =>
      text().withDefault(const Constant('LOCAL'))(); // LOCAL, ONLINE
  TextColumn get status => text().withDefault(
    const Constant('PENDING'),
  )(); // PENDING, COMPLETED, CANCELLED
  TextColumn get userUuid => text().references(Users, #userUuid)();
  TextColumn get notes => text().nullable()();
  IntColumn get syncStatus => integer().withDefault(const Constant(0))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {invoiceUuid};
}

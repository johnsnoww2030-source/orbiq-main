import 'package:drift/drift.dart';
import '../app_database.dart';
import '../tables/events_table.dart';

part 'event_dao.g.dart';

@DriftAccessor(tables: [Events])
class EventDao extends DatabaseAccessor<AppDatabase> with _$EventDaoMixin {
  EventDao(super.db);

  /// Insert a new event
  Future<int> insertEvent(EventsCompanion event) {
    return into(events).insert(event);
  }

  /// Get events by entity ID
  Future<List<Event>> getEventsByEntityId(String entityId) {
    return (select(events)
          ..where((e) => e.entityId.equals(entityId))
          ..orderBy([(e) => OrderingTerm.desc(e.timestamp)]))
        .get();
  }

  /// Get events by type
  Future<List<Event>> getEventsByType(String eventType) {
    return (select(events)
          ..where((e) => e.eventType.equals(eventType))
          ..orderBy([(e) => OrderingTerm.desc(e.timestamp)]))
        .get();
  }

  /// Get recent events
  Future<List<Event>> getRecentEvents({int limit = 50}) {
    return (select(events)
          ..orderBy([(e) => OrderingTerm.desc(e.timestamp)])
          ..limit(limit))
        .get();
  }

  /// Get events by entity type
  Future<List<Event>> getEventsByEntityType(String entityType) {
    return (select(events)
          ..where((e) => e.entityType.equals(entityType))
          ..orderBy([(e) => OrderingTerm.desc(e.timestamp)]))
        .get();
  }
}

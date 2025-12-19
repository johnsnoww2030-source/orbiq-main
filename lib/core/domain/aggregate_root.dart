import '../events/domain_event.dart';

/// Mixin for Aggregate Root entities
/// An Aggregate Root is the entry point to an aggregate - a cluster of domain
/// objects that are treated as a single unit for data changes.
///
/// Usage:
/// ```dart
/// class SalesEntity extends Equatable with AggregateRoot {
///   // ...
/// }
/// ```
mixin AggregateRoot {
  final List<DomainEvent> _domainEvents = [];

  /// Get all pending domain events
  List<DomainEvent> get domainEvents => List.unmodifiable(_domainEvents);

  /// Add a domain event to be dispatched
  void addDomainEvent(DomainEvent event) => _domainEvents.add(event);

  /// Clear all domain events (after dispatching)
  void clearDomainEvents() => _domainEvents.clear();

  /// Check if there are pending events
  bool get hasPendingEvents => _domainEvents.isNotEmpty;
}

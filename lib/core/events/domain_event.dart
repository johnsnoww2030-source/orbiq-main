import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

/// Base class for all domain events
/// Domain events represent something that happened in the domain
/// They are immutable and carry all necessary information about the event
abstract class DomainEvent extends Equatable {
  /// Unique identifier for this event instance
  final String eventId;

  /// When this event occurred
  final DateTime timestamp;

  /// Optional correlation ID to track related events
  final String? correlationId;

  /// Optional causation ID to track event chains
  final String? causationId;

  DomainEvent({
    String? eventId,
    DateTime? timestamp,
    this.correlationId,
    this.causationId,
  }) : eventId = eventId ?? const Uuid().v4(),
       timestamp = timestamp ?? DateTime.now();

  @override
  List<Object?> get props => [eventId, timestamp, correlationId, causationId];

  /// Event type name for logging/debugging
  String get eventType => runtimeType.toString();
}

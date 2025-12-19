import 'dart:async';
import 'domain_event.dart';

/// Singleton Event Bus for broadcasting domain events across the application
/// Enables loose coupling between features/BLoCs
class EventBus {
  // Singleton pattern
  static final EventBus _instance = EventBus._internal();
  factory EventBus() => _instance;
  EventBus._internal();

  // Broadcast stream controller for events
  final _controller = StreamController<DomainEvent>.broadcast();

  // Keep recent events for debugging/replay
  final List<DomainEvent> _recentEvents = [];
  static const _maxRecentEvents = 100;

  /// Fire an event to all listeners
  void fire(DomainEvent event) {
    _recentEvents.add(event);
    if (_recentEvents.length > _maxRecentEvents) {
      _recentEvents.removeAt(0);
    }
    _controller.add(event);
  }

  /// Listen for specific event type
  /// Usage: `eventBus.on<SaleCompletedEvent>().listen((event) => ...)`
  Stream<T> on<T extends DomainEvent>() =>
      _controller.stream.where((e) => e is T).cast<T>();

  /// Listen to all events
  Stream<DomainEvent> get stream => _controller.stream;

  /// Get recent events (useful for debugging)
  List<DomainEvent> get recentEvents => List.unmodifiable(_recentEvents);

  /// Clear recent events
  void clearRecentEvents() => _recentEvents.clear();

  /// Check if bus has listeners
  bool get hasListeners => _controller.hasListener;

  /// Dispose the event bus (usually never called in app lifecycle)
  void dispose() {
    _controller.close();
  }
}

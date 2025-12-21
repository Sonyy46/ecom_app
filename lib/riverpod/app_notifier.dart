import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppNotifier<T> extends Notifier<T> {
  final T _initialValue;

  AppNotifier(this._initialValue);

  @override
  T build() => _initialValue;

  /// Apply a transformation function to the current state.
  void update(T Function(T current) updater) {
    state = updater(state);
  }

  /// Replace the current state with [newValue].
  void set(T newValue) {
    state = newValue;
  }

  /// Reset state back to the initial value.
  void reset() {
    state = _initialValue;
  }
}

NotifierProvider<AppNotifier<T>, T> notifierStateProvider<T>(T initial) {
  return NotifierProvider<AppNotifier<T>, T>(() => AppNotifier<T>(initial));
}

// class AppNotifier<T> extends Notifier<T> {
//   final T Function(Ref ref) _create;
//   AppNotifier(this._create);
//   @override
//   T build() {
//     return _create(ref);
//   }

//   void update(T Function(T current) updater) => state = updater(state);

//   void set(T newValue) => state = newValue;

//   void reset() {
//     state = _create(ref);
//   }
// }

// NotifierProvider<AppNotifier<T>, T> notifierStateProvider<T>(
//   T Function(Ref ref) create,
// ) {
//   return NotifierProvider<AppNotifier<T>, T>(() => AppNotifier<T>(create));
// }

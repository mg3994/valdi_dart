import 'signals.dart';

abstract class Action {
  final String type;
  final dynamic payload;

  Action(this.type, [this.payload]);
}

/// Centralized state store managing reactive Signal state via dispatched Actions.
class SignalStore<S> {
  final Signal<S> _stateSignal;
  final S Function(S state, Action action) _reducer;

  SignalStore({
    required S initialState,
    required S Function(S state, Action action) reducer,
  })  : _stateSignal = Signal<S>(initialState),
        _reducer = reducer;

  S get state => _stateSignal.value;

  Signal<S> get stateSignal => _stateSignal;

  void dispatch(Action action) {
    final newState = _reducer(_stateSignal.value, action);
    _stateSignal.value = newState;
  }

  void addListener(void Function(S state) listener) {
    _stateSignal.addListener(listener);
  }
}

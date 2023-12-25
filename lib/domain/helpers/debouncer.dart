import 'dart:async';

class Debouncer<T> {
  final Duration duration;
  final void Function(String,int) onValue;
  String _value = '';
  int index = 0;
  Timer? _timer;

  Debouncer({required this.duration, required this.onValue});

  String get value => _value;
  set value(String val) {
    _value = val;
    _timer?.cancel();
    _timer = Timer(duration, () => onValue(_value, index));
  }
}

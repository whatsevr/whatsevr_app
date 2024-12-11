import 'package:bloc/bloc.dart';
import 'package:rxdart/rxdart.dart';

EventTransformer<TEvent> blocEventDebounce<TEvent>({
  Duration duration = const Duration(milliseconds: 500),
}) {
  return (Stream<TEvent> events, Stream<TEvent> Function(TEvent) mapper) =>
      events.debounceTime(duration).asyncExpand(mapper);
}

import 'package:bloc/bloc.dart';
import 'package:rxdart/rxdart.dart';

EventTransformer<Event> blocEventDebounce<Event>(Duration duration) {
  return (events, mapper) => events.debounceTime(duration).asyncExpand(mapper);
}

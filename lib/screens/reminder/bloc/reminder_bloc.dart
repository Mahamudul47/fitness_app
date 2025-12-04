import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'reminder_event.dart';
part 'reminder_state.dart';

class ReminderBloc extends Bloc<ReminderEvent, ReminderState> {
  ReminderBloc() : super(ReminderInitial());

  int? selectedRepeatDayIndex;
  late DateTime reminderTime;
  int? dayTime;

  @override
  Stream<ReminderState> mapEventToState(
      ReminderEvent event,
      ) async* {
    if (event is RepeatDaySelectedEvent) {
      selectedRepeatDayIndex = event.index;
      dayTime = event.dayTime;
      yield RepeatDaySelectedState(index: selectedRepeatDayIndex);
    } else if (event is ReminderNotificationTimeEvent) {
      reminderTime = event.dateTime;
      yield ReminderNotificationState();
    } else if (event is OnSaveTappedEvent) {
      // Since we are not scheduling notifications anymore, we don't need to call _scheduleAtParticularTimeAndDate
      yield OnSaveTappedState();
    }
  }
}

// This class represents our business logic for add new medication/doctor
// seperation of concerns makes code more understandable

import 'package:rxdart/rxdart.dart';
import '../../models/errors.dart';

class NewEntryBloc {

  BehaviorSubject<int>? _selectedIntervalStock$;
  BehaviorSubject<int>? get selectIntervalStock => _selectedIntervalStock$;

  BehaviorSubject<int>? _selectedIntervalUsage$;
  BehaviorSubject<int>? get selectIntervalUsage => _selectedIntervalUsage$;

  // error state
  BehaviorSubject<EntryError>? _errorState$;
  BehaviorSubject<EntryError>? get errorState$ => _errorState$;

  NewEntryBloc() {

    _selectedIntervalStock$ = BehaviorSubject<int>.seeded(0);
    _selectedIntervalUsage$ = BehaviorSubject<int>.seeded(0);
    _errorState$ = BehaviorSubject<EntryError>();

  }

  void dispose() {
    _selectedIntervalUsage$!.close();
    _selectedIntervalStock$!.close();
  }

  void submitError(EntryError error) {
    _errorState$!.add(error);
  }

  void updateIntervalStock(int interval) {
    _selectedIntervalStock$!.add(interval);
  }

  void updateIntervalUsage(int interval) {
    _selectedIntervalUsage$!.add(interval);
  }
}
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'start_trip_state.dart';

class StartTripCubit extends Cubit<StartTripState> {
  StartTripCubit() : super(StartTripInitial());

  int currentIndex = 0;

  selectTap(int index){
    currentIndex = index;
    emit(ChangeCurrentIndexTap());
  }

}

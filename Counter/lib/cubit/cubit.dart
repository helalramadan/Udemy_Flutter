import 'package:conunter/cubit/satats.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Counter_Cubit extends Cubit<Counter_Stat> {
  Counter_Cubit() : super(CounterInitionalStat());
  static Counter_Cubit get(context) => BlocProvider.of(context);
  int counter = 0;
  void mins() {
    counter--;
    emit(CounterChangeStat());
  }

  void plus() {
    counter++;
    emit(CounterChangeStat());
  }
}

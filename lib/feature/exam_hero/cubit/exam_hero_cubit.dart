import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../core/models/exam_hero_model.dart';
import '../../../core/remote/service.dart';

part 'exam_hero_state.dart';

class ExamHeroCubit extends Cubit<ExamHeroState> {
  ExamHeroCubit(this.api) : super(ExamHeroInitial()){
    getExamHeroes();
  }

  final ServiceApi api;

  List<HeroData> dayHero = [];
  List<HeroData> weekHero = [];
  List<HeroData> monthHero = [];

  getExamHeroes() async {
    emit(ExamHeroLoading());
    final response = await api.getExamHeroes();
    response.fold(
      (error) => emit(ExamHeroError()),
      (res) {
        dayHero = res.data!.day!;
        weekHero = res.data!.week!;
        monthHero = res.data!.month!;
        emit(ExamHeroLoaded());
      },
    );
  }
}

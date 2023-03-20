import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../core/models/exam_hero_model.dart';
import '../../../core/models/user_model.dart';
import '../../../core/preferences/preferences.dart';
import '../../../core/remote/service.dart';

part 'exam_hero_state.dart';

class ExamHeroCubit extends Cubit<ExamHeroState> {
  ExamHeroCubit(this.api) : super(ExamHeroInitial()) {
    getExamHeroes();
  }

  final ServiceApi api;
  UserModel? userModel;

  HeroData myOrderInDay = HeroData();
  HeroData myOrderInWeek = HeroData();
  HeroData myOrderInMonth = HeroData();

  List<HeroData> dayHero = [];
  List<HeroData> weekHero = [];
  List<HeroData> monthHero = [];

  getExamHeroes() async {
    emit(ExamHeroLoading());
    userModel = await Preferences.instance.getUserModel();
    final response = await api.getExamHeroes();
    response.fold(
      (error) => emit(ExamHeroError()),
      (res) {
        dayHero = res.data!.day!;
        dayHero.forEach((element) {
          if (element.id == userModel!.data!.id) {
            myOrderInDay = element;
            // return true;
          } else {
            // return false;
          }
        });

        weekHero = res.data!.week!;
        weekHero.forEach((element) {
          if (element.id == userModel!.data!.id) {
            myOrderInWeek = element;
          }
        });

        monthHero = res.data!.month!;
        monthHero.forEach((element) {
          if (element.id == userModel!.data!.id) {
            myOrderInMonth = element;
          }
        });
        emit(ExamHeroLoaded());
      },
    );
  }
}

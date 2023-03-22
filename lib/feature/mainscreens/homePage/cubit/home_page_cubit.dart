import 'package:bloc/bloc.dart';
import 'package:elmazoon/core/models/home_page_model.dart';
import 'package:elmazoon/core/remote/service.dart';
import 'package:meta/meta.dart';

import '../../study_page/models/all_classes_model.dart';

part 'home_page_state.dart';

class HomePageCubit extends Cubit<HomePageState> {
  HomePageCubit(this.api) : super(HomePageInitial()){
    getHomePageData();
  }

  final ServiceApi api;
  List<ClassLessons> classes = [];

  getHomePageData() async {
    emit(HomePageLoading());
    final response = await api.getHomePageData();
    response.fold(
      (error) => emit(HomePageError()),
      (res) {
        classes = res.data.classes;
        emit(HomePageLoaded(res));
      },
    );
  }
}

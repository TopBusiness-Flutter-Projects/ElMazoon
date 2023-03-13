import 'package:bloc/bloc.dart';
import 'package:elmazoon/core/models/home_page_model.dart';
import 'package:elmazoon/core/remote/service.dart';
import 'package:meta/meta.dart';

part 'home_page_state.dart';

class HomePageCubit extends Cubit<HomePageState> {
  HomePageCubit(this.api) : super(HomePageInitial()){
    getHomePageData();
  }

  final ServiceApi api;

  getHomePageData() async {
    emit(HomePageLoading());
    final response = await api.getHomePageData();
    response.fold(
      (error) => emit(HomePageError()),
      (res) => emit(HomePageLoaded(res)),
    );
  }
}

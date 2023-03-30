import 'package:bloc/bloc.dart';
import 'package:elmazoon/core/remote/service.dart';
import 'package:meta/meta.dart';

import '../../../../core/models/ads_model.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit(this.api) : super(SplashInitial()) {
     getAdsOfApp();
  }

  final ServiceApi api;
  List<AdsModelDatum> adsList = [];
  LifeExam lifeExam=LifeExam();

  Future<void> getAdsOfApp() async {
    emit(SplashLoading());
    final response = await api.getAppAds();
    response.fold(
      (error) => emit(SplashError()),
      (res) {
        adsList = res.data!.ads!;
        lifeExam=res.data!.lifeExam!;
        print("ddd");
        print(res.data!.lifeExam!.timeEnd);
        emit(SplashLoaded());
      },
    );
  }
}

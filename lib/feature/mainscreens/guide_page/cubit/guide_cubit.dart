import 'package:bloc/bloc.dart';
import 'package:elmazoon/core/remote/service.dart';
import 'package:meta/meta.dart';

import '../../../../core/models/guide_model.dart';

part 'guide_state.dart';

class GuideCubit extends Cubit<GuideState> {
  GuideCubit(this.api) : super(GuideInitial()) {
    getGuideData();
  }

  final ServiceApi api;
  List<GuideDatum> guideList = [];

  getGuideData() async {
    emit(GuideLoading());
    final response = await api.getGuideData();
    response.fold(
      (l) => emit(GuideError()),
      (r) {
        if (r.code == 200) {
          guideList = r.data!;
        } else {
          guideList = [];
        }
        emit(GuideLoaded());
      },
    );
  }
}

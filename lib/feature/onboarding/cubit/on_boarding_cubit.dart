import 'package:bloc/bloc.dart';
import 'package:elmazoon/core/remote/service.dart';
import 'package:flutter/cupertino.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:meta/meta.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/assets_manager.dart';
import '../../../core/widgets/network_image.dart';

part 'on_boarding_state.dart';

class OnBoardingCubit extends Cubit<OnBoardingState> {
  OnBoardingCubit(this.api) : super(OnBoardingInitial());

  final ServiceApi api;

  List<ContentConfig> listContentConfig = [];

  getOnBoardingData() async {
    emit(OnBoardingLoading());
    final response = await api.onBoardingData();
    response.fold(
      (l) => emit(OnBoardingError()),
      (r) {
        if (r.code == 200) {
          for (final item in r.data!) {
            listContentConfig.add(
              ContentConfig(
                pathImage: null,
                centerWidget: Padding(
                  padding: EdgeInsets.only(top: 100),
                  child: ManageNetworkImage(imageUrl: item.image!),
                ),
                widgetTitle: Text(
                  item.title!,
                  style: TextStyle(
                    color: AppColors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 30.0,
                  ),
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                ),
                widgetDescription: Text(
                  item.description!,
                  style: TextStyle(
                    color: AppColors.descriptionBoardingColor,
                    fontSize: 18.0,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 100,
                  overflow: TextOverflow.ellipsis,
                ),
                marginTitle:
                    EdgeInsets.only(left: 20, right: 20, bottom: 16, top: 100),
                marginDescription:
                    EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                backgroundColor: AppColors.white,
              ),
            );
          }
          emit(OnBoardingLoaded());
        } else {
          emit(OnBoardingError());
        }
        // emit(OnBoardingLoaded());
      },
    );
  }
}

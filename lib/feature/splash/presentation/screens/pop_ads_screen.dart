import 'dart:async';

import 'package:elmazoon/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../../../../core/models/ads_model.dart';
import '../../../../core/widgets/network_image.dart';
import '../../../navigation_bottom/screens/navigation_bottom.dart';

class PopAdsScreen extends StatefulWidget {
  const PopAdsScreen({Key? key, required this.adsDatum}) : super(key: key);
  final AdsModelDatum adsDatum;

  @override
  State<PopAdsScreen> createState() => _PopAdsScreenState();
}

class _PopAdsScreenState extends State<PopAdsScreen> {
  late Timer _timer;

  double opacity = 0;

  _startDelay() async {
    _timer = Timer(
      const Duration(seconds: 5),
      () {
        setState(() {
          opacity = 1;
        });
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _startDelay();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            ManageNetworkImage(
              imageUrl: widget.adsDatum.link != null
                  ? widget.adsDatum.link!
                  : widget.adsDatum.filePath!,
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
            ),
            Positioned(
              top: 8,
              right: 8,
              child: Opacity(
                opacity: opacity,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: AppColors.primary.withOpacity(0.7),
                    ),
                    child: IconButton(
                      onPressed: () {
                        opacity == 1
                            ? Navigator.pushReplacement(
                                context,
                                PageTransition(
                                  type: PageTransitionType.fade,
                                  alignment: Alignment.center,
                                  duration: const Duration(milliseconds: 1300),
                                  child: NavigatorBar(),
                                ),
                              )
                            : null;
                      },
                      icon: Icon(
                        Icons.close,
                        color: AppColors.secondPrimary,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

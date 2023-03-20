import 'package:easy_localization/easy_localization.dart' as tra;
import 'package:elmazoon/core/models/my_degree_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_credit_card/credit_card_brand.dart';
import 'package:flutter_credit_card/credit_card_form.dart';
import 'package:flutter_credit_card/credit_card_model.dart';
import 'package:flutter_credit_card/credit_card_widget.dart';
import 'package:flutter_credit_card/custom_card_type_icon.dart';
import 'package:flutter_credit_card/glassmorphism_config.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/assets_manager.dart';
import '../../../core/widgets/custom_appbar_widget.dart';
import '../../../core/widgets/custom_textfield.dart';

class PayScreen extends StatefulWidget {
  const PayScreen({Key? key}) : super(key: key);

  @override
  State<PayScreen> createState() => _PayScreenState();
}

class _PayScreenState extends State<PayScreen> {
  @override
  void initState() {
    border = OutlineInputBorder(
      borderSide: BorderSide(
        color: AppColors.secondPrimary.withOpacity(0.7),
        width: 2.0,
      ),
    );
    errorBorder = OutlineInputBorder(
      borderSide: BorderSide(
        color: AppColors.error.withOpacity(0.7),
        width: 1.0,
      ),
    );
    super.initState();
  }

  String cardNumber = '';

  String expiryDate = '';

  String cardHolderName = '';

  String cvvCode = '';

  bool isCvvFocused = false;

  bool useGlassMorphism = false;

  bool useBackgroundImage = false;

  OutlineInputBorder? border;
  OutlineInputBorder? errorBorder;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      appBar: CustomAppBarWidget(appBarTitle: 'card_info'.tr()),
      body: SafeArea(
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: Column(
            children: [
              const SizedBox(
                height: 0,
              ),
              CreditCardWidget(
                cardNumber: cardNumber,
                expiryDate: expiryDate,
                cardHolderName: cardHolderName,
                cvvCode: cvvCode,
                bankName: ' ',
                frontCardBorder:
                !useGlassMorphism ? Border.all(color: AppColors.secondPrimary) : null,
                backCardBorder:
                !useGlassMorphism ? Border.all(color: AppColors.secondPrimary) : null,
                showBackView: isCvvFocused,
                obscureCardNumber: false,
                obscureCardCvv: true,
                isHolderNameVisible: true,
                cardBgColor: AppColors.secondPrimary,
                backgroundImage: ImageAssets.masterCardImage,
                isSwipeGestureEnabled: true,
                onCreditCardWidgetChange:
                    (CreditCardBrand creditCardBrand) {},

                customCardTypeIcons: <CustomCardTypeIcon>[
                  CustomCardTypeIcon(
                    cardType: CardType.mastercard,
                    cardImage: Image.asset(
                      ImageAssets.masterCardImage,
                      height: 48,
                      width: 48,
                    ),
                  ),
                ],  ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      CreditCardForm(
                        formKey: formKey,
                        obscureCvv: true,
                        obscureNumber: true,
                        cardNumber: cardNumber,
                        cvvCode: cvvCode,
                        cardHolderValidator: (value){
                          if(value==null||value.isEmpty){
                            return 'Please Enter Card Holder';
                          }
                          return null;
                        },
                        isHolderNameVisible: true,
                        isCardNumberVisible: true,
                        isExpiryDateVisible: true,
                        cardHolderName: cardHolderName,
                        expiryDate: expiryDate,
                        themeColor: AppColors.secondPrimary,
                        textColor: AppColors.secondPrimary,
                        cardNumberDecoration: InputDecoration(
                          labelText: 'Card Number',
                          hintText: 'XXXX XXXX XXXX XXXX',
                          hintStyle:  TextStyle(color: AppColors.secondPrimary),
                          labelStyle:  TextStyle(color: AppColors.secondPrimary),
                          focusedBorder: border,
                          enabledBorder: border,
                          errorBorder: errorBorder,
                        ),
                        expiryDateDecoration: InputDecoration(
                          hintStyle:  TextStyle(color: AppColors.secondPrimary),
                          labelStyle:  TextStyle(color: AppColors.secondPrimary),
                          focusedBorder: border,
                          errorBorder: errorBorder,
                          enabledBorder: border,
                          labelText: 'Expired Date',
                          hintText: 'MM/YY',
                        ),
                        cvvCodeDecoration: InputDecoration(
                          hintStyle:  TextStyle(color: AppColors.secondPrimary),
                          labelStyle:  TextStyle(color: AppColors.secondPrimary),
                          focusedBorder: border,
                          errorBorder: errorBorder,
                          enabledBorder: border,
                          labelText: 'CVV',
                          hintText: 'XXX',
                        ),
                        cardHolderDecoration: InputDecoration(
                          hintStyle:  TextStyle(color: AppColors.secondPrimary),
                          labelStyle:  TextStyle(color: AppColors.secondPrimary),
                          focusedBorder: border,
                          errorBorder: errorBorder,
                          enabledBorder: border,
                          labelText: 'Card Holder',
                        ),
                        onCreditCardModelChange: onCreditCardModelChange,
                      ),
                      const SizedBox(
                        height: 80,
                      ),
                      GestureDetector(
                        onTap: _onValidate,
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            gradient:  LinearGradient(
                              colors: <Color>[
                                AppColors.secondPrimary.withOpacity(0.9),
                                AppColors.secondPrimary.withOpacity(0.8),
                                AppColors.secondPrimary.withOpacity(0.7),
                                AppColors.secondPrimary.withOpacity(0.6),
                                AppColors.secondPrimary.withOpacity(0.5),
                                AppColors.secondPrimary.withOpacity(0.4),
                                AppColors.secondPrimary.withOpacity(0.3),
                              ],
                              begin: Alignment(-1, -4),
                              end: Alignment(1, 4),
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          width: MediaQuery.of(context).size.width/2,
                          alignment: Alignment.center,
                          child:  Text(
                            'pay'.tr(),
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'halter',
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              package: 'flutter_credit_card',
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onValidate() {
    if (formKey.currentState!.validate()) {
      print('valid!');
    } else {
      print('invalid!');
    }
  }

  void onCreditCardModelChange(CreditCardModel? creditCardModel) {
    setState(() {
      cardNumber = creditCardModel!.cardNumber;
      expiryDate = creditCardModel.expiryDate;
      cardHolderName = creditCardModel.cardHolderName;
      cvvCode = creditCardModel.cvvCode;
      isCvvFocused = creditCardModel.isCvvFocused;
    });
  }
}
part of 'payment_cubit.dart';

@immutable
abstract class PaymentState {}

class PaymentInitial extends PaymentState {}

class PaymentMonthLoading extends PaymentState {}
class PaymentMonthLoaded extends PaymentState {}
class PaymentMonthError extends PaymentState {}

class PaymentChangeList extends PaymentState {}


class PayLoading extends PaymentState {}
class PayLoaded extends PaymentState {}
class PayError extends PaymentState {}

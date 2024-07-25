abstract class PaymentState {}

class PaymentInitial extends PaymentState {}

//pay authentication status
class PaymentSuccess extends PaymentState {}

class PaymentError extends PaymentState {
  final dynamic error;

  PaymentError(this.error);
}
class PaymentGetOrderIdSuccess extends PaymentState {}

class PaymentGetOrderIdError extends PaymentState {
  final dynamic error;

  PaymentGetOrderIdError(this.error);
}

//PaymentkeyToken status
class PaymentkeyTokenSuccess extends PaymentState {}

class PaymentkeyTokenError extends PaymentState {
  final dynamic error;

  PaymentkeyTokenError(this.error);
}
class PaymentkReferencecodeSuccess extends PaymentState {}

class PaymentReferencecodeError extends PaymentState {
  final dynamic error;

  PaymentReferencecodeError(this.error);
}
class PaymentSuccessValu extends PaymentState {}

class PaymentErrorValu extends PaymentState {
  final dynamic error;

  PaymentErrorValu(this.error);
}
class PaymentGetOrderIdSuccessValu extends PaymentState {}

class PaymentGetOrderIdErrorValu extends PaymentState {
  final dynamic error;

  PaymentGetOrderIdErrorValu(this.error);
}

//PaymentkeyToken status
class PaymentkeyTokenSuccessValu extends PaymentState {}

class PaymentkeyTokenErrorValu extends PaymentState {
  final dynamic error;

  PaymentkeyTokenErrorValu(this.error);
}
class PaymentkReferencecodeSuccessValu extends PaymentState {}

class PaymentReferencecodeErrorValu extends PaymentState {
  final dynamic error;

  PaymentReferencecodeErrorValu(this.error);
}
class PaymentSuccessWallet extends PaymentState {}

class PaymentErrorWallet extends PaymentState {
  final dynamic error;

  PaymentErrorWallet(this.error);
}
class PaymentGetOrderIdSuccessWallet extends PaymentState {}

class PaymentGetOrderIdErrorWallet extends PaymentState {
  final dynamic error;

  PaymentGetOrderIdErrorWallet(this.error);
}

//PaymentkeyToken status
class PaymentkeyTokenSuccessWallet extends PaymentState {}

class PaymentkeyTokenErrorWallet extends PaymentState {
  final dynamic error;

  PaymentkeyTokenErrorWallet(this.error);
}
class PaymentkReferencecodeSuccessWallet extends PaymentState {}

class PaymentReferencecodeErrorWallet extends PaymentState {
  final dynamic error;

  PaymentReferencecodeErrorWallet(this.error);
}
class AddAmountSuccess extends PaymentState {}

class AddAmountError extends PaymentState {
  final dynamic error;

  AddAmountError(this.error);
}
class GetApiSuccess extends PaymentState {}

class GetApiError extends PaymentState {
  final dynamic error;

  GetApiError(this.error);
}
class GetADDSuccess extends PaymentState {}
class GetADDLoading extends PaymentState {}
class GetADDError extends PaymentState {}


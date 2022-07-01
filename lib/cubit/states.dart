class NewsStates {}

class InitialAppStates extends NewsStates {}

class LoadingStates extends NewsStates {}

class SuccessStates extends NewsStates {}

class ErrorStates extends NewsStates {
  final String error;

  ErrorStates({required this.error});
}

part of 'home_cubit.dart';

class HomeState {
  final bool isShowingHint;
  final String stylePhoto;
  final String styledPhoto;
  final String result;
  final bool isFromAssets;
  final int assetsImageIndex;
  final bool isTrying;
  final bool isCompleted;
  final String error;

  HomeState({
    this.isShowingHint = true,
    this.stylePhoto = '',
    this.styledPhoto = '',
    this.result = '',
    this.isFromAssets = false,
    this.assetsImageIndex = -1,
    this.isTrying = false,
    this.isCompleted = false,
    this.error = '',
  });

  HomeState copyWith({
    bool? showingHint,
    String? newStylePhoto,
    String? newStyledPhoto,
    String? newResult,
    bool? fromAssets,
    int? newAssetsImageIndex,
    bool? trying,
    bool? completed,
    String? newError,
  }) =>
      HomeState(
        isShowingHint: showingHint ?? isShowingHint,
        stylePhoto: newStylePhoto ?? stylePhoto,
        styledPhoto: newStyledPhoto ?? styledPhoto,
        isFromAssets: fromAssets ?? isFromAssets,
        assetsImageIndex: newAssetsImageIndex ?? assetsImageIndex,
        result: newResult ?? result,
        isTrying: trying ?? isTrying,
        isCompleted: completed ?? isCompleted,
        error: newError ?? error,
      );
}

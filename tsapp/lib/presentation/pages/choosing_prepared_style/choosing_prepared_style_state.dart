part of 'choosing_prepared_style_cubit.dart';

class ChoosingPreparedStyleState {
  final int selectedImage;

  ChoosingPreparedStyleState({
    this.selectedImage = -1,
  });

  ChoosingPreparedStyleState copyWith({
    int? newSelectedImage,
  }) =>
      ChoosingPreparedStyleState(
        selectedImage: newSelectedImage ?? selectedImage,
      );
}

import 'package:flutter_bloc/flutter_bloc.dart';

part 'choosing_prepared_style_state.dart';

class ChoosingPreparedStyleCubit extends Cubit<ChoosingPreparedStyleState> {
  ChoosingPreparedStyleCubit() : super(ChoosingPreparedStyleState());

  void toggleImageTap(int index) {
    if (state.selectedImage == index) {
      emit(
        state.copyWith(
          newSelectedImage: -1,
        ),
      );
    } else {
      emit(
        state.copyWith(
          newSelectedImage: index,
        ),
      );
    }
  }

  void resetChoice() => emit(
        state.copyWith(
          newSelectedImage: -1,
        ),
      );
}

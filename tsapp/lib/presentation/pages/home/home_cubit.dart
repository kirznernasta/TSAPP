import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../../services/image_picker/image_picker.dart' as imagePicker;
import '../../constants/prepared_style_images.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeState());

  void toggleShowingHint() => emit(
        state.copyWith(
          showingHint: false,
        ),
      );

  Future<void> pickImage({
    required bool isStylePhoto,
    required bool isFromGallery,
  }) async {
    final pickedFile = await imagePicker.ImagePicker.pickImage(isFromGallery);
    if (pickedFile != null) {
      if (isStylePhoto) {
        emit(
          state.copyWith(
            newStylePhoto: pickedFile.path,
            fromAssets: false,
          ),
        );
      } else {
        emit(
          state.copyWith(
            newStyledPhoto: pickedFile.path,
          ),
        );
      }
    }
  }

  void onAssetsImageSelected(int imageIndex) {
    if (imageIndex != -1) {
      emit(
        state.copyWith(
          fromAssets: true,
          newAssetsImageIndex: imageIndex,
        ),
      );
    }
  }

  Future<(String, String)> _convertFiles() async {
    late final String styleBase64;
    late final Uint8List styleBytes;

    if (state.isFromAssets) {
      final style =
          '${PreparedStyleImagesConstants.imagesPath}${state.assetsImageIndex + 1}.jpg';
      styleBytes = (await rootBundle.load(style)).buffer.asUint8List();
      styleBase64 = base64.encode(styleBytes);
    } else {
      styleBytes = await File(state.stylePhoto).readAsBytes();
      styleBase64 = base64.encode(styleBytes);
    }

    final imageBytes = await File(state.styledPhoto).readAsBytes();
    final imageBase64 = base64.encode(imageBytes);
    return (styleBase64, imageBase64);
  }

  Future<void> getResult() async {
    emit(
      state.copyWith(
        trying: true,
      ),
    );
    final (style, image) = await _convertFiles();

    final request = http.MultipartRequest(
        'POST', Uri.parse('https://07ce-46-216-179-241.ngrok-free.app/file'));

    request.files.add(http.MultipartFile.fromString('image_file', image,
        filename: 'image.jpg'));
    request.files.add(http.MultipartFile.fromString('style_file', style,
        filename: 'style.jpg'));

    var streamedResponse = await request.send();

    if (streamedResponse.statusCode == 200) {
      final stringResponse = await streamedResponse.stream.bytesToString();
      final base64String =
          stringResponse.substring(1, stringResponse.length - 1);
      emit(
        state.copyWith(
          newResult: base64String,
          trying: false,
          completed: true,
          newError: '',
        ),
      );
    } else {
      emit(
        state.copyWith(
          trying: false,
          completed: false,
          newError: 'Some technical problems',
        ),
      );
    }
  }

  Future<void> shareResult() async {
    Directory tempDir = await getTemporaryDirectory();
    String tempFilePath = '${tempDir.path}/result.jpg';
    File tempFile = File(tempFilePath);
    await tempFile.writeAsBytes(base64Decode(state.result));
    Share.shareXFiles([XFile(tempFile.path)],
        text: 'Look what I get using the TSAPP!');
  }

  void reset() => emit(
        state.copyWith(
          trying: false,
          completed: false,
          newError: '',
          newResult: '',
        ),
      );
}

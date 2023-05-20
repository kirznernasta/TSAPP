import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tsapp/presentation/constants/prepared_style_images.dart';
import 'package:tsapp/presentation/pages/home/home_cubit.dart';
import 'package:tsapp/presentation/pages/result/result.dart';

import '../choosing_prepared_style/choosing_prepared_style.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  AppBar _appBar() {
    return AppBar(
      centerTitle: true,
      title: const Text(
        'Home',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 32,
          color: Colors.white70,
        ),
      ),
      backgroundColor: Colors.teal[800],
      automaticallyImplyLeading: false,
    );
  }

  Widget _body() {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return Column(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  if (state.isShowingHint) _hintCard(context, state),
                  _photos(context, state),
                  _transferStyleButton(context, state),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _hintCard(BuildContext context, HomeState state) {
    return GestureDetector(
      onTap: context.read<HomeCubit>().toggleShowingHint,
      child: Container(
        height: 64,
        color: Colors.yellow[100],
        child: Row(
          children: [
            _hintIcon(),
            _hintText(),
          ],
        ),
      ),
    );
  }

  Widget _hintIcon() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Icon(
        Icons.tips_and_updates,
        color: Colors.yellow[600],
        size: 32,
      ),
    );
  }

  Widget _hintText() {
    return Expanded(
      child: Text(
        'Choose two photos: fist to copy its style and second to'
            ' transfer this style',
        textAlign: TextAlign.start,
        style: TextStyle(
          fontSize: 20,
          fontFamily: 'Myriad Pro',
          fontWeight: FontWeight.w500,
          color: Colors.grey[800],
        ),
      ),
    );
  }

  Widget _photos(BuildContext context, HomeState state) {
    return Padding(
      padding: EdgeInsets.only(
        right: 16.0,
        left: 16.0,
        top: state.isShowingHint == true ? 120 : 184,
        bottom: 8,
      ),
      child: SizedBox(
        height: 320,
        child: Row(
          children: [
            _stylePhoto(context, state),
            const SizedBox(
              width: 24,
            ),
            _styledPhoto(context, state),
          ],
        ),
      ),
    );
  }

  double _calculateWidth(BuildContext context) {
    return (MediaQuery.of(context).size.width - 24 - 32) / 2;
  }

  Widget _stylePhoto(BuildContext context, HomeState state) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: () {
            _showDialog(context, true);
          },
          child: Container(
            width: _calculateWidth(context),
            height: 300,
            decoration: BoxDecoration(
              border: Border.all(
                width: 8,
                color: Colors.black54,
              ),
              borderRadius: BorderRadius.circular(24),
              color: state.stylePhoto == '' && !state.isFromAssets
                  ? Colors.teal[700]!.withOpacity(0.5)
                  : null,
              image: state.stylePhoto != '' || state.isFromAssets
                  ? _styleImage(state)
                  : null,
            ),
            child: state.stylePhoto == '' && !state.isFromAssets
                ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _defaultPhotoState(),
            )
                : null,
          ),
        ),
        const Text(
          'style photo',
        ),
      ],
    );
  }

  Widget _styledPhoto(BuildContext context, HomeState state) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: () {
            _showDialog(context, false);
          },
          child: Container(
            width: _calculateWidth(context),
            height: 300,
            decoration: BoxDecoration(
              border: Border.all(
                width: 8,
                color: Colors.black54,
              ),
              borderRadius: BorderRadius.circular(24),
              color: state.styledPhoto == ''
                  ? Colors.teal[700]!.withOpacity(0.5)
                  : null,
              image: state.styledPhoto != ''
                  ? DecorationImage(
                image: FileImage(
                  File(
                    state.styledPhoto,
                  ),
                ),
                fit: BoxFit.cover,
              )
                  : null,
            ),
            child: state.styledPhoto == ''
                ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _defaultPhotoState(),
            )
                : null,
          ),
        ),
        const Text(
          'styled photo',
        ),
      ],
    );
  }

  DecorationImage _styleImage(HomeState state) {
    if (state.isFromAssets) {
      return _assetsImage(state);
    }
    return DecorationImage(
      image: FileImage(
        File(
          state.stylePhoto,
        ),
      ),
      fit: BoxFit.cover,
    );
  }

  DecorationImage _assetsImage(HomeState state) {
    return DecorationImage(
      image: AssetImage(
        '${PreparedStyleImagesConstants.imagesPath}${state.assetsImageIndex + 1}.jpg',
      ),
      fit: BoxFit.cover,
    );
  }

  Future<String?> _showDialog(BuildContext context, bool isStylePhoto) {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Choose option'),
        content: const Text('Where to pick image?'),
        actionsAlignment: MainAxisAlignment.center,
        actions: <Widget>[
          _galleryOption(context, isStylePhoto),
          _cameraOption(context, isStylePhoto),
          if (isStylePhoto) _preparedStyleOption(context),
        ],
      ),
    );
  }

  Widget _galleryOption(BuildContext context, bool isStylePhoto) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).highlightColor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: ListTile(
        leading: const Icon(
          Icons.photo,
          color: Colors.black,
        ),
        title: const Text(
          'Gallery',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        onTap: () {
          context.read<HomeCubit>().pickImage(
            isStylePhoto: isStylePhoto,
            isFromGallery: true,
          );
          Navigator.pop(context);
        },
      ),
    );
  }

  Widget _cameraOption(BuildContext context, bool isStylePhoto) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).highlightColor,
        borderRadius: BorderRadius.circular(15),
      ),
      margin: const EdgeInsets.symmetric(
        vertical: 8,
      ),
      child: ListTile(
        leading: const Icon(
          Icons.camera_enhance,
          color: Colors.black,
        ),
        title: const Text(
          'Camera',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        onTap: () {
          context.read<HomeCubit>().pickImage(
            isStylePhoto: isStylePhoto,
            isFromGallery: false,
          );
          Navigator.pop(context);
        },
      ),
    );
  }

  Widget _preparedStyleOption(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).highlightColor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: ListTile(
        leading: const Icon(
          Icons.auto_fix_high,
          color: Colors.black,
        ),
        title: const Text(
          'Prepared style',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        onTap: () async {
          final selectedImageIndex = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const ChoosingPreparedStyle(),
            ),
          );
          context.read<HomeCubit>().onAssetsImageSelected(selectedImageIndex);
          Navigator.pop(context);
        },
      ),
    );
  }

  _defaultPhotoState() {
    return const [
      Icon(
        Icons.image_search,
        size: 48,
      ),
      Padding(
        padding: EdgeInsets.all(16.0),
        child: Text(
          'tap to select a photo',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
          ),
        ),
      ),
    ];
  }

  Widget _transferStyleButton(BuildContext context, HomeState state) {
    return GestureDetector(
      onTap: () async {
        if (state.stylePhoto == '' && state.assetsImageIndex == -1 ||
            state.styledPhoto == '') {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              backgroundColor: Colors.teal,
              content: Text(
                'Choose photos first!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
            ),
          );
        } else {
          context.read<HomeCubit>().getResult();
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const Result(),
            ),
          );
        }
      },
      child: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.teal[700],
        ),
        child: const SizedBox(
          width: 320,
          height: 48,
          child: Center(
            child: Text(
              'transfer style',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _body(),
    );
  }
}

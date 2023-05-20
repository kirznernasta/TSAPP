import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tsapp/presentation/constants/prepared_style_images.dart';

import 'choosing_prepared_style_cubit.dart';

class ChoosingPreparedStyle extends StatelessWidget {
  const ChoosingPreparedStyle({Key? key}) : super(key: key);

  AppBar _appBar() {
    return AppBar(
      title: const Text(
        'Choose image to transfer its style',
        style: TextStyle(
          color: Colors.white70,
        ),
      ),
      centerTitle: true,
      automaticallyImplyLeading: false,
      backgroundColor: Colors.teal[800],
    );
  }

  Widget _body(ChoosingPreparedStyleState state) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(
              vertical: 8,
              horizontal: 16,
            ),
            itemCount: PreparedStyleImagesConstants.imagesLength,
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              return _imageOption(context, state, index);
            },
          ),
        ),
      ],
    );
  }

  Widget _imageOption(
    BuildContext context,
    ChoosingPreparedStyleState state,
    int index,
  ) {
    final isSelected = index == state.selectedImage;
    return GestureDetector(
      onTap: () {
        context.read<ChoosingPreparedStyleCubit>().toggleImageTap(index);
      },
      child: Container(
        height: 540,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                '${PreparedStyleImagesConstants.imagesPath}${index + 1}.jpg'),
            fit: BoxFit.cover,
          ),
          border: isSelected
              ? Border.all(
                  width: 4,
                  color: Colors.teal.shade900,
                )
              : null,
        ),
        margin: const EdgeInsets.symmetric(vertical: 8),
      ),
    );
  }

  Widget _applyButton(BuildContext context, ChoosingPreparedStyleState state) {
    return FloatingActionButton(
      backgroundColor: Colors.teal[800],
      onPressed: () {
        context.read<ChoosingPreparedStyleCubit>().resetChoice();
        Navigator.pop(context, state.selectedImage);
      },
      child: state.selectedImage == -1
          ? const Icon(
              Icons.close,
              size: 32,
            )
          : const Icon(
              Icons.check,
              size: 32,
            ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChoosingPreparedStyleCubit, ChoosingPreparedStyleState>(
      builder: (context, state) {
        return Scaffold(
          appBar: _appBar(),
          body: _body(state),
          floatingActionButton: _applyButton(context, state),
        );
      },
    );
  }
}

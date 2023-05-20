import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tsapp/presentation/pages/home/home_cubit.dart';

class Result extends StatelessWidget {
  const Result({Key? key}) : super(key: key);

  double _calculateWidth(BuildContext context) {
    return MediaQuery.of(context).size.width - 48;
  }

  double _calculateHeight(BuildContext context) {
    return _calculateWidth(context) / 3 * 4;
  }

  AppBar _appBar(BuildContext context, HomeState state) {
    return AppBar(
      centerTitle: true,
      title: const Text(
        'Result',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 32,
          color: Colors.white70,
        ),
      ),
      backgroundColor: Colors.teal[800],
      iconTheme: const IconThemeData(
        color: Colors.white,
      ),
      automaticallyImplyLeading: false,
      leading: IconButton(
        onPressed: () {
          context.read<HomeCubit>().reset();
          Navigator.pop(context);
        },
        icon: const Icon(Icons.arrow_back),
      ),
      actions: [
        IconButton(
          onPressed: () async {
            if (state.result != '') {
              await context.read<HomeCubit>().shareResult();
            } else {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text('Nothing to share!'),
              ));
            }
          },
          icon: const Icon(
            Icons.share,
          ),
        ),
      ],
    );
  }

  Widget _body(BuildContext context, HomeState state) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: state.isTrying
                    ? const CircularProgressIndicator()
                    : state.error == ''
                        ? Container(
                            width: _calculateWidth(context),
                            height: _calculateHeight(context),
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 8,
                                color: Colors.black54,
                              ),
                              borderRadius: BorderRadius.circular(24),
                              color: Colors.teal,
                              image: DecorationImage(
                                image: Image.memory(
                                  base64Decode(state.result),
                                ).image,
                                fit: BoxFit.cover,
                              ),
                            ),
                          )
                        : Text(state.error),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return Scaffold(
          appBar: _appBar(context, state),
          body: _body(context, state),
        );
      },
    );
  }
}

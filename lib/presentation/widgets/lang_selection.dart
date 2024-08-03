import 'package:cargo/configs/configs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../application/application.dart';
import '../../data/data_sources/local/languages_data_source.dart';

class BottomSheetContent extends StatelessWidget {
  const BottomSheetContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppDimensions.normalize(65),
      child: BlocBuilder<LanguageBloc, LanguageState>(
        builder: (context, state) {
          return Container(
            padding: Space.vf(),
            child: ListView.separated(
              itemCount: languages.length,
              separatorBuilder: (context, index) => Padding(
                padding: Space.hf(1),
                child: const Divider(),
              ),
              itemBuilder: (context, index) {
                final lang = languages[index];
                return ListTile(
                  title: Text(
                    lang.language,
                    style: AppText.b1,
                  ),
                  trailing: state.locale.languageCode == lang.code
                      ? Icon(
                          Icons.check,
                          color: Colors.green,
                          size: 26.0,
                          shadows: [
                            Shadow(
                              offset: const Offset(0, 2),
                              blurRadius: 3.0,
                              color: Colors.black.withOpacity(0.3),
                            ),
                          ],
                        )
                      : null,
                  onTap: () {
                    debugPrint('lang_selection');
                    context.read<LanguageBloc>().add(
                          LanguageChanged(
                            lang: lang,
                            context: context,
                          ),
                        );
                    Navigator.of(context).pop();
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}

Future<void> onSelectLang(BuildContext context) async {
  await showModalBottomSheet(
    context: context,
    builder: (context) {
      return const BottomSheetContent();
    },
  );
}

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:vibration/vibration.dart';

Future<void> chooseLanguage(BuildContext context) async {
  String language = context.locale.toString().substring(0, 2);
  return showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
          builder: (context, setState) => AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            contentPadding: const EdgeInsets.all(0),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 20),
                RadioListTile(
                  title: const Text("Uzbek"),
                  value: "uz",
                  groupValue: language,
                  activeColor: Colors.blue,
                  onChanged: (_) {
                    Vibration.vibrate(duration: 100);
                    language = 'uz';
                    setState((){});
                  }
                ),
                RadioListTile(
                  title: const Text("English"),
                  value: "en",
                  groupValue: language,
                  activeColor: Colors.blue,
                    onChanged: (_) {
                      Vibration.vibrate(duration: 100);
                      language = 'en';
                      setState((){});
                    }
                ),
                RadioListTile(
                  title: const Text("Русский"),
                  value: "ru",
                  groupValue: language,
                  activeColor: Colors.blue,
                    onChanged: (_) {
                      Vibration.vibrate(duration: 100);
                      language = 'ru';
                      setState((){});
                    }
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text("cancel").tr(),
                    ),
                    TextButton(
                      onPressed: (){
                        String countryCode = language == 'uz' ? 'UZ' : language == 'en' ? 'US' : 'RU';
                        context.setLocale(Locale(language, countryCode));
                        setState((){});
                        Navigator.pop(context);
                      },
                      child: const Text("perform").tr(),
                    ),
                    const SizedBox(height: 10)
                  ],
                )
              ],
            ),
          )
      )
  );
}
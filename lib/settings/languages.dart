import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:line_icons/line_icons.dart';
import 'package:url_launcher/url_launcher.dart';

import '../util/context_extension.dart';
import '../generated/l10n.dart';

class LanguagesSetting extends StatefulWidget {
  const LanguagesSetting({Key key}) : super(key: key);

  @override
  _LanguagesSettingState createState() => _LanguagesSettingState();
}

class _LanguagesSettingState extends State<LanguagesSetting> {
  _launchUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    final s = context.s;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarIconBrightness: Theme.of(context).accentColorBrightness,
        systemNavigationBarColor: Theme.of(context).primaryColor,
        systemNavigationBarIconBrightness:
            Theme.of(context).accentColorBrightness,
      ),
      child: Scaffold(
          appBar: AppBar(
            title: Text(s.settingsLanguages),
            elevation: 0,
            backgroundColor: Theme.of(context).primaryColor,
          ),
          body: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  ListTile(
                    title: Text(s.systemDefault),
                    onTap: () async {
                      await S.load(Locale(Intl.systemLocale));
                      setState(() {});
                    },
                    trailing: Radio<Locale>(
                        value: Locale(Intl.systemLocale),
                        groupValue: Locale(Intl.getCurrentLocale()),
                        onChanged: (Locale locale) async {
                          await S.load(locale);
                          setState(() {});
                        }),
                  ),
                  Divider(height: 2),
                  ListTile(
                    title: Text('English'),
                    onTap: () async {
                      await S.load(Locale('en'));
                      setState(() {});
                    },
                    trailing: Radio<Locale>(
                        value: Locale('en'),
                        groupValue: Locale(Intl.getCurrentLocale()),
                        onChanged: (Locale locale) async {
                          await S.load(locale);
                          setState(() {});
                        }),
                  ),
                  Divider(height: 2),
                  ListTile(
                    title: Text('简体中文'),
                    onTap: () async {
                      await S.load(Locale('zh_Hans'));
                      setState(() {});
                    },
                    trailing: Radio<Locale>(
                        value: Locale('zh_Hans'),
                        groupValue: Locale(Intl.getCurrentLocale()),
                        onChanged: (Locale locale) async {
                          await S.load(locale);
                          setState(() {});
                        }),
                  ),
                  Divider(height: 2),
                  ListTile(
                    onTap: () => _launchUrl(
                        'mailto:<tsacdop.app@gmail.com>?subject=Tsacdop localization project'),
                    subtitle: Text(
                        "If you'd like to contribute to support more languages, please contact me."),
                    trailing: IconButton(
                        icon: Icon(LineIcons.envelope_open_solid),
                        onPressed: () => _launchUrl(
                            'mailto:<tsacdop.app@gmail.com>?subject=Tsacdop localization project')),
                  ),
                ],
              ))),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// ignore: unused_import
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
}

final localeProvider = StateProvider<Locale>(
  (_) => const Locale('en'),
);

class MyApp extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return MaterialApp(
      title: 'Localizations Sample App',
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,

      // localizationsDelegates: const [
      //   AppLocalizations.delegate, // Add this line
      //   GlobalMaterialLocalizations.delegate,
      //   GlobalWidgetsLocalizations.delegate,
      //   GlobalCupertinoLocalizations.delegate,
      // ],
      locale: watch(localeProvider).state,
      debugShowCheckedModeBanner: false,
      // supportedLocales: const [
      //   Locale('en'), // English
      //   Locale('he'), // Hebrew
      // ],
      theme: ThemeData(
        primarySwatch: Colors.cyan,
      ),
      home: MainPage(),
    );
  }
}

class MainPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final _locProvider = watch(localeProvider);
    return Scaffold(
      appBar: AppBar(
        leading: DropdownButton<String>(
          dropdownColor: Colors.blue[600],
          value: _locProvider.state.languageCode,
          onChanged: (value) {
            _locProvider.state = Locale(value!);
          },
          items: AppLocalizations.supportedLocales
              .map(
                (e) => DropdownMenuItem(
                  value: e.languageCode,
                  child: Text(
                    e.languageCode,
                  ),
                ),
              )
              .toList(),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Text(
              AppLocalizations.of(context)?.localeName ?? "unknown",
            ),
            Text(
              AppLocalizations.of(context)?.helloWorld ?? "test",
            ),
          ],
        ),
      ),
    );
  }
}

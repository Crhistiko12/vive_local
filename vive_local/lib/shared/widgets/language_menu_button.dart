import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/l10n/app_localizations.dart';
import '../../core/l10n/locale_controller.dart';

class LanguageMenuButton extends ConsumerWidget {
  const LanguageMenuButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final current = Localizations.localeOf(context).languageCode;

    return PopupMenuButton<String>(
      tooltip: l10n.language,
      icon: const Icon(Icons.language),
      initialValue: current,
      onSelected: (code) {
        ref
            .read(localeControllerProvider.notifier)
            .setLanguageCode(code == 'system' ? null : code);
      },
      itemBuilder: (context) => [
        PopupMenuItem(value: 'system', child: Text(l10n.systemLanguage)),
        PopupMenuItem(value: 'es', child: Text(l10n.spanish)),
        PopupMenuItem(value: 'en', child: Text(l10n.english)),
        PopupMenuItem(value: 'ar', child: Text(l10n.arabic)),
      ],
    );
  }
}

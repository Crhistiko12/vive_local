import 'package:material_ui/material_ui.dart';
import 'package:go_router/go_router.dart';

import '../../../core/l10n/app_localizations.dart';
import '../../../routes/app_routes.dart';
import '../../../shared/widgets/language_menu_button.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Scaffold(
      body: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [colors.primaryContainer, colors.surface],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Align(
                  alignment: AlignmentDirectional.centerEnd,
                  child: LanguageMenuButton(),
                ),
                Expanded(
                  child: Center(
                    child: SingleChildScrollView(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 460),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 176,
                              height: 176,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(40),
                                boxShadow: [
                                  BoxShadow(
                                    color: colors.primary.withValues(
                                      alpha: 0.35,
                                    ),
                                    blurRadius: 40,
                                    offset: const Offset(0, 16),
                                  ),
                                ],
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(40),
                                child: Image.asset(
                                  'assets/images/logo.png',
                                  width: 176,
                                  height: 176,
                                  fit: BoxFit.cover,
                                  cacheWidth: 352,
                                  semanticLabel: l10n.appTitle,
                                ),
                              ),
                            ),
                            const SizedBox(height: 36),
                            Text(
                              l10n.welcomeTitle,
                              textAlign: TextAlign.center,
                              style: theme.textTheme.headlineLarge?.copyWith(
                                fontWeight: FontWeight.w800,
                                height: 1.1,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              l10n.welcomeSubtitle,
                              textAlign: TextAlign.center,
                              style: theme.textTheme.bodyLarge?.copyWith(
                                color: colors.onSurfaceVariant,
                                height: 1.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                FilledButton.icon(
                  onPressed: () => context.go(AppRoutes.login),
                  icon: const Icon(Icons.arrow_forward),
                  label: Text(l10n.getStarted),
                  style: FilledButton.styleFrom(
                    minimumSize: const Size.fromHeight(56),
                    shape: const StadiumBorder(),
                    textStyle: theme.textTheme.titleMedium,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  l10n.appTagline,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: colors.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

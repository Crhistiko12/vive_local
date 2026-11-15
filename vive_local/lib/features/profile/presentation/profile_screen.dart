import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../configs/providers.dart';
import '../../../core/l10n/app_localizations.dart';
import '../../../core/l10n/locale_controller.dart';
import '../../../routes/app_routes.dart';
import '../../../shared/l10n/failure_message.dart';
import '../../auth/domain/auth_user.dart';
import '../../auth/presentation/providers/auth_providers.dart';
import '../../auth/presentation/providers/sign_in_controller.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final firebaseReady = ref.watch(firebaseReadyProvider);
    final authState = ref.watch(authStateChangesProvider);
    final locale = ref.watch(localeControllerProvider);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.profileTitle)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          if (!firebaseReady)
            Card(
              color: Theme.of(context).colorScheme.errorContainer,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Text(l10n.demoModeBanner),
              ),
            ),
          authState.when(
            loading: () => const Center(
              child: Padding(
                padding: EdgeInsets.all(24),
                child: CircularProgressIndicator(),
              ),
            ),
            error: (error, stackTrace) => Card(
              child: ListTile(
                leading: const Icon(Icons.error_outline),
                title: Text(failureMessage(context, error)),
              ),
            ),
            data: (user) => user == null
                ? _GuestCard(onSignIn: () => context.push(AppRoutes.login))
                : _UserCard(user: user),
          ),
          const SizedBox(height: 24),
          Text(
            l10n.language,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          _LanguageOption(
            title: l10n.systemLanguage,
            selected: locale == null,
            onTap: () => ref
                .read(localeControllerProvider.notifier)
                .setLanguageCode(null),
          ),
          _LanguageOption(
            title: l10n.spanish,
            selected: locale?.languageCode == 'es',
            onTap: () => ref
                .read(localeControllerProvider.notifier)
                .setLanguageCode('es'),
          ),
          _LanguageOption(
            title: l10n.english,
            selected: locale?.languageCode == 'en',
            onTap: () => ref
                .read(localeControllerProvider.notifier)
                .setLanguageCode('en'),
          ),
          _LanguageOption(
            title: l10n.arabic,
            selected: locale?.languageCode == 'ar',
            onTap: () => ref
                .read(localeControllerProvider.notifier)
                .setLanguageCode('ar'),
          ),
        ],
      ),
    );
  }
}

class _GuestCard extends StatelessWidget {
  const _GuestCard({required this.onSignIn});

  final VoidCallback onSignIn;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            CircleAvatar(
              radius: 32,
              backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
              child: const Icon(Icons.person_outline, size: 32),
            ),
            const SizedBox(height: 12),
            Text(l10n.notSignedIn),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: onSignIn,
              child: Text(l10n.loginTitle),
            ),
          ],
        ),
      ),
    );
  }
}

class _UserCard extends ConsumerWidget {
  const _UserCard({required this.user});

  final AuthUser user;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final signInState = ref.watch(signInControllerProvider);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            CircleAvatar(
              radius: 36,
              backgroundImage: user.photoUrl == null
                  ? null
                  : NetworkImage(user.photoUrl!),
              child: user.photoUrl == null ? Text(user.initials) : null,
            ),
            const SizedBox(height: 12),
            Text(
              user.displayName ?? l10n.guest,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            if (user.email.isNotEmpty)
              Text(
                user.email,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            const SizedBox(height: 16),
            OutlinedButton.icon(
              onPressed: signInState.isLoading
                  ? null
                  : () async {
                      await ref
                          .read(signInControllerProvider.notifier)
                          .signOut();
                      if (context.mounted) {
                        final error = ref
                            .read(signInControllerProvider)
                            .error;
                        if (error != null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(failureMessage(context, error)),
                            ),
                          );
                        }
                      }
                    },
              icon: const Icon(Icons.logout),
              label: Text(l10n.signOut),
            ),
          ],
        ),
      ),
    );
  }
}

class _LanguageOption extends StatelessWidget {
  const _LanguageOption({
    required this.title,
    required this.selected,
    required this.onTap,
  });

  final String title;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(title),
        trailing: selected ? const Icon(Icons.check) : null,
        onTap: onTap,
      ),
    );
  }
}

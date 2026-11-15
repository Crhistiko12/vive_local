import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/l10n/app_localizations.dart';
import '../../../../core/services/maps_launcher_service.dart';

class GoogleMapsButton extends ConsumerStatefulWidget {
  const GoogleMapsButton({
    super.key,
    required this.latitude,
    required this.longitude,
    required this.placeName,
    this.compact = false,
  });

  final double latitude;
  final double longitude;
  final String placeName;
  final bool compact;

  @override
  ConsumerState<GoogleMapsButton> createState() => _GoogleMapsButtonState();
}

class _GoogleMapsButtonState extends ConsumerState<GoogleMapsButton> {
  bool _opening = false;

  Future<void> _open() async {
    final l10n = AppLocalizations.of(context);
    setState(() => _opening = true);
    try {
      await ref.read(googleMapsLauncherProvider)(
        lat: widget.latitude,
        lng: widget.longitude,
        nombre: widget.placeName,
      );
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.googleMapsNotAvailable)),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _opening = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final icon = _opening
        ? const SizedBox(
            width: 18,
            height: 18,
            child: CircularProgressIndicator(strokeWidth: 2),
          )
        : const Icon(Icons.directions);

    if (widget.compact) {
      return FilledButton.icon(
        onPressed: _opening ? null : _open,
        icon: icon,
        label: Text(l10n.openInGoogleMaps),
      );
    }

    return SizedBox(
      width: double.infinity,
      child: FilledButton.icon(
        onPressed: _opening ? null : _open,
        icon: icon,
        label: Text(l10n.openInGoogleMaps),
      ),
    );
  }
}

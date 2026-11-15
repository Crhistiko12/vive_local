import 'package:material_ui/material_ui.dart';

import '../../../../core/l10n/app_localizations.dart';
import '../../domain/place.dart';
import 'google_maps_button.dart';

class PlaceSummaryCard extends StatelessWidget {
  const PlaceSummaryCard({
    super.key,
    required this.place,
    required this.onViewDetails,
    this.onClose,
  });

  final Place place;
  final VoidCallback onViewDetails;
  final VoidCallback? onClose;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return Card(
      elevation: 6,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                if (place.hasPhoto) ...[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      place.photoUrl!,
                      width: 64,
                      height: 64,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        width: 64,
                        height: 64,
                        color: theme.colorScheme.surfaceContainerHighest,
                        child: const Icon(Icons.broken_image_outlined),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                ],
                Expanded(
                  child: Text(
                    place.name,
                    style: theme.textTheme.titleLarge,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (onClose != null)
                  IconButton(
                    onPressed: onClose,
                    icon: const Icon(Icons.close),
                    tooltip: l10n.close,
                  ),
              ],
            ),
            if (place.category.isNotEmpty || place.address.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                  [
                    if (place.category.isNotEmpty) place.category,
                    if (place.address.isNotEmpty) place.address,
                  ].join(' · '),
                  style: theme.textTheme.bodySmall,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            if (place.description.isNotEmpty) ...[
              const SizedBox(height: 8),
              Text(
                place.description,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.bodyMedium,
              ),
            ],
            const SizedBox(height: 12),
            Row(
              children: [
                OutlinedButton(
                  onPressed: onViewDetails,
                  child: Text(l10n.viewDetails),
                ),
                const SizedBox(width: 8),
                Flexible(
                  child: GoogleMapsButton(
                    latitude: place.latitude,
                    longitude: place.longitude,
                    placeName: place.name,
                    compact: true,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

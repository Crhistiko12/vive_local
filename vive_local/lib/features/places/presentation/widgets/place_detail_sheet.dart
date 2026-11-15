import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import '../../../../core/l10n/app_localizations.dart';
import '../../../../core/services/weather_service.dart';
import '../../../../routes/app_routes.dart';
import '../../../map/domain/place.dart';
import '../../../map/presentation/widgets/google_maps_button.dart';
import 'place_photo_gallery.dart';

class PlaceDetailSheet extends StatefulWidget {
  const PlaceDetailSheet({
    super.key,
    required this.place,
    this.weatherService,
  });

  final Place place;
  final WeatherService? weatherService;

  @override
  State<PlaceDetailSheet> createState() => _PlaceDetailSheetState();
}

class _PlaceDetailSheetState extends State<PlaceDetailSheet> {
  late final Future<Map<String, dynamic>?> _weatherFuture;

  @override
  void initState() {
    super.initState();
    final service = widget.weatherService ?? WeatherService();
    _weatherFuture = service.getCurrentWeather(
      widget.place.latitude,
      widget.place.longitude,
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final place = widget.place;

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  place.name,
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close),
                tooltip: l10n.close,
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
          if (place.category.isNotEmpty || place.rating > 0) ...[
            const SizedBox(height: 4),
            Wrap(
              spacing: 8,
              runSpacing: 4,
              children: [
                if (place.category.isNotEmpty)
                  Chip(
                    visualDensity: VisualDensity.compact,
                    label: Text(place.category),
                  ),
                if (place.rating > 0)
                  Chip(
                    visualDensity: VisualDensity.compact,
                    avatar: const Icon(Icons.star, size: 16),
                    label: Text(place.rating.toStringAsFixed(1)),
                  ),
              ],
            ),
          ],
          if (place.address.isNotEmpty) ...[
            const SizedBox(height: 6),
            Row(
              children: [
                Icon(
                  Icons.place_outlined,
                  size: 16,
                  color: theme.colorScheme.onSurfaceVariant,
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    place.address,
                    style: theme.textTheme.bodySmall,
                  ),
                ),
              ],
            ),
          ],
          const SizedBox(height: 8),
          // Clima actual con Open-Meteo
          FutureBuilder<Map<String, dynamic>?>(
            future: _weatherFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                );
              }

              if (snapshot.hasError ||
                  !snapshot.hasData ||
                  snapshot.data == null) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Text(
                    'Clima no disponible',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                );
              }

              final data = snapshot.data!;
              final temp = data['temperature'];
              final tempStr =
                  temp != null ? '${(temp as num).round()}°C' : '--°C';
              final code = (data['weathercode'] as num?)?.toInt();
              final condition = WeatherService.getWeatherCondition(code);

              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      condition.icon,
                      size: 22,
                      color: theme.colorScheme.primary,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      tempStr,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      condition.text,
                      style: theme.textTheme.bodyMedium,
                    ),
                  ],
                ),
              );
            },
          ),
          if (place.description.isNotEmpty) ...[
            const SizedBox(height: 10),
            Text(
              place.description,
              style: theme.textTheme.bodyMedium,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ],
          const SizedBox(height: 16),
          // Photo gallery with SQLite + camera
          PlacePhotoGallery(
            lugarId: place.id,
            placeName: place.name,
            compact: true,
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    context.push(
                      AppRoutes.placeDetails(place.id),
                      extra: place,
                    );
                  },
                  child: Text(l10n.viewDetails),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
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
    );
  }
}

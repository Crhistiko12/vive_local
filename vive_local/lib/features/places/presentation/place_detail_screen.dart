import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/l10n/app_localizations.dart';
import '../../../shared/widgets/async_value_view.dart';
import '../../map/domain/place.dart';
import '../../map/presentation/providers/places_providers.dart';
import '../../map/presentation/widgets/google_maps_button.dart';
import 'providers/weather_providers.dart';
import 'widgets/place_photo_gallery.dart';
import 'widgets/weather_panel.dart';

class PlaceDetailScreen extends ConsumerWidget {
  const PlaceDetailScreen({
    super.key,
    required this.placeId,
    this.initialPlace,
  });

  final String placeId;
  final Place? initialPlace;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final initial = initialPlace;
    if (initial != null) {
      return _PlaceDetails(place: initial);
    }

    final placeAsync = ref.watch(placeByIdProvider(placeId));
    return Scaffold(
      appBar: AppBar(title: Text(l10n.placeDetailsTitle)),
      body: AsyncValueView<Place?>(
        value: placeAsync,
        onRetry: () => ref.invalidate(placeByIdProvider(placeId)),
        data: (place) {
          if (place == null) {
            return Center(child: Text(l10n.errorPlaceNotFound));
          }
          return _PlaceDetails(place: place);
        },
      ),
    );
  }
}

class _PlaceDetails extends ConsumerWidget {
  const _PlaceDetails({required this.place});

  final Place place;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final weather = ref.watch(
      placeWeatherProvider(
        latitude: place.latitude,
        longitude: place.longitude,
      ),
    );

    return Scaffold(
      appBar: AppBar(title: Text(place.name)),
      body: ListView(
        padding: const EdgeInsets.only(bottom: 24),
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
            child: PlacePhotoGallery(
              lugarId: place.id,
              placeName: place.name,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(place.name, style: theme.textTheme.headlineSmall),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    if (place.category.isNotEmpty)
                      Chip(label: Text(place.category)),
                    if (place.rating > 0)
                      Chip(
                        avatar: const Icon(Icons.star, size: 18),
                        label: Text(place.rating.toStringAsFixed(1)),
                      ),
                  ],
                ),
                if (place.address.isNotEmpty) ...[
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.place_outlined, size: 18),
                      const SizedBox(width: 6),
                      Expanded(child: Text(place.address)),
                    ],
                  ),
                ],
                const SizedBox(height: 8),
                Text(
                  l10n.coordinatesLabel(
                    place.latitude.toStringAsFixed(5),
                    place.longitude.toStringAsFixed(5),
                  ),
                  style: theme.textTheme.bodySmall,
                ),
                if (place.description.isNotEmpty) ...[
                  const SizedBox(height: 16),
                  Text(
                    place.description,
                    style: theme.textTheme.bodyLarge,
                  ),
                ],
                const SizedBox(height: 20),
                WeatherPanel(
                  weather: weather,
                  onRetry: () => ref.invalidate(
                    placeWeatherProvider(
                      latitude: place.latitude,
                      longitude: place.longitude,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                GoogleMapsButton(
                  latitude: place.latitude,
                  longitude: place.longitude,
                  placeName: place.name,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

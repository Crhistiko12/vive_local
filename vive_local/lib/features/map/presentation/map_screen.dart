import 'package:flutter_map/flutter_map.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';

import '../../../configs/env.dart';
import '../../../configs/providers.dart';
import '../../../core/errors/app_failure.dart';
import '../../../core/l10n/app_localizations.dart';
import '../../../core/location/location_service.dart';
import '../../../routes/app_routes.dart';
import '../../../shared/l10n/failure_message.dart';
import '../../../shared/widgets/language_menu_button.dart';
import '../domain/place.dart';
import 'providers/places_providers.dart';
import 'providers/selected_place_controller.dart';
import 'providers/user_location_controller.dart';
import 'widgets/create_place_sheet.dart';
import 'widgets/place_summary_card.dart';

class MapScreen extends ConsumerStatefulWidget {
  const MapScreen({super.key});

  @override
  ConsumerState<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends ConsumerState<MapScreen> {
  final MapController _mapController = MapController();
  bool _mapReady = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _centerOnUser(silent: true);
    });
  }

  Future<void> _centerOnUser({bool silent = false}) async {
    final l10n = AppLocalizations.of(context);
    try {
      final position = await ref
          .read(locationServiceProvider)
          .currentPosition();
      ref
          .read(userLocationControllerProvider.notifier)
          .setPosition(
            latitude: position.latitude,
            longitude: position.longitude,
          );
      if (_mapReady) {
        _mapController.move(
          LatLng(position.latitude, position.longitude),
          AppEnv.focusedZoom,
        );
      }
    } on AppFailure catch (failure) {
      if (!mounted || silent) {
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(failure.message(l10n))),
      );
    }
  }

  Future<void> _openCreatePlaceSheet() async {
    final l10n = AppLocalizations.of(context);
    final userLocation = ref.read(userLocationControllerProvider);
    final mapCenter = _mapReady
        ? _mapController.camera.center
        : const LatLng(AppEnv.defaultLatitude, AppEnv.defaultLongitude);

    final created = await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      showDragHandle: true,
      builder: (_) => CreatePlaceSheet(
        latitude: userLocation?.latitude ?? mapCenter.latitude,
        longitude: userLocation?.longitude ?? mapCenter.longitude,
        usingMapCenter: userLocation == null,
      ),
    );

    if (!mounted || created != true) {
      return;
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(l10n.placeCreated)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final placesAsync = ref.watch(placesProvider);
    final places = placesAsync.value ?? const <Place>[];
    final selectedId = ref.watch(selectedPlaceControllerProvider);
    final userLocation = ref.watch(userLocationControllerProvider);

    Place? selectedPlace;
    if (selectedId != null) {
      for (final place in places) {
        if (place.id == selectedId) {
          selectedPlace = place;
          break;
        }
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.appTitle),
        actions: [
          const LanguageMenuButton(),
          IconButton(
            tooltip: l10n.profileTitle,
            onPressed: () => context.push(AppRoutes.profile),
            icon: const Icon(Icons.person_outline),
          ),
        ],
      ),
      body: Stack(
        children: [
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              initialCenter: const LatLng(
                AppEnv.defaultLatitude,
                AppEnv.defaultLongitude,
              ),
              initialZoom: AppEnv.defaultZoom,
              onMapReady: () {
                _mapReady = true;
                final location = ref.read(userLocationControllerProvider);
                if (location != null) {
                  _mapController.move(
                    LatLng(location.latitude, location.longitude),
                    AppEnv.focusedZoom,
                  );
                }
              },
              onTap: (tapPosition, point) => ref
                  .read(selectedPlaceControllerProvider.notifier)
                  .clear(),
            ),
            children: [
              TileLayer(
                urlTemplate: AppEnv.osmTileUrl,
                userAgentPackageName: AppEnv.osmUserAgent,
              ),
              if (userLocation != null)
                MarkerLayer(
                  markers: [
                    Marker(
                      point: LatLng(
                        userLocation.latitude,
                        userLocation.longitude,
                      ),
                      width: 28,
                      height: 28,
                      child: Container(
                        decoration: BoxDecoration(
                          color: theme.colorScheme.primary,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 3),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 6,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              MarkerLayer(
                markers: [
                  for (final place in places)
                    Marker(
                      point: LatLng(place.latitude, place.longitude),
                      width: 48,
                      height: 48,
                      child: Semantics(
                        label: place.name,
                        button: true,
                        child: GestureDetector(
                          onTap: () => ref
                              .read(selectedPlaceControllerProvider.notifier)
                              .select(place.id),
                          child: Icon(
                            Icons.location_on,
                            size: 44,
                            color: place.id == selectedId
                                ? theme.colorScheme.primary
                                : theme.colorScheme.error,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
          if (!ref.watch(firebaseReadyProvider))
            Positioned(
              top: 8,
              left: 12,
              right: 12,
              child: Material(
                color: theme.colorScheme.tertiaryContainer,
                borderRadius: BorderRadius.circular(12),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.cloud_off, size: 18),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          l10n.demoModeBanner,
                          style: theme.textTheme.bodySmall,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          if (placesAsync.isLoading)
            const Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: LinearProgressIndicator(),
            ),
          if (placesAsync.hasError)
            Positioned(
              top: 56,
              left: 12,
              right: 12,
              child: Card(
                color: theme.colorScheme.errorContainer,
                child: ListTile(
                  leading: const Icon(Icons.error_outline),
                  title: Text(l10n.placesLoadError),
                  trailing: TextButton(
                    onPressed: () => ref.invalidate(placesProvider),
                    child: Text(l10n.retry),
                  ),
                ),
              ),
            ),
          if (places.isEmpty &&
              placesAsync.hasValue &&
              !placesAsync.isLoading)
            Positioned(
              top: 56,
              left: 12,
              right: 12,
              child: Card(
                child: ListTile(
                  leading: const Icon(Icons.info_outline),
                  title: Text(l10n.noPlaces),
                ),
              ),
            ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 180),
            left: 16,
            bottom: selectedPlace == null ? 24 : 210,
            child: FloatingActionButton.small(
              heroTag: 'my-location',
              tooltip: l10n.myLocation,
              onPressed: () => _centerOnUser(),
              child: const Icon(Icons.my_location),
            ),
          ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 180),
            right: 16,
            bottom: selectedPlace == null ? 24 : 210,
            child: FloatingActionButton.small(
              heroTag: 'add-place',
              tooltip: l10n.addPlace,
              onPressed: _openCreatePlaceSheet,
              child: const Icon(Icons.add_location_alt),
            ),
          ),
          Positioned(
            right: 8,
            bottom: 4,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: theme.colorScheme.surface.withValues(alpha: 0.8),
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                child: Text(
                  '© OpenStreetMap contributors',
                  style: TextStyle(fontSize: 10),
                ),
              ),
            ),
          ),
          if (selectedPlace != null)
            Positioned(
              left: 12,
              right: 12,
              bottom: 12,
              child: PlaceSummaryCard(
                place: selectedPlace,
                onViewDetails: () => context.push(
                  AppRoutes.placeDetails(selectedPlace!.id),
                  extra: selectedPlace,
                ),
                onClose: () => ref
                    .read(selectedPlaceControllerProvider.notifier)
                    .clear(),
              ),
            ),
        ],
      ),
    );
  }
}

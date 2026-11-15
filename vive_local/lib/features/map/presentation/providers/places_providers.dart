import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../configs/providers.dart';
import '../../domain/place.dart';
import '../../domain/places_repository.dart';
import '../../data/demo_places_repository.dart';
import '../../data/firestore_places_repository.dart';

part 'places_providers.g.dart';

@Riverpod(keepAlive: true)
PlacesRepository placesRepository(Ref ref) {
  if (ref.watch(firebaseReadyProvider)) {
    return FirestorePlacesRepository(FirebaseFirestore.instance);
  }
  return const DemoPlacesRepository();
}

@riverpod
Stream<List<Place>> places(Ref ref) =>
    ref.watch(placesRepositoryProvider).watchPlaces();

@riverpod
Future<Place?> placeById(Ref ref, String id) =>
    ref.watch(placesRepositoryProvider).getPlaceById(id);

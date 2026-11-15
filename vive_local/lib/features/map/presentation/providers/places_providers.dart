import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../configs/providers.dart';
import '../../domain/place.dart';
import '../../domain/place_photo_storage.dart';
import '../../domain/places_repository.dart';
import '../../data/demo_places_repository.dart';
import '../../data/firebase_place_photo_storage.dart';
import '../../data/firestore_places_repository.dart';
import '../../data/unavailable_place_photo_storage.dart';

part 'places_providers.g.dart';

@Riverpod(keepAlive: true)
PlacesRepository placesRepository(Ref ref) {
  if (ref.watch(firebaseReadyProvider)) {
    return FirestorePlacesRepository(FirebaseFirestore.instance);
  }
  return const DemoPlacesRepository();
}

@Riverpod(keepAlive: true)
PlacePhotoStorage placePhotoStorage(Ref ref) {
  if (ref.watch(firebaseReadyProvider)) {
    return FirebasePlacePhotoStorage(
      FirebaseStorage.instance,
      FirebaseAuth.instance,
    );
  }
  return const UnavailablePlacePhotoStorage();
}

@riverpod
Stream<List<Place>> places(Ref ref) =>
    ref.watch(placesRepositoryProvider).watchPlaces();

@riverpod
Future<Place?> placeById(Ref ref, String id) =>
    ref.watch(placesRepositoryProvider).getPlaceById(id);

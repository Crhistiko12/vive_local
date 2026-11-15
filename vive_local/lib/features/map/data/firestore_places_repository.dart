import 'package:cloud_firestore/cloud_firestore.dart';

import '../domain/place.dart';
import '../domain/places_repository.dart';

class FirestorePlacesRepository implements PlacesRepository {
  FirestorePlacesRepository(this._firestore);

  static const String collectionName = 'lugares';

  final FirebaseFirestore _firestore;

  CollectionReference<Map<String, dynamic>> get _places =>
      _firestore.collection(collectionName);

  @override
  Stream<List<Place>> watchPlaces() {
    return _places.snapshots().map((snapshot) {
      final places = snapshot.docs.map(_fromDocument).toList()
        ..sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
      return places;
    });
  }

  @override
  Future<Place?> getPlaceById(String id) async {
    final document = await _places.doc(id).get();
    if (!document.exists) {
      return null;
    }
    return _fromDocument(document);
  }

  @override
  Future<void> createPlace({
    required String name,
    required String category,
    required double latitude,
    required double longitude,
  }) async {
    await _places.add({
      'name': name.trim(),
      'category': category.trim(),
      'description': '',
      'address': '',
      'rating': 0,
      'location': GeoPoint(latitude, longitude),
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  Place _fromDocument(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data() ?? <String, dynamic>{};
    final location = data['location'];
    var latitude = 0.0;
    var longitude = 0.0;

    if (location is GeoPoint) {
      latitude = location.latitude;
      longitude = location.longitude;
    } else if (location is Map) {
      latitude = (location['lat'] as num?)?.toDouble() ?? 0;
      longitude = (location['lng'] as num?)?.toDouble() ?? 0;
    }

    return Place(
      id: document.id,
      name: (data['name'] as String?)?.trim() ?? '',
      latitude: latitude,
      longitude: longitude,
      description: (data['description'] as String?)?.trim() ?? '',
      category: (data['category'] as String?)?.trim() ?? '',
      address: (data['address'] as String?)?.trim() ?? '',
      photoUrl: data['photoUrl'] as String?,
      rating: (data['rating'] as num?)?.toDouble() ?? 0,
    );
  }
}

import '../../../core/errors/app_failure.dart';
import '../domain/place.dart';
import '../domain/places_repository.dart';

class DemoPlacesRepository implements PlacesRepository {
  const DemoPlacesRepository();

  static const List<Place> _places = [
    Place(
      id: 'plaza-14-de-septiembre',
      name: 'Plaza 14 de Septiembre',
      latitude: -17.3938227,
      longitude: -66.1569255,
      category: 'Plaza',
      address: 'Centro histórico, Cochabamba',
      description:
          'La plaza principal de Cochabamba, rodeada por la Catedral '
          'Metropolitana y el Palacio de Justicia.',
      rating: 4.7,
    ),
    Place(
      id: 'cristo-de-la-concordia',
      name: 'Cristo de la Concordia',
      latitude: -17.3843089,
      longitude: -66.1349544,
      category: 'Monumento',
      address: 'Cerro San Pedro, Cochabamba',
      description:
          'Monumento de 33 metros sobre el cerro San Pedro con vista '
          'panorámica de toda la ciudad.',
      rating: 4.8,
    ),
    Place(
      id: 'aeropuerto-jorge-wilstermann',
      name: 'Aeropuerto Internacional Jorge Wilstermann',
      latitude: -17.4206674,
      longitude: -66.1767633,
      category: 'Transporte',
      address: 'Av. Guillermo Killman, Cochabamba',
      description:
          'Principal aeropuerto de Cochabamba, con vuelos nacionales e '
          'internacionales.',
      rating: 4.2,
    ),
    Place(
      id: 'terminal-de-buses-cochabamba',
      name: 'Terminal de Buses de Cochabamba',
      latitude: -17.4024571,
      longitude: -66.1580123,
      category: 'Transporte',
      address: 'Av. Ayacucho, Cochabamba',
      description:
          'Terminal de larga distancia que conecta Cochabamba con todo '
          'el país.',
      rating: 4.0,
    ),
    Place(
      id: 'palacio-portales',
      name: 'Palacio Portales',
      latitude: -17.3747965,
      longitude: -66.1530795,
      category: 'Cultura',
      address: 'Av. Potosí 1450, Cochabamba',
      description:
          'Residencia histórica del magnate del estaño Simón Patiño, hoy '
          'centro cultural y museo.',
      rating: 4.7,
    ),
    Place(
      id: 'teleferico-al-cristo',
      name: 'Teleférico al Cristo (base)',
      latitude: -17.3889881,
      longitude: -66.1421193,
      category: 'Transporte',
      address: 'Parque de la Autonomía, Cochabamba',
      description:
          'Estación base del teleférico que sube al Cristo de la '
          'Concordia.',
      rating: 4.6,
    ),
  ];

  @override
  Stream<List<Place>> watchPlaces() => Stream<List<Place>>.value(_places);

  @override
  Future<Place?> getPlaceById(String id) async {
    for (final place in _places) {
      if (place.id == id) {
        return place;
      }
    }
    return null;
  }

  @override
  Future<void> createPlace({
    required String name,
    required String category,
    required double latitude,
    required double longitude,
  }) {
    throw const AppFailure(FailureCode.firebaseNotConfigured);
  }
}

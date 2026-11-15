class FavoritePlace {
  const FavoritePlace({
    required this.placeId,
    required this.name,
    required this.category,
    required this.latitude,
    required this.longitude,
    required this.savedAt,
  });

  final String placeId;
  final String name;
  final String category;
  final double latitude;
  final double longitude;
  final DateTime savedAt;
}

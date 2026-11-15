class Place {
  const Place({
    required this.id,
    required this.name,
    required this.latitude,
    required this.longitude,
    this.description = '',
    this.category = '',
    this.address = '',
    this.photoUrl,
    this.rating = 0,
  });

  final String id;
  final String name;
  final double latitude;
  final double longitude;
  final String description;
  final String category;
  final String address;
  final String? photoUrl;
  final double rating;

  bool get hasPhoto => photoUrl != null && photoUrl!.isNotEmpty;

  @override
  String toString() => 'Place(id: $id, name: $name)';
}

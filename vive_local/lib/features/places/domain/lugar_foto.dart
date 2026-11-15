class LugarFoto {
  final int? id;
  final String lugarId;
  final String imagePath;
  final bool esLocal;

  const LugarFoto({
    this.id,
    required this.lugarId,
    required this.imagePath,
    this.esLocal = true,
  });

  Map<String, dynamic> toMap() => {
    if (id != null) 'id': id,
    'lugar_id': lugarId,
    'image_path': imagePath,
    'es_local': esLocal ? 1 : 0,
  };

  factory LugarFoto.fromMap(Map<String, dynamic> map) => LugarFoto(
    id: map['id'] as int?,
    lugarId: map['lugar_id'] as String,
    imagePath: map['image_path'] as String,
    esLocal: (map['es_local'] as int? ?? 1) == 1,
  );

  LugarFoto copyWith({
    int? id,
    String? lugarId,
    String? imagePath,
    bool? esLocal,
  }) => LugarFoto(
    id: id ?? this.id,
    lugarId: lugarId ?? this.lugarId,
    imagePath: imagePath ?? this.imagePath,
    esLocal: esLocal ?? this.esLocal,
  );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LugarFoto &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          lugarId == other.lugarId &&
          imagePath == other.imagePath &&
          esLocal == other.esLocal;

  @override
  int get hashCode => Object.hash(id, lugarId, imagePath, esLocal);

  @override
  String toString() =>
      'LugarFoto(id: $id, lugarId: $lugarId, imagePath: $imagePath, esLocal: $esLocal)';
}

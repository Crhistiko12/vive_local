// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $FavoritePlacesTable extends FavoritePlaces
    with TableInfo<$FavoritePlacesTable, FavoritePlace> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FavoritePlacesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _placeIdMeta = const VerificationMeta(
    'placeId',
  );
  @override
  late final GeneratedColumn<String> placeId = GeneratedColumn<String>(
    'place_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _categoryMeta = const VerificationMeta(
    'category',
  );
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
    'category',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _latitudeMeta = const VerificationMeta(
    'latitude',
  );
  @override
  late final GeneratedColumn<double> latitude = GeneratedColumn<double>(
    'latitude',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _longitudeMeta = const VerificationMeta(
    'longitude',
  );
  @override
  late final GeneratedColumn<double> longitude = GeneratedColumn<double>(
    'longitude',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _savedAtMeta = const VerificationMeta(
    'savedAt',
  );
  @override
  late final GeneratedColumn<DateTime> savedAt = GeneratedColumn<DateTime>(
    'saved_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    placeId,
    name,
    category,
    latitude,
    longitude,
    savedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'favorite_places';
  @override
  VerificationContext validateIntegrity(
    Insertable<FavoritePlace> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('place_id')) {
      context.handle(
        _placeIdMeta,
        placeId.isAcceptableOrUnknown(data['place_id']!, _placeIdMeta),
      );
    } else if (isInserting) {
      context.missing(_placeIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('category')) {
      context.handle(
        _categoryMeta,
        category.isAcceptableOrUnknown(data['category']!, _categoryMeta),
      );
    }
    if (data.containsKey('latitude')) {
      context.handle(
        _latitudeMeta,
        latitude.isAcceptableOrUnknown(data['latitude']!, _latitudeMeta),
      );
    } else if (isInserting) {
      context.missing(_latitudeMeta);
    }
    if (data.containsKey('longitude')) {
      context.handle(
        _longitudeMeta,
        longitude.isAcceptableOrUnknown(data['longitude']!, _longitudeMeta),
      );
    } else if (isInserting) {
      context.missing(_longitudeMeta);
    }
    if (data.containsKey('saved_at')) {
      context.handle(
        _savedAtMeta,
        savedAt.isAcceptableOrUnknown(data['saved_at']!, _savedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {placeId};
  @override
  FavoritePlace map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FavoritePlace(
      placeId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}place_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      category: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category'],
      )!,
      latitude: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}latitude'],
      )!,
      longitude: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}longitude'],
      )!,
      savedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}saved_at'],
      )!,
    );
  }

  @override
  $FavoritePlacesTable createAlias(String alias) {
    return $FavoritePlacesTable(attachedDatabase, alias);
  }
}

class FavoritePlace extends DataClass implements Insertable<FavoritePlace> {
  final String placeId;
  final String name;
  final String category;
  final double latitude;
  final double longitude;
  final DateTime savedAt;
  const FavoritePlace({
    required this.placeId,
    required this.name,
    required this.category,
    required this.latitude,
    required this.longitude,
    required this.savedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['place_id'] = Variable<String>(placeId);
    map['name'] = Variable<String>(name);
    map['category'] = Variable<String>(category);
    map['latitude'] = Variable<double>(latitude);
    map['longitude'] = Variable<double>(longitude);
    map['saved_at'] = Variable<DateTime>(savedAt);
    return map;
  }

  FavoritePlacesCompanion toCompanion(bool nullToAbsent) {
    return FavoritePlacesCompanion(
      placeId: Value(placeId),
      name: Value(name),
      category: Value(category),
      latitude: Value(latitude),
      longitude: Value(longitude),
      savedAt: Value(savedAt),
    );
  }

  factory FavoritePlace.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FavoritePlace(
      placeId: serializer.fromJson<String>(json['placeId']),
      name: serializer.fromJson<String>(json['name']),
      category: serializer.fromJson<String>(json['category']),
      latitude: serializer.fromJson<double>(json['latitude']),
      longitude: serializer.fromJson<double>(json['longitude']),
      savedAt: serializer.fromJson<DateTime>(json['savedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'placeId': serializer.toJson<String>(placeId),
      'name': serializer.toJson<String>(name),
      'category': serializer.toJson<String>(category),
      'latitude': serializer.toJson<double>(latitude),
      'longitude': serializer.toJson<double>(longitude),
      'savedAt': serializer.toJson<DateTime>(savedAt),
    };
  }

  FavoritePlace copyWith({
    String? placeId,
    String? name,
    String? category,
    double? latitude,
    double? longitude,
    DateTime? savedAt,
  }) => FavoritePlace(
    placeId: placeId ?? this.placeId,
    name: name ?? this.name,
    category: category ?? this.category,
    latitude: latitude ?? this.latitude,
    longitude: longitude ?? this.longitude,
    savedAt: savedAt ?? this.savedAt,
  );
  FavoritePlace copyWithCompanion(FavoritePlacesCompanion data) {
    return FavoritePlace(
      placeId: data.placeId.present ? data.placeId.value : this.placeId,
      name: data.name.present ? data.name.value : this.name,
      category: data.category.present ? data.category.value : this.category,
      latitude: data.latitude.present ? data.latitude.value : this.latitude,
      longitude: data.longitude.present ? data.longitude.value : this.longitude,
      savedAt: data.savedAt.present ? data.savedAt.value : this.savedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FavoritePlace(')
          ..write('placeId: $placeId, ')
          ..write('name: $name, ')
          ..write('category: $category, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('savedAt: $savedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(placeId, name, category, latitude, longitude, savedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FavoritePlace &&
          other.placeId == this.placeId &&
          other.name == this.name &&
          other.category == this.category &&
          other.latitude == this.latitude &&
          other.longitude == this.longitude &&
          other.savedAt == this.savedAt);
}

class FavoritePlacesCompanion extends UpdateCompanion<FavoritePlace> {
  final Value<String> placeId;
  final Value<String> name;
  final Value<String> category;
  final Value<double> latitude;
  final Value<double> longitude;
  final Value<DateTime> savedAt;
  final Value<int> rowid;
  const FavoritePlacesCompanion({
    this.placeId = const Value.absent(),
    this.name = const Value.absent(),
    this.category = const Value.absent(),
    this.latitude = const Value.absent(),
    this.longitude = const Value.absent(),
    this.savedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  FavoritePlacesCompanion.insert({
    required String placeId,
    required String name,
    this.category = const Value.absent(),
    required double latitude,
    required double longitude,
    this.savedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : placeId = Value(placeId),
       name = Value(name),
       latitude = Value(latitude),
       longitude = Value(longitude);
  static Insertable<FavoritePlace> custom({
    Expression<String>? placeId,
    Expression<String>? name,
    Expression<String>? category,
    Expression<double>? latitude,
    Expression<double>? longitude,
    Expression<DateTime>? savedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (placeId != null) 'place_id': placeId,
      if (name != null) 'name': name,
      if (category != null) 'category': category,
      if (latitude != null) 'latitude': latitude,
      if (longitude != null) 'longitude': longitude,
      if (savedAt != null) 'saved_at': savedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  FavoritePlacesCompanion copyWith({
    Value<String>? placeId,
    Value<String>? name,
    Value<String>? category,
    Value<double>? latitude,
    Value<double>? longitude,
    Value<DateTime>? savedAt,
    Value<int>? rowid,
  }) {
    return FavoritePlacesCompanion(
      placeId: placeId ?? this.placeId,
      name: name ?? this.name,
      category: category ?? this.category,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      savedAt: savedAt ?? this.savedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (placeId.present) {
      map['place_id'] = Variable<String>(placeId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (latitude.present) {
      map['latitude'] = Variable<double>(latitude.value);
    }
    if (longitude.present) {
      map['longitude'] = Variable<double>(longitude.value);
    }
    if (savedAt.present) {
      map['saved_at'] = Variable<DateTime>(savedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FavoritePlacesCompanion(')
          ..write('placeId: $placeId, ')
          ..write('name: $name, ')
          ..write('category: $category, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('savedAt: $savedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PlaceReviewsTable extends PlaceReviews
    with TableInfo<$PlaceReviewsTable, PlaceReview> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PlaceReviewsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _placeIdMeta = const VerificationMeta(
    'placeId',
  );
  @override
  late final GeneratedColumn<String> placeId = GeneratedColumn<String>(
    'place_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _ratingMeta = const VerificationMeta('rating');
  @override
  late final GeneratedColumn<int> rating = GeneratedColumn<int>(
    'rating',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _commentMeta = const VerificationMeta(
    'comment',
  );
  @override
  late final GeneratedColumn<String> comment = GeneratedColumn<String>(
    'comment',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    placeId,
    rating,
    comment,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'place_reviews';
  @override
  VerificationContext validateIntegrity(
    Insertable<PlaceReview> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('place_id')) {
      context.handle(
        _placeIdMeta,
        placeId.isAcceptableOrUnknown(data['place_id']!, _placeIdMeta),
      );
    } else if (isInserting) {
      context.missing(_placeIdMeta);
    }
    if (data.containsKey('rating')) {
      context.handle(
        _ratingMeta,
        rating.isAcceptableOrUnknown(data['rating']!, _ratingMeta),
      );
    } else if (isInserting) {
      context.missing(_ratingMeta);
    }
    if (data.containsKey('comment')) {
      context.handle(
        _commentMeta,
        comment.isAcceptableOrUnknown(data['comment']!, _commentMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PlaceReview map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PlaceReview(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      placeId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}place_id'],
      )!,
      rating: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}rating'],
      )!,
      comment: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}comment'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $PlaceReviewsTable createAlias(String alias) {
    return $PlaceReviewsTable(attachedDatabase, alias);
  }
}

class PlaceReview extends DataClass implements Insertable<PlaceReview> {
  final int id;
  final String placeId;
  final int rating;
  final String comment;
  final DateTime createdAt;
  const PlaceReview({
    required this.id,
    required this.placeId,
    required this.rating,
    required this.comment,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['place_id'] = Variable<String>(placeId);
    map['rating'] = Variable<int>(rating);
    map['comment'] = Variable<String>(comment);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  PlaceReviewsCompanion toCompanion(bool nullToAbsent) {
    return PlaceReviewsCompanion(
      id: Value(id),
      placeId: Value(placeId),
      rating: Value(rating),
      comment: Value(comment),
      createdAt: Value(createdAt),
    );
  }

  factory PlaceReview.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PlaceReview(
      id: serializer.fromJson<int>(json['id']),
      placeId: serializer.fromJson<String>(json['placeId']),
      rating: serializer.fromJson<int>(json['rating']),
      comment: serializer.fromJson<String>(json['comment']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'placeId': serializer.toJson<String>(placeId),
      'rating': serializer.toJson<int>(rating),
      'comment': serializer.toJson<String>(comment),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  PlaceReview copyWith({
    int? id,
    String? placeId,
    int? rating,
    String? comment,
    DateTime? createdAt,
  }) => PlaceReview(
    id: id ?? this.id,
    placeId: placeId ?? this.placeId,
    rating: rating ?? this.rating,
    comment: comment ?? this.comment,
    createdAt: createdAt ?? this.createdAt,
  );
  PlaceReview copyWithCompanion(PlaceReviewsCompanion data) {
    return PlaceReview(
      id: data.id.present ? data.id.value : this.id,
      placeId: data.placeId.present ? data.placeId.value : this.placeId,
      rating: data.rating.present ? data.rating.value : this.rating,
      comment: data.comment.present ? data.comment.value : this.comment,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PlaceReview(')
          ..write('id: $id, ')
          ..write('placeId: $placeId, ')
          ..write('rating: $rating, ')
          ..write('comment: $comment, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, placeId, rating, comment, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PlaceReview &&
          other.id == this.id &&
          other.placeId == this.placeId &&
          other.rating == this.rating &&
          other.comment == this.comment &&
          other.createdAt == this.createdAt);
}

class PlaceReviewsCompanion extends UpdateCompanion<PlaceReview> {
  final Value<int> id;
  final Value<String> placeId;
  final Value<int> rating;
  final Value<String> comment;
  final Value<DateTime> createdAt;
  const PlaceReviewsCompanion({
    this.id = const Value.absent(),
    this.placeId = const Value.absent(),
    this.rating = const Value.absent(),
    this.comment = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  PlaceReviewsCompanion.insert({
    this.id = const Value.absent(),
    required String placeId,
    required int rating,
    this.comment = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : placeId = Value(placeId),
       rating = Value(rating);
  static Insertable<PlaceReview> custom({
    Expression<int>? id,
    Expression<String>? placeId,
    Expression<int>? rating,
    Expression<String>? comment,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (placeId != null) 'place_id': placeId,
      if (rating != null) 'rating': rating,
      if (comment != null) 'comment': comment,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  PlaceReviewsCompanion copyWith({
    Value<int>? id,
    Value<String>? placeId,
    Value<int>? rating,
    Value<String>? comment,
    Value<DateTime>? createdAt,
  }) {
    return PlaceReviewsCompanion(
      id: id ?? this.id,
      placeId: placeId ?? this.placeId,
      rating: rating ?? this.rating,
      comment: comment ?? this.comment,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (placeId.present) {
      map['place_id'] = Variable<String>(placeId.value);
    }
    if (rating.present) {
      map['rating'] = Variable<int>(rating.value);
    }
    if (comment.present) {
      map['comment'] = Variable<String>(comment.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PlaceReviewsCompanion(')
          ..write('id: $id, ')
          ..write('placeId: $placeId, ')
          ..write('rating: $rating, ')
          ..write('comment: $comment, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $FavoritePlacesTable favoritePlaces = $FavoritePlacesTable(this);
  late final $PlaceReviewsTable placeReviews = $PlaceReviewsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    favoritePlaces,
    placeReviews,
  ];
}

typedef $$FavoritePlacesTableCreateCompanionBuilder =
    FavoritePlacesCompanion Function({
      required String placeId,
      required String name,
      Value<String> category,
      required double latitude,
      required double longitude,
      Value<DateTime> savedAt,
      Value<int> rowid,
    });
typedef $$FavoritePlacesTableUpdateCompanionBuilder =
    FavoritePlacesCompanion Function({
      Value<String> placeId,
      Value<String> name,
      Value<String> category,
      Value<double> latitude,
      Value<double> longitude,
      Value<DateTime> savedAt,
      Value<int> rowid,
    });

class $$FavoritePlacesTableFilterComposer
    extends Composer<_$AppDatabase, $FavoritePlacesTable> {
  $$FavoritePlacesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get placeId => $composableBuilder(
    column: $table.placeId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get latitude => $composableBuilder(
    column: $table.latitude,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get longitude => $composableBuilder(
    column: $table.longitude,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get savedAt => $composableBuilder(
    column: $table.savedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$FavoritePlacesTableOrderingComposer
    extends Composer<_$AppDatabase, $FavoritePlacesTable> {
  $$FavoritePlacesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get placeId => $composableBuilder(
    column: $table.placeId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get latitude => $composableBuilder(
    column: $table.latitude,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get longitude => $composableBuilder(
    column: $table.longitude,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get savedAt => $composableBuilder(
    column: $table.savedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$FavoritePlacesTableAnnotationComposer
    extends Composer<_$AppDatabase, $FavoritePlacesTable> {
  $$FavoritePlacesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get placeId =>
      $composableBuilder(column: $table.placeId, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<double> get latitude =>
      $composableBuilder(column: $table.latitude, builder: (column) => column);

  GeneratedColumn<double> get longitude =>
      $composableBuilder(column: $table.longitude, builder: (column) => column);

  GeneratedColumn<DateTime> get savedAt =>
      $composableBuilder(column: $table.savedAt, builder: (column) => column);
}

class $$FavoritePlacesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $FavoritePlacesTable,
          FavoritePlace,
          $$FavoritePlacesTableFilterComposer,
          $$FavoritePlacesTableOrderingComposer,
          $$FavoritePlacesTableAnnotationComposer,
          $$FavoritePlacesTableCreateCompanionBuilder,
          $$FavoritePlacesTableUpdateCompanionBuilder,
          (
            FavoritePlace,
            BaseReferences<_$AppDatabase, $FavoritePlacesTable, FavoritePlace>,
          ),
          FavoritePlace,
          PrefetchHooks Function()
        > {
  $$FavoritePlacesTableTableManager(
    _$AppDatabase db,
    $FavoritePlacesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FavoritePlacesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FavoritePlacesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FavoritePlacesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> placeId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> category = const Value.absent(),
                Value<double> latitude = const Value.absent(),
                Value<double> longitude = const Value.absent(),
                Value<DateTime> savedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => FavoritePlacesCompanion(
                placeId: placeId,
                name: name,
                category: category,
                latitude: latitude,
                longitude: longitude,
                savedAt: savedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String placeId,
                required String name,
                Value<String> category = const Value.absent(),
                required double latitude,
                required double longitude,
                Value<DateTime> savedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => FavoritePlacesCompanion.insert(
                placeId: placeId,
                name: name,
                category: category,
                latitude: latitude,
                longitude: longitude,
                savedAt: savedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$FavoritePlacesTable, FavoritePlace>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $FavoritePlacesTable,
                    FavoritePlace
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$FavoritePlacesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $FavoritePlacesTable,
      FavoritePlace,
      $$FavoritePlacesTableFilterComposer,
      $$FavoritePlacesTableOrderingComposer,
      $$FavoritePlacesTableAnnotationComposer,
      $$FavoritePlacesTableCreateCompanionBuilder,
      $$FavoritePlacesTableUpdateCompanionBuilder,
      (
        FavoritePlace,
        BaseReferences<_$AppDatabase, $FavoritePlacesTable, FavoritePlace>,
      ),
      FavoritePlace,
      PrefetchHooks Function()
    >;
typedef $$PlaceReviewsTableCreateCompanionBuilder =
    PlaceReviewsCompanion Function({
      Value<int> id,
      required String placeId,
      required int rating,
      Value<String> comment,
      Value<DateTime> createdAt,
    });
typedef $$PlaceReviewsTableUpdateCompanionBuilder =
    PlaceReviewsCompanion Function({
      Value<int> id,
      Value<String> placeId,
      Value<int> rating,
      Value<String> comment,
      Value<DateTime> createdAt,
    });

class $$PlaceReviewsTableFilterComposer
    extends Composer<_$AppDatabase, $PlaceReviewsTable> {
  $$PlaceReviewsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get placeId => $composableBuilder(
    column: $table.placeId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get rating => $composableBuilder(
    column: $table.rating,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get comment => $composableBuilder(
    column: $table.comment,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$PlaceReviewsTableOrderingComposer
    extends Composer<_$AppDatabase, $PlaceReviewsTable> {
  $$PlaceReviewsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get placeId => $composableBuilder(
    column: $table.placeId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get rating => $composableBuilder(
    column: $table.rating,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get comment => $composableBuilder(
    column: $table.comment,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PlaceReviewsTableAnnotationComposer
    extends Composer<_$AppDatabase, $PlaceReviewsTable> {
  $$PlaceReviewsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get placeId =>
      $composableBuilder(column: $table.placeId, builder: (column) => column);

  GeneratedColumn<int> get rating =>
      $composableBuilder(column: $table.rating, builder: (column) => column);

  GeneratedColumn<String> get comment =>
      $composableBuilder(column: $table.comment, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$PlaceReviewsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PlaceReviewsTable,
          PlaceReview,
          $$PlaceReviewsTableFilterComposer,
          $$PlaceReviewsTableOrderingComposer,
          $$PlaceReviewsTableAnnotationComposer,
          $$PlaceReviewsTableCreateCompanionBuilder,
          $$PlaceReviewsTableUpdateCompanionBuilder,
          (
            PlaceReview,
            BaseReferences<_$AppDatabase, $PlaceReviewsTable, PlaceReview>,
          ),
          PlaceReview,
          PrefetchHooks Function()
        > {
  $$PlaceReviewsTableTableManager(_$AppDatabase db, $PlaceReviewsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PlaceReviewsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PlaceReviewsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PlaceReviewsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> placeId = const Value.absent(),
                Value<int> rating = const Value.absent(),
                Value<String> comment = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => PlaceReviewsCompanion(
                id: id,
                placeId: placeId,
                rating: rating,
                comment: comment,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String placeId,
                required int rating,
                Value<String> comment = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => PlaceReviewsCompanion.insert(
                id: id,
                placeId: placeId,
                rating: rating,
                comment: comment,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$PlaceReviewsTable, PlaceReview>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $PlaceReviewsTable,
                    PlaceReview
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$PlaceReviewsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PlaceReviewsTable,
      PlaceReview,
      $$PlaceReviewsTableFilterComposer,
      $$PlaceReviewsTableOrderingComposer,
      $$PlaceReviewsTableAnnotationComposer,
      $$PlaceReviewsTableCreateCompanionBuilder,
      $$PlaceReviewsTableUpdateCompanionBuilder,
      (
        PlaceReview,
        BaseReferences<_$AppDatabase, $PlaceReviewsTable, PlaceReview>,
      ),
      PlaceReview,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$FavoritePlacesTableTableManager get favoritePlaces =>
      $$FavoritePlacesTableTableManager(_db, _db.favoritePlaces);
  $$PlaceReviewsTableTableManager get placeReviews =>
      $$PlaceReviewsTableTableManager(_db, _db.placeReviews);
}

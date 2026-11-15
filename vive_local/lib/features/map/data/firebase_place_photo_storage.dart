import 'dart:io';
import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../../../core/errors/app_failure.dart';
import '../domain/place_photo_storage.dart';

class FirebasePlacePhotoStorage implements PlacePhotoStorage {
  FirebasePlacePhotoStorage(this._storage, this._auth, {Random? random})
    : _random = random ?? Random.secure();

  final FirebaseStorage _storage;
  final FirebaseAuth _auth;
  final Random _random;

  @override
  Future<String> uploadPlacePhoto({
    required String filePath,
    String? contentType,
  }) async {
    final user = _auth.currentUser;
    if (user == null) {
      throw const AppFailure(FailureCode.authFailed);
    }

    final extension = _fileExtension(filePath);
    final fileName =
        '${DateTime.now().microsecondsSinceEpoch}_'
        '${_random.nextInt(1 << 32)}$extension';
    final reference = _storage
        .ref()
        .child('lugares')
        .child(user.uid)
        .child(fileName);

    try {
      final snapshot = await reference.putFile(
        File(filePath),
        SettableMetadata(contentType: _contentType(contentType, extension)),
      );
      return await snapshot.ref.getDownloadURL();
    } on FirebaseException catch (error, stackTrace) {
      throw AppFailure(
        FailureCode.photoUploadFailed,
        cause: error,
        stackTrace: stackTrace,
      );
    } on FileSystemException catch (error, stackTrace) {
      throw AppFailure(
        FailureCode.photoUploadFailed,
        cause: error,
        stackTrace: stackTrace,
      );
    }
  }

  @override
  Future<void> deletePlacePhoto(String downloadUrl) async {
    try {
      await _storage.refFromURL(downloadUrl).delete();
    } on FirebaseException catch (error, stackTrace) {
      throw AppFailure(
        FailureCode.photoUploadFailed,
        cause: error,
        stackTrace: stackTrace,
      );
    }
  }

  String _fileExtension(String filePath) {
    final fileName = filePath.split(RegExp(r'[/\\]')).last;
    final dotIndex = fileName.lastIndexOf('.');
    if (dotIndex <= 0) {
      return '.jpg';
    }
    final extension = fileName.substring(dotIndex).toLowerCase();
    return RegExp(r'^\.[a-z0-9]{1,5}$').hasMatch(extension)
        ? extension
        : '.jpg';
  }

  String _contentType(String? provided, String extension) {
    final normalized = provided?.trim().toLowerCase();
    if (normalized != null && normalized.startsWith('image/')) {
      return normalized;
    }
    return switch (extension) {
      '.png' => 'image/png',
      '.webp' => 'image/webp',
      '.heic' => 'image/heic',
      '.heif' => 'image/heif',
      '.gif' => 'image/gif',
      _ => 'image/jpeg',
    };
  }
}

import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import '../../../../core/l10n/app_localizations.dart';
import '../../domain/lugar_foto.dart';
import '../providers/place_photos_providers.dart';

class PlacePhotoGallery extends ConsumerStatefulWidget {
  const PlacePhotoGallery({
    super.key,
    required this.lugarId,
    this.placeName = '',
    this.compact = false,
  });

  final String lugarId;
  final String placeName;
  final bool compact;

  @override
  ConsumerState<PlacePhotoGallery> createState() => _PlacePhotoGalleryState();
}

class _PlacePhotoGalleryState extends ConsumerState<PlacePhotoGallery> {
  int _selectedIndex = 0;
  bool _isTakingPhoto = false;

  Future<void> _takePhoto() async {
    final l10n = AppLocalizations.of(context);
    setState(() => _isTakingPhoto = true);
    try {
      final repo = ref.read(placePhotosRepositoryProvider);
      final foto = await repo.takePhotoWithCamera(lugarId: widget.lugarId);
      if (!mounted) return;
      if (foto != null) {
        ref.invalidate(placePhotosProvider(widget.lugarId));
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.photoSaved)),
        );
      }
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.errorPhotoPick)),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isTakingPhoto = false);
      }
    }
  }

  Future<void> _pickFromGallery() async {
    final l10n = AppLocalizations.of(context);
    setState(() => _isTakingPhoto = true);
    try {
      final repo = ref.read(placePhotosRepositoryProvider);
      final foto = await repo.pickPhotoFromGallery(lugarId: widget.lugarId);
      if (!mounted) return;
      if (foto != null) {
        ref.invalidate(placePhotosProvider(widget.lugarId));
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.photoSaved)),
        );
      }
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.errorPhotoPick)),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isTakingPhoto = false);
      }
    }
  }

  Future<void> _confirmDelete(LugarFoto foto) async {
    final l10n = AppLocalizations.of(context);
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.deletePhotoTitle),
        content: Text(l10n.deletePhotoConfirm),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: Text(l10n.cancel),
          ),
          FilledButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            child: Text(l10n.delete),
          ),
        ],
      ),
    );

    if (confirmed == true && mounted) {
      final repo = ref.read(placePhotosRepositoryProvider);
      await repo.deletePhoto(foto);
      ref.invalidate(placePhotosProvider(widget.lugarId));
    }
  }

  void _showAddPhotoOptions() {
    final l10n = AppLocalizations.of(context);
    showModalBottomSheet<void>(
      context: context,
      builder: (ctx) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: Text(l10n.takePhotoWithCamera),
              onTap: () {
                Navigator.of(ctx).pop();
                _takePhoto();
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: Text(l10n.chooseFromGallery),
              onTap: () {
                Navigator.of(ctx).pop();
                _pickFromGallery();
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showImagePreview(BuildContext context, LugarFoto foto) {
    showDialog(
      context: context,
      builder: (ctx) => Dialog(
        insetPadding: const EdgeInsets.all(12),
        backgroundColor: Colors.transparent,
        child: Stack(
          alignment: Alignment.topRight,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: InteractiveViewer(
                child: foto.esLocal
                    ? Image.file(
                        File(foto.imagePath),
                        fit: BoxFit.contain,
                        errorBuilder: (_, _, _) => _errorContainer(),
                      )
                    : Image.network(
                        foto.imagePath,
                        fit: BoxFit.contain,
                        errorBuilder: (_, _, _) => _errorContainer(),
                      ),
              ),
            ),
            Positioned(
              top: 8,
              right: 8,
              child: IconButton.filled(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.of(ctx).pop(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _errorContainer() {
    return Container(
      color: Colors.black26,
      alignment: Alignment.center,
      child: const Icon(Icons.broken_image, size: 48, color: Colors.white70),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final photosAsync = ref.watch(placePhotosProvider(widget.lugarId));

    return photosAsync.when(
      loading: () => SizedBox(
        height: widget.compact ? 160 : 220,
        child: const Center(child: CircularProgressIndicator()),
      ),
      error: (_, _) => Container(
        height: widget.compact ? 140 : 180,
        alignment: Alignment.center,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: theme.colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outline, size: 36),
            const SizedBox(height: 8),
            Text(l10n.errorGeneric),
            TextButton(
              onPressed: () =>
                  ref.invalidate(placePhotosProvider(widget.lugarId)),
              child: Text(l10n.retry),
            ),
          ],
        ),
      ),
      data: (photos) {
        if (_selectedIndex >= photos.length && photos.isNotEmpty) {
          _selectedIndex = photos.length - 1;
        }

        final mainHeight = widget.compact ? 170.0 : 230.0;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Main image preview
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: SizedBox(
                height: mainHeight,
                width: double.infinity,
                child: photos.isEmpty
                    ? Container(
                        color: theme.colorScheme.surfaceContainerHighest,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.camera_alt_outlined,
                              size: 48,
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              l10n.noPhotosYet,
                              style: theme.textTheme.bodyMedium,
                            ),
                            const SizedBox(height: 12),
                            FilledButton.icon(
                              onPressed: _isTakingPhoto ? null : _takePhoto,
                              icon: _isTakingPhoto
                                  ? const SizedBox(
                                      width: 16,
                                      height: 16,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        color: Colors.white,
                                      ),
                                    )
                                  : const Icon(Icons.camera_alt),
                              label: Text(l10n.takePhotoWithCamera),
                            ),
                          ],
                        ),
                      )
                    : Stack(
                        fit: StackFit.expand,
                        children: [
                          GestureDetector(
                            onTap: () => _showImagePreview(
                              context,
                              photos[_selectedIndex],
                            ),
                            child: photos[_selectedIndex].esLocal
                                ? Image.file(
                                    File(photos[_selectedIndex].imagePath),
                                    fit: BoxFit.cover,
                                    errorBuilder: (_, _, _) =>
                                        _errorContainer(),
                                  )
                                : Image.network(
                                    photos[_selectedIndex].imagePath,
                                    fit: BoxFit.cover,
                                    errorBuilder: (_, _, _) =>
                                        _errorContainer(),
                                  ),
                          ),
                          // Badge: Local vs Web
                          Positioned(
                            top: 10,
                            left: 10,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.black.withValues(alpha: 0.65),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    photos[_selectedIndex].esLocal
                                        ? Icons.phone_android
                                        : Icons.public,
                                    size: 14,
                                    color: Colors.white,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    photos[_selectedIndex].esLocal
                                        ? l10n.localBadge
                                        : l10n.webBadge,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          // Delete button if local
                          if (photos[_selectedIndex].esLocal)
                            Positioned(
                              top: 10,
                              right: 10,
                              child: IconButton.filledTonal(
                                tooltip: l10n.delete,
                                icon: const Icon(Icons.delete_outline, size: 18),
                                onPressed: () =>
                                    _confirmDelete(photos[_selectedIndex]),
                              ),
                            ),
                          // Camera Floating Action button over main photo
                          Positioned(
                            right: 10,
                            bottom: 10,
                            child: FloatingActionButton.small(
                              heroTag: 'camera-${widget.lugarId}',
                              tooltip: l10n.takePhotoWithCamera,
                              onPressed: _isTakingPhoto ? null : _takePhoto,
                              child: _isTakingPhoto
                                  ? const SizedBox(
                                      width: 18,
                                      height: 18,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                      ),
                                    )
                                  : const Icon(Icons.camera_alt),
                            ),
                          ),
                        ],
                      ),
              ),
            ),
            const SizedBox(height: 12),
            // Thumbnails row + add photo action
            SizedBox(
              height: 72,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: photos.length + 1,
                separatorBuilder: (_, _) => const SizedBox(width: 8),
                itemBuilder: (context, index) {
                  if (index == photos.length) {
                    // Add photo button card
                    return InkWell(
                      borderRadius: BorderRadius.circular(10),
                      onTap: _isTakingPhoto ? null : _showAddPhotoOptions,
                      child: Container(
                        width: 72,
                        decoration: BoxDecoration(
                          color: theme.colorScheme.surfaceContainerHighest,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: theme.colorScheme.outlineVariant,
                            width: 1,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.add_a_photo_outlined,
                              size: 24,
                              color: theme.colorScheme.primary,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              l10n.takePhoto,
                              style: theme.textTheme.labelSmall?.copyWith(
                                fontSize: 10,
                              ),
                              textAlign: TextAlign.center,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    );
                  }

                  final foto = photos[index];
                  final isSelected = index == _selectedIndex;

                  return GestureDetector(
                    onTap: () => setState(() => _selectedIndex = index),
                    onLongPress: foto.esLocal ? () => _confirmDelete(foto) : null,
                    child: Container(
                      width: 72,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: isSelected
                              ? theme.colorScheme.primary
                              : Colors.transparent,
                          width: 2.5,
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            foto.esLocal
                                ? Image.file(
                                    File(foto.imagePath),
                                    fit: BoxFit.cover,
                                    errorBuilder: (_, _, _) =>
                                        _errorContainer(),
                                  )
                                : Image.network(
                                    foto.imagePath,
                                    fit: BoxFit.cover,
                                    errorBuilder: (_, _, _) =>
                                        _errorContainer(),
                                  ),
                            if (foto.esLocal)
                              Positioned(
                                right: 2,
                                bottom: 2,
                                child: Container(
                                  padding: const EdgeInsets.all(2),
                                  decoration: BoxDecoration(
                                    color: Colors.black54,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: const Icon(
                                    Icons.phone_android,
                                    size: 10,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}

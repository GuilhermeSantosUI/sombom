part of '../app.dart';

extension _SharedPresentation on _SomBomAppState {
  Widget _errorBox() => _formError == null
      ? const SizedBox.shrink()
      : Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Semantics(
            liveRegion: true,
            child: Text(_formError!, style: Design.text(13, color: Design.red)),
          ),
        );
  Widget _regionSelector(
    String id,
    ValueChanged<String>? onChange, {
    String label = 'Região simulada',
  }) => DropdownButtonFormField<String>(
    key: ValueKey('$label-$id'),
    initialValue: id,
    isExpanded: true,
    decoration: InputDecoration(
      labelText: label,
      labelStyle: Design.text(12, color: Design.muted),
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Design.border),
      ),
    ),
    style: Design.text(14, color: Theme.of(_ui).colorScheme.onSurface),
    items: DemoState.regions
        .map((r) => DropdownMenuItem(value: r.id, child: Text(r.name)))
        .toList(),
    onChanged: onChange == null ? null : (id) => onChange(id!),
  );
  String _duration(int seconds) =>
      '${(seconds ~/ 60).toString().padLeft(2, '0')}:${(seconds % 60).toString().padLeft(2, '0')}';
}

part of '../../app.dart';

extension _ReportModule on _SomBomAppState {
  Widget _report() => _scroll([
    Row(
      children: [
        Expanded(
          child: _text(
            '1. TIPO DE RUÍDO',
            weight: FontWeight.w700,
            color: Design.acousticMuted,
          ),
        ),
        if (note.text.isNotEmpty)
          _text('Rascunho', size: 10, color: Design.magenta),
      ],
    ),
    _gap(8),
    DemoSegments(
      labels: DemoState.types.skip(1).toList(),
      selected: _reportType,
      onChanged: (i) => _update(() => _reportType = i),
    ),
    _gap(20),
    _text(
      '2. QUANDO E ONDE',
      weight: FontWeight.w700,
      color: Design.acousticMuted,
    ),
    _gap(8),
    Row(
      children: [
        Expanded(
          child: OutlinedButton.icon(
            onPressed: _pickDate,
            icon: const FigmaAsset('0dafa.svg', size: 16),
            label: Text(
              '${_reportTime.day} ${_month(_reportTime.month)} ${_reportTime.year}',
            ),
          ),
        ),
        const SizedBox(width: 8),
        OutlinedButton(
          onPressed: _pickTime,
          child: Text(
            '${_reportTime.hour.toString().padLeft(2, '0')}:${_reportTime.minute.toString().padLeft(2, '0')}',
          ),
        ),
      ],
    ),
    _gap(12),
    _regionSelector(_reportRegionId, (id) {
      _update(() {
        _reportRegionId = id;
        if (_reportMeasurement?.regionId != id) _reportMeasurement = null;
      });
    }),
    _gap(20),
    _text(
      '3. INTENSIDADE PERCEBIDA',
      weight: FontWeight.w700,
      color: Design.acousticMuted,
    ),
    _gap(8),
    DemoSegments(
      labels: const ['Leve', 'Moderada', 'Intensa'],
      selected: _intensity,
      onChanged: (i) => _update(() => _intensity = i),
    ),
    _gap(12),
    if (_reportMeasurement != null)
      DemoCard(
        acoustic: true,
        bordered: true,
        radius: 12,
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Expanded(
              child: _text(
                'Medição vinculada: ${_reportMeasurement!.average.round()} dB\n${_duration(_reportMeasurement!.seconds)} · ${_reportMeasurement!.scenario}',
                size: 12,
              ),
            ),
            IconButton(
              tooltip: 'Remover medição vinculada',
              onPressed: () => _update(() => _reportMeasurement = null),
              icon: const Icon(CupertinoIcons.xmark_circle, size: 18),
            ),
          ],
        ),
      ),
    _gap(12),
    _text(
      '4. OBSERVAÇÃO (OPCIONAL)',
      weight: FontWeight.w700,
      color: Design.acousticMuted,
    ),
    _gap(8),
    TextField(
      controller: note,
      onChanged: (_) => _update(() {}),
      maxLength: 500,
      maxLines: 3,
      minLines: 2,
      style: Design.text(14),
      decoration: InputDecoration(
        hintText: 'Descreva o incômodo sem citar nomes ou endereços.',
        hintStyle: Design.text(13, color: Design.muted),
        filled: true,
        fillColor: Theme.of(_ui).brightness == Brightness.dark
            ? Design.acousticSurface
            : const Color(0xfff0edf4),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    ),
    _gap(12),
    SwitchListTile(
      contentPadding: EdgeInsets.zero,
      title: _text('Enviar anonimamente', weight: FontWeight.w600),
      subtitle: _text(
        'Sem nome ou localização real.',
        size: 11,
        color: Design.muted,
      ),
      value: data.anonymous,
      onChanged: data.setAnonymous,
      activeThumbColor: Design.green,
    ),
    _gap(12),
    if (_formError != null) _errorBox(),
    DemoButton(
      data.anonymous ? 'Enviar Relato Anônimo' : 'Enviar Relato',
      blue: true,
      onPressed: _submitReport,
    ),
    _gap(8),
    Center(
      child: TextButton(
        onPressed: _discardDraft,
        child: const Text('Limpar rascunho'),
      ),
    ),
    _gap(8),
    _text(
      'Registro fictício, salvo somente neste dispositivo. Nenhuma denúncia será enviada.',
      size: 11,
      color: Design.muted,
    ),
  ], padding: 20);
  String _month(int m) => [
    'Jan',
    'Fev',
    'Mar',
    'Abr',
    'Mai',
    'Jun',
    'Jul',
    'Ago',
    'Set',
    'Out',
    'Nov',
    'Dez',
  ][m - 1];
  Future<void> _pickDate() async {
    final now = data.clock();
    final date = await showDatePicker(
      context: _ui,
      initialDate: _reportTime.isAfter(now) ? now : _reportTime,
      firstDate: DateTime(2020),
      lastDate: DateTime(now.year, now.month, now.day),
      helpText: 'Data do ocorrido',
      cancelText: 'Cancelar',
      confirmText: 'Selecionar',
    );
    if (date != null && mounted) {
      _update(
        () => _reportTime = DateTime(
          date.year,
          date.month,
          date.day,
          _reportTime.hour,
          _reportTime.minute,
        ),
      );
    }
  }

  Future<void> _pickTime() async {
    final time = await showTimePicker(
      context: _ui,
      initialTime: TimeOfDay.fromDateTime(_reportTime),
      helpText: 'Horário do ocorrido',
      cancelText: 'Cancelar',
      confirmText: 'Selecionar',
    );
    if (time != null && mounted) {
      _update(
        () => _reportTime = DateTime(
          _reportTime.year,
          _reportTime.month,
          _reportTime.day,
          time.hour,
          time.minute,
        ),
      );
    }
  }

  Future<void> _discardDraft() async {
    final discard = await showDialog<bool>(
      context: _ui,
      builder: (context) => AlertDialog(
        title: const Text('Limpar rascunho?'),
        content: const Text(
          'O texto, os filtros e a medição vinculada serão removidos deste formulário.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Manter'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Limpar'),
          ),
        ],
      ),
    );
    if (discard == true && mounted) {
      _update(() {
        note.clear();
        _reportMeasurement = null;
        _reportTime = data.clock();
        _reportType = 0;
        _intensity = 0;
        _formError = null;
      });
    }
  }

  Future<void> _submitReport() async {
    if (_reportTime.isAfter(data.clock().add(const Duration(minutes: 1)))) {
      _update(() => _formError = 'Escolha um horário que já ocorreu.');
      return;
    }
    final saved = data.addReport(
      DemoReport(
        type: DemoState.types[_reportType + 1],
        intensity: ['Leve', 'Moderada', 'Intensa'][_intensity],
        when: _reportTime,
        note: note.text.trim(),
        regionId: _reportRegionId,
        level: _reportMeasurement?.average.round() ?? [47, 62, 82][_intensity],
        anonymous: data.anonymous,
        measurementId: _reportMeasurement?.id,
      ),
    );
    note.clear();
    _reportMeasurement = null;
    _formError = null;
    await showDialog<void>(
      context: _ui,
      builder: (context) => AlertDialog(
        icon: const Icon(
          CupertinoIcons.checkmark_circle_fill,
          color: Design.green,
          size: 40,
        ),
        title: const Text('Relato registrado'),
        content: Text(
          '${DemoState.region(saved.regionId).name} · ${saved.level} dB simulados\nO registro foi salvo neste dispositivo.',
        ),
        actions: [
          FilledButton(
            onPressed: () {
              Navigator.pop(context);
              _selectedReportId = saved.id;
              _go(DemoScreen.detail);
            },
            child: const Text('Ver relato'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _update(
                () => _history
                  ..clear()
                  ..add(DemoScreen.report),
              );
            },
            child: const Text('Novo relato'),
          ),
        ],
      ),
    );
  }
}

import 'dart:async';

import 'package:flutter/material.dart';

void main() {
  runApp(const NivoApp());
}

class NivoApp extends StatelessWidget {
  const NivoApp({super.key});

  static const Color ink = Color(0xFF182B49);
  static const Color blue = Color(0xFF4169E1);
  static const Color mint = Color(0xFF63D6BD);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NIVO',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: blue,
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: const Color(0xFFF8FAFF),
        fontFamily: 'Roboto',
      ),
      home: const SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? _navigationTimer;
  bool _navigationStarted = false;

  @override
  void initState() {
    super.initState();
    _navigationTimer = Timer(const Duration(seconds: 3), _openHome);
  }

  void _openHome() {
    if (!mounted || _navigationStarted) return;
    _navigationStarted = true;
    _navigationTimer?.cancel();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute<void>(builder: (_) => const HomeScreen()),
    );
  }

  @override
  void dispose() {
    _navigationTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFFF8FAFF), Color(0xFFEFF5FF)],
          ),
        ),
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final compact = constraints.maxHeight < 600;
              return Center(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                    horizontal: 28,
                    vertical: compact ? 20 : 32,
                  ),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 420),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: compact ? 104 : 124,
                          height: compact ? 104 : 124,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: const LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [NivoApp.blue, Color(0xFF6D8EFF)],
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: NivoApp.blue.withValues(alpha: 0.22),
                                blurRadius: 28,
                                offset: const Offset(0, 14),
                              ),
                            ],
                          ),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Icon(
                                Icons.auto_stories_rounded,
                                size: compact ? 45 : 52,
                                color: Colors.white.withValues(alpha: 0.92),
                              ),
                              Positioned(
                                right: compact ? 22 : 27,
                                bottom: compact ? 21 : 26,
                                child: Container(
                                  width: 13,
                                  height: 13,
                                  decoration: const BoxDecoration(
                                    color: NivoApp.mint,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: compact ? 28 : 36),
                        const Text(
                          'NIVO',
                          style: TextStyle(
                            color: NivoApp.ink,
                            fontSize: 38,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 8,
                          ),
                        ),
                        const SizedBox(height: 14),
                        const Text(
                          'Belajar Logika,\nKuasai Pemrograman',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xFF64738B),
                            fontSize: 17,
                            height: 1.55,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: compact ? 28 : 36),
                        SizedBox(
                          width: 220,
                          height: 52,
                          child: FilledButton(
                            onPressed: _openHome,
                            style: FilledButton.styleFrom(
                              backgroundColor: NivoApp.blue,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              textStyle: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            child: const Text('Mulai Belajar'),
                          ),
                        ),
                        SizedBox(height: compact ? 42 : 58),
                        SizedBox(
                          width: 34,
                          height: 34,
                          child: CircularProgressIndicator(
                            strokeWidth: 3,
                            color: NivoApp.blue.withValues(alpha: 0.72),
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
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _openMaterials(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        settings: const RouteSettings(name: '/materials'),
        builder: (_) => const MaterialsListScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) => Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(22, 20, 22, 32),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 500),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const _NivoWordmark(),
                        Container(
                          width: 42,
                          height: 42,
                          decoration: BoxDecoration(
                            color: const Color(0xFFEAF0FF),
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: NivoApp.blue.withValues(alpha: 0.12),
                            ),
                          ),
                          child: const Icon(
                            Icons.person_rounded,
                            color: NivoApp.blue,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),
                    const Text(
                      'Halo, Nelen! 👋',
                      style: TextStyle(
                        color: NivoApp.ink,
                        fontSize: 27,
                        fontWeight: FontWeight.w700,
                        height: 1.2,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Yuk lanjutkan belajar hari ini.',
                      style: TextStyle(color: Color(0xFF64738B), fontSize: 15),
                    ),
                    const SizedBox(height: 26),
                    const _ProgressOverviewCard(),
                    const SizedBox(height: 28),
                    const _SectionLabel(title: 'Sedang Dipelajari'),
                    const SizedBox(height: 14),
                    _ContinueLearningCard(
                      onContinue: () => _openMaterials(context),
                    ),
                    const SizedBox(height: 22),
                    SizedBox(
                      width: double.infinity,
                      height: 54,
                      child: FilledButton.icon(
                        onPressed: () => _openMaterials(context),
                        icon: const Icon(Icons.play_arrow_rounded),
                        label: const Text('Mulai Belajar'),
                        style: FilledButton.styleFrom(
                          backgroundColor: NivoApp.blue,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          textStyle: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 22),
                    _MaterialsShortcut(onTap: () => _openMaterials(context)),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ProgressOverviewCard extends StatelessWidget {
  const _ProgressOverviewCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [NivoApp.blue, Color(0xFF6383F1)],
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: NivoApp.blue.withValues(alpha: 0.2),
            blurRadius: 22,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Progress Belajar',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 18),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Text(
                '65%',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 38,
                  fontWeight: FontWeight.w800,
                  height: 1,
                ),
              ),
              const Spacer(),
              Text(
                '12 dari 18 materi selesai',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.88),
                  fontSize: 12,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: const LinearProgressIndicator(
              value: 0.65,
              minHeight: 9,
              backgroundColor: Color(0x556F8CF0),
              valueColor: AlwaysStoppedAnimation<Color>(NivoApp.mint),
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        color: NivoApp.ink,
        fontSize: 18,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}

class _ContinueLearningCard extends StatelessWidget {
  const _ContinueLearningCard({required this.onContinue});

  final VoidCallback onContinue;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: const Color(0xFFE9EEF7)),
        boxShadow: [
          BoxShadow(
            color: NivoApp.ink.withValues(alpha: 0.04),
            blurRadius: 18,
            offset: const Offset(0, 7),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 54,
                height: 54,
                decoration: BoxDecoration(
                  color: const Color(0xFFEAF0FF),
                  borderRadius: BorderRadius.circular(17),
                ),
                child: const Icon(
                  Icons.code_rounded,
                  color: NivoApp.blue,
                  size: 29,
                ),
              ),
              const SizedBox(width: 14),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Pemrograman Mobile',
                      style: TextStyle(
                        color: NivoApp.ink,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      'Materi 4 — Flutter & Widget',
                      style: TextStyle(color: Color(0xFF77849A), fontSize: 13),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              const Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  child: LinearProgressIndicator(
                    value: 0.7,
                    minHeight: 7,
                    backgroundColor: Color(0xFFEAF0FF),
                    valueColor: AlwaysStoppedAnimation<Color>(NivoApp.blue),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Text(
                '70%',
                style: TextStyle(
                  color: NivoApp.ink.withValues(alpha: 0.75),
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: onContinue,
              style: OutlinedButton.styleFrom(
                foregroundColor: NivoApp.blue,
                side: const BorderSide(color: Color(0xFFDCE5FF)),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                padding: const EdgeInsets.symmetric(vertical: 13),
                textStyle: const TextStyle(fontWeight: FontWeight.w600),
              ),
              child: const Text('Lanjutkan Belajar'),
            ),
          ),
        ],
      ),
    );
  }
}

class _MaterialsShortcut extends StatelessWidget {
  const _MaterialsShortcut({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: const Color(0xFFE9EEF7)),
          ),
          child: const Row(
            children: [
              Icon(Icons.menu_book_rounded, color: NivoApp.blue, size: 25),
              SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Daftar Materi',
                      style: TextStyle(
                        color: NivoApp.ink,
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Lihat seluruh materi pembelajaran',
                      style: TextStyle(color: Color(0xFF77849A), fontSize: 12),
                    ),
                  ],
                ),
              ),
              Icon(Icons.arrow_forward_rounded, color: NivoApp.blue, size: 20),
            ],
          ),
        ),
      ),
    );
  }
}

enum MaterialStatus { notStarted, inProgress, notMastered, mastered }

class LearningMaterial {
  const LearningMaterial({
    required this.subject,
    required this.title,
    required this.subtopics,
    required this.overviewHeading,
    required this.overview,
    required this.keyPoints,
  });

  final String subject;
  final String title;
  final List<String> subtopics;
  final String overviewHeading;
  final String overview;
  final List<String> keyPoints;
}

const List<LearningMaterial> _learningMaterials = [
  LearningMaterial(
    subject: 'Pemrograman Mobile',
    title: 'Materi 1 — Pengenalan Flutter',
    subtopics: [
      'Submateri 1 — Pengenalan Konsep',
      'Submateri 2 — Konsep Dasar',
      'Submateri 3 — Penerapan',
    ],
    overviewHeading: 'Apa itu Flutter?',
    overview:
        'Flutter adalah toolkit antarmuka dari Google untuk membuat aplikasi '
        'dari satu basis kode. Dengan Flutter, tampilan aplikasi disusun dari '
        'komponen yang disebut widget.',
    keyPoints: [
      'Satu basis kode dapat digunakan untuk beberapa platform.',
      'Widget menjadi bagian dasar untuk menyusun tampilan.',
      'Dart adalah bahasa pemrograman yang digunakan Flutter.',
    ],
  ),
  LearningMaterial(
    subject: 'Pemrograman Mobile',
    title: 'Materi 2 — Struktur Project Flutter',
    subtopics: [
      'Submateri 1 — Folder Utama',
      'Submateri 2 — File Konfigurasi',
      'Submateri 3 — Titik Awal Aplikasi',
    ],
    overviewHeading: 'Mengenal struktur project',
    overview:
        'Project Flutter memiliki folder dan file dengan tugas masing-masing. '
        'Memahami strukturnya membantu kita menemukan kode aplikasi dan '
        'konfigurasi yang dibutuhkan.',
    keyPoints: [
      'Kode Dart aplikasi umumnya disimpan di folder lib.',
      'Folder platform berisi bagian khusus Android, iOS, dan platform lain.',
      'pubspec.yaml mencatat konfigurasi serta dependency project.',
    ],
  ),
  LearningMaterial(
    subject: 'Pemrograman Mobile',
    title: 'Materi 3 — Widget Dasar',
    subtopics: [
      'Submateri 1 — Text dan Icon',
      'Submateri 2 — Container dan Padding',
      'Submateri 3 — Widget Interaktif',
    ],
    overviewHeading: 'Menyusun tampilan dengan widget',
    overview:
        'Widget adalah blok penyusun antarmuka Flutter. Widget sederhana '
        'dapat digabungkan untuk membentuk layar yang informatif dan mudah '
        'digunakan.',
    keyPoints: [
      'Text menampilkan tulisan dan Icon menampilkan simbol.',
      'Container dan Padding membantu mengatur ruang serta dekorasi.',
      'Tombol adalah contoh widget yang merespons interaksi pengguna.',
    ],
  ),
  LearningMaterial(
    subject: 'Pemrograman Mobile',
    title: 'Materi 4 — Flutter & Widget',
    subtopics: [
      'Submateri 1 — Widget Tree',
      'Submateri 2 — Stateless dan Stateful',
      'Submateri 3 — Memperbarui Tampilan',
    ],
    overviewHeading: 'Memahami cara kerja widget',
    overview:
        'Widget Flutter tersusun dalam hierarki. Setiap widget memiliki '
        'tanggung jawab tertentu, mulai dari menampilkan konten hingga '
        'mengelola perubahan tampilan.',
    keyPoints: [
      'Widget tree menggambarkan susunan widget pada layar.',
      'StatelessWidget digunakan untuk tampilan yang tidak menyimpan state.',
      'StatefulWidget dapat membangun ulang tampilan saat state berubah.',
    ],
  ),
  LearningMaterial(
    subject: 'Pemrograman Mobile',
    title: 'Materi 5 — Layout dan Navigasi',
    subtopics: [
      'Submateri 1 — Row dan Column',
      'Submateri 2 — Mengatur Ruang Layout',
      'Submateri 3 — Navigasi Antarhalaman',
    ],
    overviewHeading: 'Mengatur layout dan perpindahan halaman',
    overview:
        'Layout membantu menata elemen pada layar, sedangkan navigasi '
        'menghubungkan satu halaman dengan halaman lainnya.',
    keyPoints: [
      'Row menyusun widget secara horizontal.',
      'Column menyusun widget secara vertikal.',
      'Navigator dapat digunakan untuk membuka dan menutup halaman.',
    ],
  ),
];

class MaterialProgressState extends ChangeNotifier {
  MaterialProgressState()
    : _statuses = List<MaterialStatus>.filled(
        _learningMaterials.length,
        MaterialStatus.notStarted,
      ),
      _progress = List<double>.filled(_learningMaterials.length, 0);

  final List<MaterialStatus> _statuses;
  final List<double> _progress;

  MaterialStatus statusFor(int index) {
    RangeError.checkValidIndex(index, _statuses, 'index');
    return _statuses[index];
  }

  double progressFor(int index) {
    RangeError.checkValidIndex(index, _progress, 'index');
    return _progress[index];
  }

  bool isUnlocked(int index) {
    RangeError.checkValidIndex(index, _statuses, 'index');
    return index == 0 ||
        _statuses
            .take(index)
            .every((status) => status == MaterialStatus.mastered);
  }

  void setStatus(int index, MaterialStatus status, {double progress = 0}) {
    RangeError.checkValidIndex(index, _statuses, 'index');
    if (progress < 0 || progress > 1) {
      throw RangeError.range(progress, 0, 1, 'progress');
    }
    _statuses[index] = status;
    _progress[index] = status == MaterialStatus.inProgress ? progress : 0;
    notifyListeners();
  }

  void markMastered(int index) {
    setStatus(index, MaterialStatus.mastered);
  }

  void updateReadingProgress(int index, double progress) {
    RangeError.checkValidIndex(index, _progress, 'index');
    if (progress < 0 || progress > 1) {
      throw RangeError.range(progress, 0, 1, 'progress');
    }
    _progress[index] = progress;
    if (_statuses[index] != MaterialStatus.mastered) {
      _statuses[index] = MaterialStatus.inProgress;
    }
    notifyListeners();
  }
}

class MaterialsListScreen extends StatefulWidget {
  const MaterialsListScreen({super.key, this.progressState});

  final MaterialProgressState? progressState;

  @override
  State<MaterialsListScreen> createState() => _MaterialsListScreenState();
}

class _MaterialsListScreenState extends State<MaterialsListScreen> {
  late MaterialProgressState _progressState;
  late bool _ownsProgressState;

  @override
  void initState() {
    super.initState();
    _useProgressState(widget.progressState);
  }

  void _useProgressState(MaterialProgressState? progressState) {
    _ownsProgressState = progressState == null;
    _progressState = progressState ?? MaterialProgressState();
  }

  @override
  void didUpdateWidget(covariant MaterialsListScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.progressState != widget.progressState) {
      if (_ownsProgressState) _progressState.dispose();
      _useProgressState(widget.progressState);
    }
  }

  @override
  void dispose() {
    if (_ownsProgressState) _progressState.dispose();
    super.dispose();
  }

  void _openMaterial(
    BuildContext context,
    int index,
    LearningMaterial material,
  ) {
    if (!_progressState.isUnlocked(index)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Selesaikan dan kuasai materi sebelumnya terlebih dahulu.',
          ),
        ),
      );
      return;
    }
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => MaterialDetailScreen(
          material: material,
          materialIndex: index,
          progressState: _progressState,
          status: _progressState.statusFor(index),
          progress: _progressState.progressFor(index),
          onReadingProgressChanged: (progress) =>
              _progressState.updateReadingProgress(index, progress),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Daftar Materi',
          style: TextStyle(color: NivoApp.ink, fontWeight: FontWeight.w700),
        ),
        backgroundColor: const Color(0xFFF8FAFF),
        foregroundColor: NivoApp.ink,
      ),
      body: AnimatedBuilder(
        animation: _progressState,
        builder: (context, _) => Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 560),
            child: ListView(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 28),
              children: [
                const Text(
                  'Yuk pilih materi yang ingin kamu pelajari.',
                  style: TextStyle(
                    color: Color(0xFF64738B),
                    fontSize: 15,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 20),
                for (var index = 0; index < _learningMaterials.length; index++)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _LearningMaterialCard(
                      material: _learningMaterials[index],
                      number: index + 1,
                      status: _progressState.statusFor(index),
                      progress: _progressState.progressFor(index),
                      isUnlocked: _progressState.isUnlocked(index),
                      onTap: () => _openMaterial(
                        context,
                        index,
                        _learningMaterials[index],
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _LearningMaterialCard extends StatelessWidget {
  const _LearningMaterialCard({
    required this.material,
    required this.number,
    required this.status,
    required this.progress,
    required this.isUnlocked,
    required this.onTap,
  });

  final LearningMaterial material;
  final int number;
  final MaterialStatus status;
  final double progress;
  final bool isUnlocked;
  final VoidCallback onTap;

  String get _statusLabel => switch (status) {
    MaterialStatus.notStarted => 'Belum Dimulai',
    MaterialStatus.inProgress => 'Sedang Dipelajari',
    MaterialStatus.notMastered => 'Belum Dikuasai',
    MaterialStatus.mastered => 'Dikuasai',
  };

  Color get _statusColor => switch (status) {
    MaterialStatus.notStarted => const Color(0xFF77849A),
    MaterialStatus.inProgress => NivoApp.blue,
    MaterialStatus.notMastered => const Color(0xFFC47A22),
    MaterialStatus.mastered => const Color(0xFF22866F),
  };

  IconData get _statusIcon => switch (status) {
    MaterialStatus.notStarted => Icons.radio_button_unchecked_rounded,
    MaterialStatus.inProgress => Icons.play_circle_fill_rounded,
    MaterialStatus.notMastered => Icons.error_outline_rounded,
    MaterialStatus.mastered => Icons.check_circle_rounded,
  };

  @override
  Widget build(BuildContext context) {
    final locked = !isUnlocked;
    return Material(
      key: Key('material-card-$number'),
      color: locked ? const Color(0xFFF0F2F6) : Colors.white,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: locked ? const Color(0xFFE1E5EC) : const Color(0xFFDCE5FF),
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 46,
                height: 46,
                decoration: BoxDecoration(
                  color: locked
                      ? const Color(0xFFE5E8ED)
                      : const Color(0xFFEAF0FF),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Center(
                  child: Text(
                    number.toString().padLeft(2, '0'),
                    style: TextStyle(
                      color: locked ? const Color(0xFF8993A2) : NivoApp.blue,
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 13),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      material.subject,
                      style: const TextStyle(
                        color: Color(0xFF77849A),
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      material.title,
                      style: const TextStyle(
                        color: NivoApp.ink,
                        fontSize: 14,
                        height: 1.35,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Icon(_statusIcon, color: _statusColor, size: 16),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            _statusLabel,
                            style: TextStyle(
                              color: _statusColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Text(
                          locked ? 'Terkunci' : 'Terbuka',
                          style: TextStyle(
                            color: locked
                                ? const Color(0xFF77849A)
                                : NivoApp.blue,
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    if (status == MaterialStatus.inProgress) ...[
                      const SizedBox(height: 9),
                      Text(
                        '${(progress * 100).round()}%',
                        style: const TextStyle(
                          color: NivoApp.ink,
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 5),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: LinearProgressIndicator(
                          value: progress,
                          minHeight: 6,
                          backgroundColor: const Color(0xFFEAF0FF),
                          valueColor: AlwaysStoppedAnimation<Color>(
                            _statusColor,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(width: 6),
              Padding(
                padding: const EdgeInsets.only(top: 14),
                child: Icon(
                  locked ? Icons.lock_rounded : Icons.lock_open_rounded,
                  color: locked ? const Color(0xFF8993A2) : NivoApp.blue,
                  size: 20,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MaterialDetailScreen extends StatefulWidget {
  const MaterialDetailScreen({
    super.key,
    required this.material,
    this.materialIndex,
    this.progressState,
    this.initialSubtopicIndex,
    this.remedialSubtopicIndexes = const [],
    this.previouslyMasteredSubtopics = const [],
    this.status = MaterialStatus.notStarted,
    this.progress = 0,
    this.onReadingProgressChanged,
  });

  final LearningMaterial material;
  final int? materialIndex;
  final MaterialProgressState? progressState;
  final int? initialSubtopicIndex;
  final List<int> remedialSubtopicIndexes;
  final List<bool> previouslyMasteredSubtopics;
  final MaterialStatus status;
  final double progress;
  final ValueChanged<double>? onReadingProgressChanged;

  @override
  State<MaterialDetailScreen> createState() => _MaterialDetailScreenState();
}

class _MaterialDetailScreenState extends State<MaterialDetailScreen> {
  late final List<bool> _readSubtopics;
  late final List<GlobalKey> _subtopicKeys;

  @override
  void initState() {
    super.initState();
    _subtopicKeys = List<GlobalKey>.generate(
      widget.material.subtopics.length,
      (_) => GlobalKey(),
    );
    final initialReadCount =
        (widget.progress * widget.material.subtopics.length).round().clamp(
          0,
          widget.material.subtopics.length,
        );
    _readSubtopics = List<bool>.generate(
      widget.material.subtopics.length,
      (index) => index < initialReadCount,
    );
    final targetIndex = widget.initialSubtopicIndex;
    if (targetIndex != null &&
        targetIndex >= 0 &&
        targetIndex < widget.material.subtopics.length) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        final targetContext = _subtopicKeys[targetIndex].currentContext;
        if (targetContext != null) {
          Scrollable.ensureVisible(
            targetContext,
            duration: const Duration(milliseconds: 300),
            alignment: 0.18,
          );
        }
      });
    }
  }

  double get _readingProgress =>
      _readSubtopics.where((isRead) => isRead).length / _readSubtopics.length;

  void _setSubtopicRead(int index, bool isRead) {
    setState(() => _readSubtopics[index] = isRead);
    widget.onReadingProgressChanged?.call(_readingProgress);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Detail Materi',
          style: TextStyle(color: NivoApp.ink, fontWeight: FontWeight.w700),
        ),
        backgroundColor: const Color(0xFFF8FAFF),
        foregroundColor: NivoApp.ink,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 560),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  padding: const EdgeInsets.all(22),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: const Color(0xFFE9EEF7)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 54,
                        height: 54,
                        decoration: BoxDecoration(
                          color: const Color(0xFFEAF0FF),
                          borderRadius: BorderRadius.circular(17),
                        ),
                        child: const Icon(
                          Icons.code_rounded,
                          color: NivoApp.blue,
                          size: 29,
                        ),
                      ),
                      const SizedBox(height: 18),
                      Text(
                        widget.material.subject,
                        style: const TextStyle(
                          color: Color(0xFF77849A),
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        widget.material.title,
                        style: const TextStyle(
                          color: NivoApp.ink,
                          fontSize: 23,
                          height: 1.3,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 14),
                      _MaterialStatusSummary(
                        status: widget.status == MaterialStatus.mastered
                            ? MaterialStatus.mastered
                            : _readingProgress > 0
                            ? MaterialStatus.inProgress
                            : widget.status,
                        progress: _readingProgress,
                      ),
                      const SizedBox(height: 22),
                      Row(
                        children: [
                          const Expanded(
                            child: Text(
                              'Progress Membaca',
                              style: TextStyle(
                                color: NivoApp.ink,
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Text(
                            '${(_readingProgress * 100).round()}%',
                            key: const Key('reading-progress-label'),
                            style: const TextStyle(
                              color: NivoApp.blue,
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: LinearProgressIndicator(
                          key: const Key('reading-progress-bar'),
                          value: _readingProgress,
                          minHeight: 8,
                          backgroundColor: const Color(0xFFEAF0FF),
                          valueColor: const AlwaysStoppedAnimation<Color>(
                            NivoApp.blue,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                const _SectionLabel(title: 'Submateri'),
                const SizedBox(height: 12),
                for (
                  var index = 0;
                  index < widget.material.subtopics.length;
                  index++
                )
                  Padding(
                    key: _subtopicKeys[index],
                    padding: const EdgeInsets.only(bottom: 10),
                    child: _SubtopicCard(
                      key: Key('subtopic-card-$index'),
                      title: widget.material.subtopics[index],
                      isRead: _readSubtopics[index],
                      onChanged: (value) => _setSubtopicRead(index, value),
                    ),
                  ),
                const SizedBox(height: 14),
                _ContentCard(
                  heading: widget.material.overviewHeading,
                  paragraph: widget.material.overview,
                  keyPoints: widget.material.keyPoints,
                ),
                const SizedBox(height: 28),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.fromLTRB(20, 10, 20, 16),
        child: widget.remedialSubtopicIndexes.isEmpty
            ? SizedBox(
                height: 54,
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 520),
                    child: SizedBox(
                      width: double.infinity,
                      height: 54,
                      child: _buildRegularEvaluationButton(),
                    ),
                  ),
                ),
              )
            : Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 520),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        width: double.infinity,
                        height: 52,
                        child: OutlinedButton.icon(
                          key: const Key('start-remedial-evaluation'),
                          onPressed: _startRemedialEvaluation,
                          icon: const Icon(Icons.replay_rounded),
                          label: const Text('Mulai Evaluasi Remedial'),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: NivoApp.blue,
                            side: const BorderSide(color: Color(0xFFDCE5FF)),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            textStyle: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      SizedBox(
                        width: double.infinity,
                        height: 54,
                        child: _buildRegularEvaluationButton(),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  Widget _buildRegularEvaluationButton() {
    return FilledButton.icon(
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute<void>(
            builder: (_) => EvaluationScreen(
              material: widget.material,
              materialIndex: widget.materialIndex,
              progressState: widget.progressState,
            ),
          ),
        );
      },
      icon: const Icon(Icons.quiz_outlined),
      label: const Text('Mulai Evaluasi'),
      style: FilledButton.styleFrom(
        backgroundColor: NivoApp.blue,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      ),
    );
  }

  void _startRemedialEvaluation() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => RemedialEvaluationScreen(
          material: widget.material,
          selectedSubtopicIndexes: widget.remedialSubtopicIndexes,
          materialIndex: widget.materialIndex,
          progressState: widget.progressState,
          previouslyMasteredSubtopics: widget.previouslyMasteredSubtopics,
        ),
      ),
    );
  }
}

class _SubtopicCard extends StatelessWidget {
  const _SubtopicCard({
    super.key,
    required this.title,
    required this.isRead,
    required this.onChanged,
  });

  final String title;
  final bool isRead;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      checked: isRead,
      label: title,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => onChanged(!isRead),
        child: Material(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: const Color(0xFFE9EEF7)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      color: NivoApp.ink,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Icon(
                  isRead
                      ? Icons.check_circle_rounded
                      : Icons.radio_button_unchecked_rounded,
                  color: isRead ? NivoApp.blue : const Color(0xFF9AA6B8),
                  size: 22,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ContentCard extends StatelessWidget {
  const _ContentCard({
    required this.heading,
    required this.paragraph,
    required this.keyPoints,
  });

  final String heading;
  final String paragraph;
  final List<String> keyPoints;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: const Color(0xFFE9EEF7)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            heading,
            style: const TextStyle(
              color: NivoApp.ink,
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            paragraph,
            style: const TextStyle(
              color: Color(0xFF64738B),
              fontSize: 14,
              height: 1.6,
            ),
          ),
          const SizedBox(height: 18),
          const Text(
            'Poin penting',
            style: TextStyle(
              color: NivoApp.ink,
              fontSize: 15,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 10),
          for (final point in keyPoints)
            Padding(
              padding: const EdgeInsets.only(bottom: 9),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 7),
                    child: Icon(Icons.circle, color: NivoApp.mint, size: 8),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      point,
                      style: const TextStyle(
                        color: Color(0xFF64738B),
                        fontSize: 14,
                        height: 1.5,
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class EvaluationQuestion {
  const EvaluationQuestion({
    required this.prompt,
    required this.options,
    required this.correctOption,
  });

  final String prompt;
  final List<String> options;
  final int correctOption;
}

const List<EvaluationQuestion> _evaluationQuestions = [
  EvaluationQuestion(
    prompt: 'Apa fungsi utama Flutter?',
    options: [
      'Membuat antarmuka aplikasi dari satu basis kode',
      'Mengelola server database',
      'Menggantikan sistem operasi ponsel',
      'Membuat desain perangkat keras',
    ],
    correctOption: 0,
  ),
  EvaluationQuestion(
    prompt: 'Bahasa pemrograman yang umum digunakan untuk Flutter adalah …',
    options: ['Java', 'Dart', 'Swift', 'Kotlin'],
    correctOption: 1,
  ),
  EvaluationQuestion(
    prompt: 'Apa yang dimaksud dengan widget di Flutter?',
    options: [
      'Komponen penyusun antarmuka aplikasi',
      'Jenis koneksi internet',
      'File untuk menyimpan gambar saja',
      'Perangkat untuk menjalankan emulator',
    ],
    correctOption: 0,
  ),
  EvaluationQuestion(
    prompt: 'Widget yang cocok untuk menampilkan teks adalah …',
    options: ['Text', 'ScaffoldMessenger', 'Navigator', 'MaterialApp'],
    correctOption: 0,
  ),
  EvaluationQuestion(
    prompt: 'Widget untuk menyusun beberapa elemen secara vertikal adalah …',
    options: ['Row', 'Stack', 'Column', 'Wrap'],
    correctOption: 2,
  ),
  EvaluationQuestion(
    prompt: 'Apa kegunaan utama StatefulWidget?',
    options: [
      'Menampilkan gambar statis saja',
      'Mengelola tampilan yang dapat berubah mengikuti state',
      'Membuat folder project baru',
      'Menghubungkan ponsel ke internet',
    ],
    correctOption: 1,
  ),
  EvaluationQuestion(
    prompt: 'Perintah untuk meminta Flutter membangun ulang UI setelah state berubah adalah …',
    options: ['rebuildNow()', 'refresh()', 'setState()', 'updateWidget()'],
    correctOption: 2,
  ),
  EvaluationQuestion(
    prompt: 'Widget Scaffold biasanya menyediakan struktur dasar untuk …',
    options: [
      'Satu halaman aplikasi Material',
      'Menyimpan data ke cloud',
      'Mengompilasi bahasa Dart',
      'Mengatur izin perangkat',
    ],
    correctOption: 0,
  ),
  EvaluationQuestion(
    prompt: 'Apa fungsi Navigator dalam aplikasi Flutter?',
    options: [
      'Mengubah ukuran teks',
      'Berpindah antarhalaman',
      'Membuat ikon aplikasi',
      'Menghitung nilai evaluasi',
    ],
    correctOption: 1,
  ),
  EvaluationQuestion(
    prompt:
        'File yang umumnya menjadi titik awal kode aplikasi Flutter adalah …',
    options: [
      'pubspec.yaml',
      'README.md',
      'main.dart',
      'analysis_options.yaml',
    ],
    correctOption: 2,
  ),
];

class RemedialQuestion extends EvaluationQuestion {
  const RemedialQuestion({
    required this.subtopicIndex,
    required super.prompt,
    required super.options,
    required super.correctOption,
  });

  final int subtopicIndex;
}

const List<List<RemedialQuestion>> _remedialQuestionBanks = [
  [
    RemedialQuestion(
      subtopicIndex: 0,
      prompt: 'Apa keuntungan utama memakai satu project Flutter untuk Android dan iOS?',
      options: [
        'Sebagian besar kode aplikasi dapat digunakan bersama',
        'Aplikasi tidak perlu diuji',
        'Semua perangkat memakai ukuran layar yang sama',
        'Flutter menghapus kebutuhan bahasa pemrograman',
      ],
      correctOption: 0,
    ),
    RemedialQuestion(
      subtopicIndex: 0,
      prompt: 'Saat Flutter menggambar ulang tampilan, bagian UI biasanya tersusun dari apa?',
      options: ['Widget', 'Tabel database', 'Alamat jaringan', 'File audio'],
      correctOption: 0,
    ),
    RemedialQuestion(
      subtopicIndex: 0,
      prompt: 'Apa peran bahasa Dart dalam pengembangan aplikasi Flutter?',
      options: [
        'Menulis logika dan antarmuka aplikasi',
        'Menggantikan layar sentuh',
        'Mengatur koneksi seluler perangkat',
        'Mendesain komponen fisik ponsel',
      ],
      correctOption: 0,
    ),
    RemedialQuestion(
      subtopicIndex: 0,
      prompt:
          'Fitur Hot Reload paling berguna untuk apa saat mengembangkan UI?',
      options: [
        'Melihat perubahan kode dengan cepat tanpa memulai ulang dari awal',
        'Menghapus seluruh state aplikasi',
        'Menerbitkan aplikasi ke toko secara otomatis',
        'Mengunduh package tanpa jaringan',
      ],
      correctOption: 0,
    ),
    RemedialQuestion(
      subtopicIndex: 0,
      prompt: 'Pernyataan yang tepat tentang widget Flutter adalah …',
      options: [
        'Widget dapat mewakili elemen tampilan maupun pengaturan layout',
        'Widget hanya digunakan untuk menyimpan kata sandi',
        'Widget adalah nama lain untuk emulator',
        'Widget hanya dapat berisi gambar',
      ],
      correctOption: 0,
    ),
    RemedialQuestion(
      subtopicIndex: 0,
      prompt: 'Apa yang dilakukan method build pada sebuah widget?',
      options: [
        'Mendeskripsikan widget yang perlu ditampilkan',
        'Menginstal aplikasi ke Play Store',
        'Membuat akun pengguna',
        'Menghapus folder project',
      ],
      correctOption: 0,
    ),
    RemedialQuestion(
      subtopicIndex: 0,
      prompt: 'Mengapa satu widget sering disusun di dalam widget lain?',
      options: [
        'Untuk membentuk antarmuka secara bertingkat dan teratur',
        'Agar aplikasi tidak memiliki tampilan',
        'Untuk menghindari penggunaan Dart',
        'Agar semua tombol otomatis aktif',
      ],
      correctOption: 0,
    ),
    RemedialQuestion(
      subtopicIndex: 0,
      prompt: 'Flutter paling tepat digambarkan sebagai …',
      options: [
        'Toolkit untuk membangun antarmuka aplikasi',
        'Sistem operasi khusus untuk server',
        'Bahasa markup untuk halaman web saja',
        'Perangkat keras untuk ponsel',
      ],
      correctOption: 0,
    ),
    RemedialQuestion(
      subtopicIndex: 0,
      prompt: 'Apa yang dimaksud dengan UI pada aplikasi?',
      options: [
        'Bagian antarmuka yang dilihat dan digunakan pengguna',
        'Daftar package yang diunduh',
        'Proses pengisian baterai',
        'Sistem berkas perangkat',
      ],
      correctOption: 0,
    ),
    RemedialQuestion(
      subtopicIndex: 0,
      prompt: 'Ketika sebuah widget berisi ikon, teks, dan tombol, hal itu menunjukkan bahwa …',
      options: [
        'Widget dapat dikombinasikan untuk menyusun tampilan',
        'Satu layar hanya boleh memiliki satu elemen',
        'Ikon harus dibuat sebagai database',
        'Tombol tidak dapat menjadi bagian UI',
      ],
      correctOption: 0,
    ),
  ],
  [
    RemedialQuestion(
      subtopicIndex: 1,
      prompt: 'File mana yang mencatat dependency dan konfigurasi package project Flutter?',
      options: ['pubspec.yaml', 'main.dart', 'README.md', 'gradlew'],
      correctOption: 0,
    ),
    RemedialQuestion(
      subtopicIndex: 1,
      prompt: 'Di folder mana kode Dart aplikasi umumnya diletakkan?',
      options: ['lib', 'build', '.git', 'gradle'],
      correctOption: 0,
    ),
    RemedialQuestion(
      subtopicIndex: 1,
      prompt: 'Apa kegunaan folder test pada project Flutter?',
      options: [
        'Menyimpan pengujian kode aplikasi',
        'Menyimpan ikon launcher saja',
        'Mengatur resolusi layar emulator',
        'Mencatat akun toko aplikasi',
      ],
      correctOption: 0,
    ),
    RemedialQuestion(
      subtopicIndex: 1,
      prompt: 'Setelah menambahkan package ke pubspec.yaml, perintah apa yang mengambil dependency?',
      options: [
        'flutter pub get',
        'flutter clean all',
        'dart remove app',
        'flutter screen',
      ],
      correctOption: 0,
    ),
    RemedialQuestion(
      subtopicIndex: 1,
      prompt: 'Di bagian mana asset gambar biasanya didaftarkan?',
      options: [
        'Bagian assets pada pubspec.yaml',
        'Di dalam nama class utama',
        'Pada file README saja',
        'Di folder build secara manual',
      ],
      correctOption: 0,
    ),
    RemedialQuestion(
      subtopicIndex: 1,
      prompt: 'Apa tujuan file README.md dalam sebuah project?',
      options: [
        'Memberi dokumentasi atau petunjuk penggunaan project',
        'Menjalankan fungsi build aplikasi',
        'Mendeklarasikan semua widget',
        'Menyimpan hasil input pengguna',
      ],
      correctOption: 0,
    ),
    RemedialQuestion(
      subtopicIndex: 1,
      prompt: 'Folder android pada project Flutter berisi …',
      options: [
        'Konfigurasi khusus platform Android',
        'Seluruh widget antarmuka Dart',
        'Semua soal evaluasi',
        'Dokumentasi package Dart',
      ],
      correctOption: 0,
    ),
    RemedialQuestion(
      subtopicIndex: 1,
      prompt: 'Mengapa perubahan dependency sebaiknya dicatat di pubspec.yaml?',
      options: [
        'Agar konfigurasi package project dapat diketahui dan dikelola',
        'Agar ukuran teks otomatis berubah',
        'Agar aplikasi tidak perlu dikompilasi',
        'Agar route dibuat tanpa kode',
      ],
      correctOption: 0,
    ),
    RemedialQuestion(
      subtopicIndex: 1,
      prompt: 'File Dart biasanya menggunakan ekstensi …',
      options: ['.dart', '.yaml', '.png', '.gradle'],
      correctOption: 0,
    ),
    RemedialQuestion(
      subtopicIndex: 1,
      prompt: 'Apa manfaat memisahkan kode sumber dan file hasil build?',
      options: [
        'Kode yang ditulis pengembang lebih mudah dikelola',
        'Aplikasi tidak lagi memerlukan project',
        'Semua konfigurasi platform hilang',
        'Widget dapat berjalan tanpa kompilasi',
      ],
      correctOption: 0,
    ),
  ],
  [
    RemedialQuestion(
      subtopicIndex: 2,
      prompt:
          'Widget apa yang umum dipakai untuk menata anak secara horizontal?',
      options: ['Row', 'Column', 'Scaffold', 'MaterialApp'],
      correctOption: 0,
    ),
    RemedialQuestion(
      subtopicIndex: 2,
      prompt: 'Jika data pada layar berubah setelah pengguna menekan tombol, widget apa yang sesuai?',
      options: ['StatefulWidget', 'StatelessWidget saja', 'Icon', 'Padding'],
      correctOption: 0,
    ),
    RemedialQuestion(
      subtopicIndex: 2,
      prompt: 'Apa fungsi Navigator dalam alur aplikasi?',
      options: [
        'Mendorong atau menutup halaman pada stack navigasi',
        'Mengatur warna setiap piksel',
        'Menyimpan file gambar',
        'Memeriksa versi Dart',
      ],
      correctOption: 0,
    ),
    RemedialQuestion(
      subtopicIndex: 2,
      prompt: 'Widget apa yang memberi jarak di sekeliling anaknya?',
      options: ['Padding', 'Text', 'Icon', 'Navigator'],
      correctOption: 0,
    ),
    RemedialQuestion(
      subtopicIndex: 2,
      prompt: 'Untuk menyusun elemen dari atas ke bawah, pilih widget …',
      options: ['Column', 'Row', 'Positioned', 'AppBar'],
      correctOption: 0,
    ),
    RemedialQuestion(
      subtopicIndex: 2,
      prompt: 'Method apa yang lazim dipanggil untuk memperbarui state lokal StatefulWidget?',
      options: ['setState()', 'pushRoute()', 'buildAgain()', 'saveWidget()'],
      correctOption: 0,
    ),
    RemedialQuestion(
      subtopicIndex: 2,
      prompt: 'Apa peran Scaffold dalam layar bergaya Material?',
      options: [
        'Menyediakan kerangka halaman seperti body dan app bar',
        'Mendefinisikan dependency package',
        'Menyimpan daftar pengguna',
        'Mengubah kode Dart menjadi gambar',
      ],
      correctOption: 0,
    ),
    RemedialQuestion(
      subtopicIndex: 2,
      prompt: 'Widget yang merespons ketukan pengguna dengan callback sederhana adalah …',
      options: ['ElevatedButton', 'SizedBox', 'Divider', 'SafeArea'],
      correctOption: 0,
    ),
    RemedialQuestion(
      subtopicIndex: 2,
      prompt: 'Mengapa ListView cocok untuk daftar yang panjang?',
      options: [
        'Kontennya dapat digulir ketika melebihi ruang layar',
        'ListView otomatis menguasai materi',
        'ListView mengganti seluruh route aplikasi',
        'ListView menghapus item setelah dibaca',
      ],
      correctOption: 0,
    ),
    RemedialQuestion(
      subtopicIndex: 2,
      prompt: 'Jika beberapa widget harus berbagi ruang secara fleksibel di Row, widget apa yang dapat membungkusnya?',
      options: ['Expanded', 'IconButton', 'AppBar', 'SpacerText'],
      correctOption: 0,
    ),
  ],
];

class EvaluationScreen extends StatefulWidget {
  const EvaluationScreen({
    super.key,
    required this.material,
    this.materialIndex,
    this.progressState,
  });

  final LearningMaterial material;
  final int? materialIndex;
  final MaterialProgressState? progressState;

  @override
  State<EvaluationScreen> createState() => _EvaluationScreenState();
}

class _EvaluationScreenState extends State<EvaluationScreen> {
  int _questionIndex = 0;
  int? _selectedOption;
  final List<int?> _answers = List<int?>.filled(
    _evaluationQuestions.length,
    null,
  );
  bool _isComplete = false;

  int get _correctAnswers => _answers
      .asMap()
      .entries
      .where(
        (entry) => entry.value == _evaluationQuestions[entry.key].correctOption,
      )
      .length;

  int _correctAnswersInRange(int start, int end) => _answers
      .asMap()
      .entries
      .where(
        (entry) =>
            entry.key >= start &&
            entry.key < end &&
            entry.value == _evaluationQuestions[entry.key].correctOption,
      )
      .length;

  List<bool> get _subtopicMastery => const [(0, 3), (3, 6), (6, 10)]
      .map(
        (range) =>
            _correctAnswersInRange(range.$1, range.$2) >
            (range.$2 - range.$1) / 2,
      )
      .toList(growable: false);

  void _continue() {
    if (_selectedOption == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Pilih jawaban terlebih dahulu.')),
      );
      return;
    }

    _answers[_questionIndex] = _selectedOption;
    if (_questionIndex == _evaluationQuestions.length - 1) {
      setState(() => _isComplete = true);
      return;
    }

    setState(() {
      _questionIndex++;
      _selectedOption = _answers[_questionIndex];
    });
  }

  void _returnToMaterials() {
    Navigator.of(
      context,
    ).popUntil((route) => route.isFirst || route.settings.name == '/materials');
  }

  @override
  Widget build(BuildContext context) {
    if (_isComplete) return _buildResult(context);

    final question = _evaluationQuestions[_questionIndex];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Evaluasi',
          style: TextStyle(color: NivoApp.ink, fontWeight: FontWeight.w700),
        ),
        backgroundColor: const Color(0xFFF8FAFF),
        foregroundColor: NivoApp.ink,
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 560),
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          widget.material.title,
                          style: const TextStyle(
                            color: Color(0xFF64738B),
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Soal ${_questionIndex + 1} dari ${_evaluationQuestions.length}',
                                key: const Key('question-counter'),
                                style: const TextStyle(
                                  color: NivoApp.ink,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            Text(
                              '${((_questionIndex + 1) / _evaluationQuestions.length * 100).round()}%',
                              style: const TextStyle(
                                color: NivoApp.blue,
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: LinearProgressIndicator(
                            value:
                                (_questionIndex + 1) /
                                _evaluationQuestions.length,
                            minHeight: 8,
                            backgroundColor: const Color(0xFFEAF0FF),
                            valueColor: const AlwaysStoppedAnimation<Color>(
                              NivoApp.blue,
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                        Container(
                          padding: const EdgeInsets.all(22),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(24),
                            border: Border.all(color: const Color(0xFFE9EEF7)),
                          ),
                          child: Text(
                            question.prompt,
                            style: const TextStyle(
                              color: NivoApp.ink,
                              fontSize: 20,
                              height: 1.4,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        for (
                          var optionIndex = 0;
                          optionIndex < question.options.length;
                          optionIndex++
                        )
                          Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: _AnswerOptionCard(
                              key: Key('evaluation-option-$optionIndex'),
                              label: String.fromCharCode(65 + optionIndex),
                              text: question.options[optionIndex],
                              isSelected: _selectedOption == optionIndex,
                              onTap: () =>
                                  setState(() => _selectedOption = optionIndex),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
                  child: SizedBox(
                    width: double.infinity,
                    height: 54,
                    child: FilledButton(
                      onPressed: _continue,
                      style: FilledButton.styleFrom(
                        backgroundColor: NivoApp.blue,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        textStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      child: const Text('Lanjut'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildResult(BuildContext context) {
    final score = (_correctAnswers / _evaluationQuestions.length * 100).round();
    final isMastered = score >= 75;
    final subtopicRanges = [(0, 3), (3, 6), (6, 10)];
    final subtopicMastery = _subtopicMastery;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Hasil Evaluasi',
          style: TextStyle(color: NivoApp.ink, fontWeight: FontWeight.w700),
        ),
        backgroundColor: const Color(0xFFF8FAFF),
        foregroundColor: NivoApp.ink,
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 460),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: const Color(0xFFE9EEF7)),
                ),
                child: Column(
                  children: [
                    Container(
                      width: 72,
                      height: 72,
                      decoration: BoxDecoration(
                        color: const Color(0xFFEAF0FF),
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: const Icon(
                        Icons.emoji_events_rounded,
                        color: NivoApp.blue,
                        size: 38,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Evaluasi Selesai',
                      style: TextStyle(
                        color: NivoApp.ink,
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      widget.material.title,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Color(0xFF64738B),
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      '$_correctAnswers dari ${_evaluationQuestions.length} jawaban benar',
                      key: const Key('evaluation-correct-count'),
                      style: const TextStyle(
                        color: NivoApp.ink,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      '$score/100',
                      key: const Key('evaluation-score-out-of-100'),
                      style: const TextStyle(
                        color: NivoApp.ink,
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '$score%',
                      key: const Key('evaluation-score'),
                      style: const TextStyle(
                        color: NivoApp.blue,
                        fontSize: 42,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: isMastered
                            ? const Color(0xFFE5F6F0)
                            : const Color(0xFFFFF2E2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        isMastered ? 'Dikuasai' : 'Belum Menguasai',
                        key: const Key('overall-mastery-status'),
                        style: TextStyle(
                          color: isMastered
                              ? const Color(0xFF22866F)
                              : const Color(0xFFAA681D),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    const SizedBox(height: 14),
                    Text(
                      isMastered
                          ? 'Hebat! Kamu berhasil menguasai materi ini. '
                                'Lanjutkan ke materi berikutnya.'
                          : 'Terus semangat! Pelajari kembali materi dan '
                                'submateri yang belum dikuasai, lalu coba lagi.',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Color(0xFF64738B),
                        fontSize: 14,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Penguasaan Submateri',
                        style: const TextStyle(
                          color: NivoApp.ink,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    for (
                      var index = 0;
                      index < widget.material.subtopics.length;
                      index++
                    )
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: _SubtopicMasteryResult(
                          title: widget.material.subtopics[index],
                          isMastered: subtopicMastery[index],
                          correctAnswers: _correctAnswersInRange(
                            subtopicRanges[index].$1,
                            subtopicRanges[index].$2,
                          ),
                          totalQuestions:
                              subtopicRanges[index].$2 -
                              subtopicRanges[index].$1,
                        ),
                      ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: FilledButton(
                        key: const Key('evaluation-primary-result-action'),
                        onPressed: () {
                          if (isMastered) {
                            final progressState = widget.progressState;
                            final materialIndex = widget.materialIndex;
                            if (progressState != null &&
                                materialIndex != null) {
                              progressState.markMastered(materialIndex);
                            }
                            _returnToMaterials();
                          } else {
                            Navigator.of(context).push(
                              MaterialPageRoute<void>(
                                settings: const RouteSettings(
                                  name: '/review-recommendations',
                                ),
                                builder: (_) => ReviewRecommendationsScreen(
                                  material: widget.material,
                                  masteredSubtopics: subtopicMastery,
                                  materialIndex: widget.materialIndex,
                                  progressState: widget.progressState,
                                ),
                              ),
                            );
                          }
                        },
                        style: FilledButton.styleFrom(
                          backgroundColor: NivoApp.blue,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: Text(
                          isMastered
                              ? 'Lanjut ke Materi Berikutnya'
                              : 'Pelajari Kembali',
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: OutlinedButton(
                        onPressed: isMastered
                            ? () => Navigator.of(context).pop()
                            : _returnToMaterials,
                        style: OutlinedButton.styleFrom(
                          foregroundColor: NivoApp.blue,
                          side: const BorderSide(color: Color(0xFFDCE5FF)),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: Text(
                          isMastered
                              ? 'Kembali ke Detail Materi'
                              : 'Kembali ke Daftar Materi',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

List<RemedialQuestion> _buildRemedialQuestions(
  List<int> selectedSubtopicIndexes,
) {
  if (selectedSubtopicIndexes.isEmpty) {
    throw ArgumentError.value(
      selectedSubtopicIndexes,
      'selectedSubtopicIndexes',
      'At least one subtopic must be selected.',
    );
  }
  final selectedIndexes = selectedSubtopicIndexes.toSet().toList();
  for (final index in selectedIndexes) {
    RangeError.checkValueInInterval(
      index,
      0,
      _remedialQuestionBanks.length - 1,
    );
  }

  final bankOffsets = List<int>.filled(_remedialQuestionBanks.length, 0);
  return List<RemedialQuestion>.generate(10, (questionIndex) {
    final bankIndex = selectedIndexes[questionIndex % selectedIndexes.length];
    final question = _remedialQuestionBanks[bankIndex][bankOffsets[bankIndex]];
    bankOffsets[bankIndex]++;
    final answerOffset = (questionIndex * 3 + 1) % question.options.length;
    return RemedialQuestion(
      subtopicIndex: question.subtopicIndex,
      prompt: question.prompt,
      options: List<String>.generate(
        question.options.length,
        (optionIndex) =>
            question.options[(optionIndex -
                    answerOffset +
                    question.options.length) %
                question.options.length],
        growable: false,
      ),
      correctOption:
          (question.correctOption + answerOffset) % question.options.length,
    );
  }, growable: false);
}

class RemedialEvaluationScreen extends StatefulWidget {
  const RemedialEvaluationScreen({
    super.key,
    required this.material,
    required this.selectedSubtopicIndexes,
    this.materialIndex,
    this.progressState,
    this.previouslyMasteredSubtopics = const [],
  });

  final LearningMaterial material;
  final List<int> selectedSubtopicIndexes;
  final int? materialIndex;
  final MaterialProgressState? progressState;
  final List<bool> previouslyMasteredSubtopics;

  @override
  State<RemedialEvaluationScreen> createState() =>
      _RemedialEvaluationScreenState();
}

class _RemedialEvaluationScreenState extends State<RemedialEvaluationScreen> {
  late final List<RemedialQuestion> _questions;
  final List<int?> _answers = List<int?>.filled(10, null);
  int _questionIndex = 0;
  int? _selectedOption;
  bool _isComplete = false;

  int get _correctAnswers => _answers
      .asMap()
      .entries
      .where((entry) => entry.value == _questions[entry.key].correctOption)
      .length;

  @override
  void initState() {
    super.initState();
    _questions = _buildRemedialQuestions(widget.selectedSubtopicIndexes);
  }

  void _continue() {
    if (_selectedOption == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Pilih jawaban terlebih dahulu.')),
      );
      return;
    }

    _answers[_questionIndex] = _selectedOption;
    if (_questionIndex == _questions.length - 1) {
      final score = (_correctAnswers / _questions.length * 100).round();
      if (score >= 75 &&
          widget.materialIndex != null &&
          widget.progressState != null) {
        widget.progressState!.markMastered(widget.materialIndex!);
      }
      setState(() => _isComplete = true);
      return;
    }
    setState(() {
      _questionIndex++;
      _selectedOption = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isComplete) return _buildResult();
    final question = _questions[_questionIndex];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Evaluasi Remedial',
          style: TextStyle(color: NivoApp.ink, fontWeight: FontWeight.w700),
        ),
        backgroundColor: const Color(0xFFF8FAFF),
        foregroundColor: NivoApp.ink,
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 560),
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          widget.material.title,
                          style: const TextStyle(
                            color: Color(0xFF64738B),
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Soal untuk menguji kembali submateri yang perlu dikuasai.',
                          key: Key('remedial-description'),
                          style: TextStyle(
                            color: Color(0xFF64738B),
                            fontSize: 14,
                            height: 1.45,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: widget.selectedSubtopicIndexes
                              .toSet()
                              .map(
                                (index) => Chip(
                                  key: Key('remedial-selected-topic-$index'),
                                  label: Text(widget.material.subtopics[index]),
                                  backgroundColor: const Color(0xFFEAF0FF),
                                  labelStyle: const TextStyle(
                                    color: NivoApp.blue,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Soal ${_questionIndex + 1} dari ${_questions.length}',
                                key: const Key('remedial-question-counter'),
                                style: const TextStyle(
                                  color: NivoApp.ink,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            Text(
                              '${((_questionIndex + 1) / _questions.length * 100).round()}%',
                              style: const TextStyle(
                                color: NivoApp.blue,
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: LinearProgressIndicator(
                            key: const Key('remedial-progress-bar'),
                            value: (_questionIndex + 1) / _questions.length,
                            minHeight: 8,
                            backgroundColor: const Color(0xFFEAF0FF),
                            valueColor: const AlwaysStoppedAnimation<Color>(
                              NivoApp.blue,
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                        Container(
                          padding: const EdgeInsets.all(22),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(24),
                            border: Border.all(color: const Color(0xFFE9EEF7)),
                          ),
                          child: Text(
                            question.prompt,
                            key: const Key('remedial-question-prompt'),
                            style: const TextStyle(
                              color: NivoApp.ink,
                              fontSize: 20,
                              height: 1.4,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        for (
                          var optionIndex = 0;
                          optionIndex < question.options.length;
                          optionIndex++
                        )
                          Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: _AnswerOptionCard(
                              key: Key('remedial-option-$optionIndex'),
                              label: String.fromCharCode(65 + optionIndex),
                              text: question.options[optionIndex],
                              isSelected: _selectedOption == optionIndex,
                              onTap: () =>
                                  setState(() => _selectedOption = optionIndex),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
                  child: SizedBox(
                    width: double.infinity,
                    height: 54,
                    child: FilledButton(
                      onPressed: _continue,
                      style: FilledButton.styleFrom(
                        backgroundColor: NivoApp.blue,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        textStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      child: const Text('Lanjut'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildResult() {
    final score = (_correctAnswers / _questions.length * 100).round();
    final isMastered = score >= 75;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Hasil Remedial',
          style: TextStyle(color: NivoApp.ink, fontWeight: FontWeight.w700),
        ),
        backgroundColor: const Color(0xFFF8FAFF),
        foregroundColor: NivoApp.ink,
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 460),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: const Color(0xFFE9EEF7)),
                ),
                child: Column(
                  children: [
                    const Icon(
                      Icons.replay_circle_filled_rounded,
                      color: NivoApp.blue,
                      size: 52,
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Remedial Selesai',
                      style: TextStyle(
                        color: NivoApp.ink,
                        fontSize: 23,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      '$_correctAnswers dari ${_questions.length} jawaban benar',
                      key: const Key('remedial-correct-count'),
                      style: const TextStyle(
                        color: Color(0xFF64738B),
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '$score/100',
                      key: const Key('remedial-score'),
                      style: const TextStyle(
                        color: NivoApp.blue,
                        fontSize: 36,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 22),
                    const SizedBox(height: 12),
                    Text(
                      '$score%',
                      key: const Key('remedial-percentage'),
                      style: const TextStyle(
                        color: Color(0xFF64738B),
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      key: const Key('remedial-overall-status'),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 9,
                      ),
                      decoration: BoxDecoration(
                        color: isMastered
                            ? const Color(0xFFE5F6F0)
                            : const Color(0xFFFFF2E2),
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Text(
                        isMastered
                            ? 'Materi berhasil dikuasai'
                            : 'Materi masih perlu dipelajari kembali',
                        style: TextStyle(
                          color: isMastered
                              ? const Color(0xFF22866F)
                              : const Color(0xFFAA681D),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      isMastered ? 'Materi berikutnya telah terbuka.' : 'Tinjau kembali submateri yang masih belum dikuasai.',
                      key: const Key('remedial-follow-up-message'),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Color(0xFF64738B),
                        fontSize: 14,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Status Submateri',
                        style: const TextStyle(
                          color: NivoApp.ink,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    for (
                      var index = 0;
                      index < widget.material.subtopics.length;
                      index++
                    )
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: _SubtopicMasteryResult(
                          title: widget.material.subtopics[index],
                          isMastered: _isSubtopicMastered(index),
                          correctAnswers: _subtopicCorrectAnswers(index),
                          totalQuestions: _subtopicQuestionCount(index),
                          notMasteredLabel: 'Perlu Dipelajari Kembali',
                        ),
                      ),
                    const SizedBox(height: 14),
                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: FilledButton(
                        key: const Key('remedial-result-continue'),
                        onPressed: isMastered
                            ? _returnToMaterials
                            : _returnToRecommendations,
                        style: FilledButton.styleFrom(
                          backgroundColor: NivoApp.blue,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: const Text('Lanjut ke Daftar Materi'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  int _subtopicCorrectAnswers(int subtopicIndex) {
    return _answers.asMap().entries.where((entry) {
      final question = _questions[entry.key];
      return question.subtopicIndex == subtopicIndex &&
          entry.value == question.correctOption;
    }).length;
  }

  int _subtopicQuestionCount(int subtopicIndex) => _questions
      .where((question) => question.subtopicIndex == subtopicIndex)
      .length;

  bool _isSubtopicMastered(int subtopicIndex) {
    final total = _subtopicQuestionCount(subtopicIndex);
    if (total == 0) {
      return subtopicIndex < widget.previouslyMasteredSubtopics.length &&
          widget.previouslyMasteredSubtopics[subtopicIndex];
    }
    return _subtopicCorrectAnswers(subtopicIndex) > total / 2;
  }

  void _returnToMaterials() {
    Navigator.of(
      context,
    ).popUntil((route) => route.isFirst || route.settings.name == '/materials');
  }

  void _returnToRecommendations() {
    final updatedMastery = List<bool>.generate(
      widget.material.subtopics.length,
      _isSubtopicMastered,
    );
    final navigator = Navigator.of(context);
    navigator.popUntil(
      (route) =>
          route.isFirst || route.settings.name == '/review-recommendations',
    );
    navigator.pushReplacement(
      MaterialPageRoute<void>(
        settings: const RouteSettings(name: '/review-recommendations'),
        builder: (_) => ReviewRecommendationsScreen(
          material: widget.material,
          masteredSubtopics: updatedMastery,
          materialIndex: widget.materialIndex,
          progressState: widget.progressState,
        ),
      ),
    );
  }
}

class ReviewRecommendationsScreen extends StatelessWidget {
  const ReviewRecommendationsScreen({
    super.key,
    required this.material,
    required this.masteredSubtopics,
    this.materialIndex,
    this.progressState,
  }) : assert(masteredSubtopics.length == 3);

  final LearningMaterial material;
  final List<bool> masteredSubtopics;
  final int? materialIndex;
  final MaterialProgressState? progressState;

  void _openSubtopic(BuildContext context, int index) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => MaterialDetailScreen(
          material: material,
          materialIndex: materialIndex,
          progressState: progressState,
          status: materialIndex != null && progressState != null
              ? progressState!.statusFor(materialIndex!)
              : MaterialStatus.notStarted,
          progress: materialIndex != null && progressState != null
              ? progressState!.progressFor(materialIndex!)
              : 0,
          initialSubtopicIndex: index,
          remedialSubtopicIndexes: [index],
          previouslyMasteredSubtopics: List<bool>.of(masteredSubtopics),
          onReadingProgressChanged:
              materialIndex != null && progressState != null
              ? (progress) => progressState!.updateReadingProgress(
                  materialIndex!,
                  progress,
                )
              : null,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Pelajari Kembali',
          style: TextStyle(color: NivoApp.ink, fontWeight: FontWeight.w700),
        ),
        backgroundColor: const Color(0xFFF8FAFF),
        foregroundColor: NivoApp.ink,
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 560),
            child: ListView(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 28),
              children: [
                Text(
                  material.title,
                  style: const TextStyle(
                    color: NivoApp.ink,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Yuk perkuat bagian yang masih perlu kamu kuasai.',
                  style: TextStyle(
                    color: Color(0xFF64738B),
                    fontSize: 15,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 22),
                for (var index = 0; index < material.subtopics.length; index++)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _ReviewRecommendationCard(
                      title: material.subtopics[index],
                      isMastered: masteredSubtopics[index],
                      onReview: () => _openSubtopic(context, index),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ReviewRecommendationCard extends StatelessWidget {
  const _ReviewRecommendationCard({
    required this.title,
    required this.isMastered,
    required this.onReview,
  });

  final String title;
  final bool isMastered;
  final VoidCallback onReview;

  @override
  Widget build(BuildContext context) {
    final statusColor = isMastered
        ? const Color(0xFF22866F)
        : const Color(0xFFAA681D);

    return Container(
      key: Key('recommendation-${title.hashCode}'),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE9EEF7)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                isMastered
                    ? Icons.check_circle_rounded
                    : Icons.replay_circle_filled_rounded,
                color: statusColor,
                size: 22,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: NivoApp.ink,
                        fontSize: 15,
                        height: 1.4,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      isMastered
                          ? 'Sudah Dikuasai'
                          : 'Perlu Dipelajari Kembali',
                      style: TextStyle(
                        color: statusColor,
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (!isMastered) ...[
            const SizedBox(height: 12),
            Align(
              alignment: Alignment.centerRight,
              child: OutlinedButton.icon(
                key: Key('review-subtopic-${title.hashCode}'),
                onPressed: onReview,
                icon: const Icon(Icons.menu_book_rounded, size: 18),
                label: const Text('Pelajari Kembali'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: NivoApp.blue,
                  side: const BorderSide(color: Color(0xFFDCE5FF)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _SubtopicMasteryResult extends StatelessWidget {
  const _SubtopicMasteryResult({
    required this.title,
    required this.isMastered,
    required this.correctAnswers,
    required this.totalQuestions,
    this.notMasteredLabel = 'Belum Dikuasai',
  });

  final String title;
  final bool isMastered;
  final int correctAnswers;
  final int totalQuestions;
  final String notMasteredLabel;

  @override
  Widget build(BuildContext context) {
    final color = isMastered
        ? const Color(0xFF22866F)
        : const Color(0xFFAA681D);
    final status = isMastered ? 'Dikuasai' : notMasteredLabel;

    return Container(
      key: Key('subtopic-mastery-${title.hashCode}'),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFF),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE9EEF7)),
      ),
      child: Row(
        children: [
          Icon(
            isMastered ? Icons.check_circle_rounded : Icons.refresh_rounded,
            color: color,
            size: 20,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: NivoApp.ink,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  '$status · $correctAnswers dari $totalQuestions benar',
                  style: TextStyle(
                    color: color,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _AnswerOptionCard extends StatelessWidget {
  const _AnswerOptionCard({
    super.key,
    required this.label,
    required this.text,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final String text;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final borderColor = isSelected ? NivoApp.blue : const Color(0xFFE9EEF7);
    return Material(
      color: isSelected ? const Color(0xFFF0F4FF) : Colors.white,
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: borderColor, width: isSelected ? 1.5 : 1),
          ),
          child: Row(
            children: [
              Container(
                width: 34,
                height: 34,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: isSelected ? NivoApp.blue : const Color(0xFFEAF0FF),
                  shape: BoxShape.circle,
                ),
                child: Text(
                  label,
                  style: TextStyle(
                    color: isSelected ? Colors.white : NivoApp.blue,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Text(
                  text,
                  style: const TextStyle(
                    color: NivoApp.ink,
                    fontSize: 14,
                    height: 1.4,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              if (isSelected)
                const Icon(Icons.check_circle_rounded, color: NivoApp.blue),
            ],
          ),
        ),
      ),
    );
  }
}

class _MaterialStatusSummary extends StatelessWidget {
  const _MaterialStatusSummary({required this.status, required this.progress});

  final MaterialStatus status;
  final double progress;

  @override
  Widget build(BuildContext context) {
    final color = switch (status) {
      MaterialStatus.notStarted => const Color(0xFF77849A),
      MaterialStatus.inProgress => NivoApp.blue,
      MaterialStatus.notMastered => const Color(0xFFC47A22),
      MaterialStatus.mastered => const Color(0xFF22866F),
    };
    final icon = switch (status) {
      MaterialStatus.notStarted => Icons.radio_button_unchecked_rounded,
      MaterialStatus.inProgress => Icons.play_circle_fill_rounded,
      MaterialStatus.notMastered => Icons.error_outline_rounded,
      MaterialStatus.mastered => Icons.check_circle_rounded,
    };
    final detail = switch (status) {
      MaterialStatus.notStarted => 'Belum Dimulai',
      MaterialStatus.inProgress =>
        'Sedang Dipelajari · ${(progress * 100).round()}%',
      MaterialStatus.notMastered => 'Belum Dikuasai',
      MaterialStatus.mastered => 'Dikuasai',
    };

    return Row(
      children: [
        Icon(icon, color: color, size: 20),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            detail,
            style: TextStyle(
              color: color,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}

class _NivoWordmark extends StatelessWidget {
  const _NivoWordmark();

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.auto_stories_rounded, color: NivoApp.blue, size: 26),
        SizedBox(width: 9),
        Text(
          'NIVO',
          style: TextStyle(
            color: NivoApp.ink,
            fontSize: 20,
            fontWeight: FontWeight.w800,
            letterSpacing: 3,
          ),
        ),
      ],
    );
  }
}

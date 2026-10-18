import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_application_1/main.dart';

const _testMaterial = LearningMaterial(
  subject: 'Pemrograman Mobile',
  title: 'Materi 1 — Pengenalan Flutter',
  subtopics: [
    'Submateri 1 — Pengenalan Konsep',
    'Submateri 2 — Konsep Dasar',
    'Submateri 3 — Penerapan',
  ],
  overviewHeading: 'Apa itu Flutter?',
  overview: 'Flutter membantu membuat aplikasi.',
  keyPoints: ['Flutter memakai widget.'],
);

void main() {
  testWidgets('shows the NIVO splash screen and navigates to home', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const NivoApp());

    expect(find.text('NIVO'), findsOneWidget);
    expect(find.text('Belajar Logika,\nKuasai Pemrograman'), findsOneWidget);
    expect(find.text('Halo, Selamat Datang di NIVO'), findsNothing);

    await tester.pump(const Duration(seconds: 3));
    await tester.pumpAndSettle();

    expect(find.text('Halo, Nelen! 👋'), findsOneWidget);
    expect(find.text('Mulai Belajar'), findsOneWidget);
    expect(find.text('65%'), findsOneWidget);
    expect(find.text('12 dari 18 materi selesai'), findsOneWidget);
    expect(find.text('Pemrograman Mobile'), findsOneWidget);
  });

  testWidgets('splash start button opens home immediately', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const NivoApp());

    await tester.tap(find.text('Mulai Belajar'));
    await tester.pumpAndSettle();

    expect(find.text('Halo, Nelen! 👋'), findsOneWidget);
    expect(find.text('Yuk lanjutkan belajar hari ini.'), findsOneWidget);

    await tester.pump(const Duration(seconds: 3));
    await tester.pumpAndSettle();
    expect(find.text('Halo, Nelen! 👋'), findsOneWidget);
  });

  testWidgets('home shortcuts open the materials list', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const NivoApp());
    await tester.pump(const Duration(seconds: 3));
    await tester.pumpAndSettle();

    await tester.ensureVisible(find.text('Mulai Belajar'));
    await tester.tap(find.text('Mulai Belajar'));
    await tester.pumpAndSettle();

    expect(find.text('Daftar Materi'), findsOneWidget);
    expect(
      find.text('Yuk pilih materi yang ingin kamu pelajari.'),
      findsOneWidget,
    );
    expect(find.text('Materi 1 — Pengenalan Flutter'), findsOneWidget);
    expect(find.text('Materi 2 — Struktur Project Flutter'), findsOneWidget);
    expect(find.text('Materi 3 — Widget Dasar'), findsOneWidget);

    await tester.scrollUntilVisible(
      find.text('Materi 4 — Flutter & Widget'),
      300,
      scrollable: find.byType(Scrollable).last,
    );
    expect(find.text('Materi 4 — Flutter & Widget'), findsOneWidget);

    await tester.scrollUntilVisible(
      find.text('Materi 5 — Layout dan Navigasi'),
      300,
      scrollable: find.byType(Scrollable).last,
    );
    expect(find.text('Materi 5 — Layout dan Navigasi'), findsOneWidget);

    await tester.pageBack();
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.text('Daftar Materi'));
    await tester.tap(find.text('Daftar Materi'));
    await tester.pumpAndSettle();

    expect(
      find.text('Yuk pilih materi yang ingin kamu pelajari.'),
      findsOneWidget,
    );
  });

  testWidgets('only material 1 is open at the initial state', (
    WidgetTester tester,
  ) async {
    final progress = MaterialProgressState();
    await tester.pumpWidget(
      MaterialApp(home: MaterialsListScreen(progressState: progress)),
    );

    expect(progress.statusFor(0), MaterialStatus.notStarted);
    expect(progress.isUnlocked(0), isTrue);
    for (var index = 1; index < 5; index++) {
      expect(progress.statusFor(index), MaterialStatus.notStarted);
      expect(progress.isUnlocked(index), isFalse);
    }
    await _expectMaterialCard(
      tester,
      number: 1,
      access: 'Terbuka',
      icon: Icons.lock_open_rounded,
    );
    for (var number = 2; number <= 5; number++) {
      await _expectMaterialCard(
        tester,
        number: number,
        access: 'Terkunci',
        icon: Icons.lock_rounded,
      );
    }

    const lockedTitles = [
      'Materi 2 — Struktur Project Flutter',
      'Materi 3 — Widget Dasar',
      'Materi 4 — Flutter & Widget',
      'Materi 5 — Layout dan Navigasi',
    ];
    for (final title in lockedTitles) {
      await tester.scrollUntilVisible(
        find.text(title),
        300,
        scrollable: find.byType(Scrollable).last,
      );
      await tester.tap(find.text(title));
      await tester.pumpAndSettle();
      expect(
        find.text('Selesaikan dan kuasai materi sebelumnya terlebih dahulu.'),
        findsOneWidget,
      );
      expect(find.text('Detail Materi'), findsNothing);
    }

    await tester.scrollUntilVisible(
      find.text('Materi 1 — Pengenalan Flutter'),
      -300,
      scrollable: find.byType(Scrollable).last,
    );
    await tester.drag(find.byType(ListView).last, const Offset(0, 180));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Materi 1 — Pengenalan Flutter'));
    await tester.pumpAndSettle();
    await tester.pump(const Duration(milliseconds: 500));
    expect(find.text('Detail Materi'), findsOneWidget);
    expect(find.text('Materi 1 — Pengenalan Flutter'), findsOneWidget);
    expect(find.text('Belum Dimulai'), findsOneWidget);

    await tester.pageBack();
    await tester.pumpAndSettle();
    progress.dispose();
  });

  testWidgets('mastery unlocks the next material in sequence', (
    WidgetTester tester,
  ) async {
    final progress = MaterialProgressState();
    await tester.pumpWidget(
      MaterialApp(home: MaterialsListScreen(progressState: progress)),
    );

    await _expectMaterialCard(
      tester,
      number: 1,
      access: 'Terbuka',
      icon: Icons.lock_open_rounded,
      status: 'Belum Dimulai',
    );
    await _expectMaterialCard(
      tester,
      number: 2,
      access: 'Terkunci',
      icon: Icons.lock_rounded,
    );

    progress.markMastered(0);
    await tester.pump();
    expect(progress.isUnlocked(1), isTrue);
    expect(progress.isUnlocked(2), isFalse);
    await _expectMaterialCard(
      tester,
      number: 1,
      access: 'Terbuka',
      icon: Icons.lock_open_rounded,
      status: 'Dikuasai',
    );
    await _expectMaterialCard(
      tester,
      number: 2,
      access: 'Terbuka',
      icon: Icons.lock_open_rounded,
      status: 'Belum Dimulai',
    );
    for (var number = 3; number <= 5; number++) {
      await _expectMaterialCard(
        tester,
        number: number,
        access: 'Terkunci',
        icon: Icons.lock_rounded,
      );
    }

    await tester.ensureVisible(find.text('Materi 3 — Widget Dasar'));
    await tester.tap(find.text('Materi 3 — Widget Dasar'));
    await tester.pumpAndSettle();
    expect(
      find.text('Selesaikan dan kuasai materi sebelumnya terlebih dahulu.'),
      findsOneWidget,
    );
    expect(find.text('Detail Materi'), findsNothing);
    tester
        .state<ScaffoldMessengerState>(find.byType(ScaffoldMessenger))
        .hideCurrentSnackBar();
    await tester.pumpAndSettle();

    await tester.ensureVisible(
      find.text('Materi 2 — Struktur Project Flutter'),
    );
    await tester.tap(find.text('Materi 2 — Struktur Project Flutter'));
    await tester.pumpAndSettle();
    expect(find.text('Detail Materi'), findsOneWidget);
    expect(find.text('Materi 2 — Struktur Project Flutter'), findsOneWidget);

    await tester.pageBack();
    await tester.pumpAndSettle();
    progress.markMastered(1);
    await tester.pump();
    expect(progress.isUnlocked(2), isTrue);
    expect(progress.isUnlocked(3), isFalse);
    for (var number = 1; number <= 2; number++) {
      await _expectMaterialCard(
        tester,
        number: number,
        access: 'Terbuka',
        icon: Icons.lock_open_rounded,
        status: 'Dikuasai',
      );
    }
    await _expectMaterialCard(
      tester,
      number: 3,
      access: 'Terbuka',
      icon: Icons.lock_open_rounded,
      status: 'Belum Dimulai',
    );
    for (var number = 4; number <= 5; number++) {
      await _expectMaterialCard(
        tester,
        number: number,
        access: 'Terkunci',
        icon: Icons.lock_rounded,
      );
    }

    progress.dispose();
  });

  testWidgets('detail reading progress leads to the selected evaluation', (
    WidgetTester tester,
  ) async {
    tester.view.physicalSize = const Size(400, 900);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    final progress = MaterialProgressState();
    const material = LearningMaterial(
      subject: 'Pemrograman Mobile',
      title: 'Materi 1 — Pengenalan Flutter',
      subtopics: [
        'Submateri 1 — Pengenalan Konsep',
        'Submateri 2 — Konsep Dasar',
        'Submateri 3 — Penerapan',
      ],
      overviewHeading: 'Apa itu Flutter?',
      overview: 'Flutter membantu membuat aplikasi dari satu basis kode.',
      keyPoints: ['Flutter menggunakan widget.', 'Flutter menggunakan Dart.'],
    );
    await tester.pumpWidget(
      MaterialApp(
        home: MaterialDetailScreen(
          material: material,
          onReadingProgressChanged: (value) =>
              progress.updateReadingProgress(0, value),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Materi 1 — Pengenalan Flutter'), findsOneWidget);
    expect(find.text('Apa itu Flutter?'), findsOneWidget);
    expect(find.text('Progress Membaca'), findsOneWidget);
    expect(find.text('0%'), findsOneWidget);
    expect(find.text('Dikuasai'), findsNothing);

    for (var index = 0; index < 3; index++) {
      final subtopic = find.byKey(Key('subtopic-card-$index'));
      await tester.ensureVisible(subtopic);
      await tester.tap(subtopic);
      await tester.pumpAndSettle();
      expect(find.text('${((index + 1) / 3 * 100).round()}%'), findsOneWidget);
    }

    expect(progress.statusFor(0), MaterialStatus.inProgress);
    expect(progress.progressFor(0), 1);
    expect(progress.statusFor(0), isNot(MaterialStatus.mastered));

    await tester.tap(find.text('Mulai Evaluasi'));
    await tester.pumpAndSettle();
    expect(find.text('Soal 1 dari 10'), findsOneWidget);
    expect(find.text('Materi 1 — Pengenalan Flutter'), findsOneWidget);

    progress.dispose();
  });

  testWidgets(
    'evaluation requires answers and shows a result after ten questions',
    (WidgetTester tester) async {
      tester.view.physicalSize = const Size(400, 900);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(
        const MaterialApp(home: EvaluationScreen(material: _testMaterial)),
      );

      expect(find.text('Soal 1 dari 10'), findsOneWidget);
      expect(find.byKey(const Key('evaluation-option-0')), findsOneWidget);
      expect(find.byKey(const Key('evaluation-option-1')), findsOneWidget);
      expect(find.byKey(const Key('evaluation-option-2')), findsOneWidget);
      expect(find.byKey(const Key('evaluation-option-3')), findsOneWidget);

      await tester.tap(find.text('Lanjut'));
      await tester.pump();
      expect(find.text('Soal 1 dari 10'), findsOneWidget);
      expect(find.text('Pilih jawaban terlebih dahulu.'), findsOneWidget);
      tester
          .state<ScaffoldMessengerState>(find.byType(ScaffoldMessenger))
          .hideCurrentSnackBar();
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('evaluation-option-1')));
      await tester.pumpAndSettle();
      expect(find.byIcon(Icons.check_circle_rounded), findsOneWidget);
      await tester.tap(find.byKey(const Key('evaluation-option-2')));
      await tester.pumpAndSettle();
      expect(find.byIcon(Icons.check_circle_rounded), findsOneWidget);
      await tester.tap(find.text('Lanjut'));
      await tester.pumpAndSettle();
      expect(find.text('Soal 2 dari 10'), findsOneWidget);

      for (var question = 1; question < 10; question++) {
        expect(find.text('Soal ${question + 1} dari 10'), findsOneWidget);
        await tester.tap(find.byKey(const Key('evaluation-option-0')));
        await tester.pumpAndSettle();
        await tester.tap(find.text('Lanjut'));
        await tester.pumpAndSettle();
      }

      expect(find.text('Hasil Evaluasi'), findsOneWidget);
      expect(find.text('Evaluasi Selesai'), findsOneWidget);
      expect(find.text('Belum Menguasai'), findsOneWidget);
      expect(find.text('Pelajari Kembali'), findsOneWidget);
      expect(find.text('30/100'), findsOneWidget);
      expect(find.byKey(const Key('evaluation-correct-count')), findsOneWidget);
      expect(find.byKey(const Key('evaluation-score')), findsOneWidget);
    },
  );

  testWidgets('a score below 75 offers review and does not master material', (
    WidgetTester tester,
  ) async {
    final progress = MaterialProgressState();
    await tester.pumpWidget(
      MaterialApp(home: MaterialsListScreen(progressState: progress)),
    );

    await tester.tap(find.text(_testMaterial.title));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Mulai Evaluasi'));
    await tester.pumpAndSettle();
    await _answerEvaluation(tester, const [0, 1, 0, 0, 0, 0, 0, 0, 0, 0]);

    expect(find.text('Belum Menguasai'), findsOneWidget);
    expect(find.text('Pelajari Kembali'), findsOneWidget);
    expect(find.text('Lanjut ke Materi Berikutnya'), findsNothing);
    expect(progress.statusFor(0), isNot(MaterialStatus.mastered));

    await tester.ensureVisible(find.text('Pelajari Kembali'));
    await tester.tap(find.text('Pelajari Kembali'));
    await tester.pumpAndSettle();

    expect(
      find.text('Yuk perkuat bagian yang masih perlu kamu kuasai.'),
      findsOneWidget,
    );
    expect(find.text(_testMaterial.subtopics[0]), findsOneWidget);
    expect(find.text(_testMaterial.subtopics[1]), findsOneWidget);
    expect(find.text(_testMaterial.subtopics[2]), findsOneWidget);
    expect(find.text('Sudah Dikuasai'), findsOneWidget);
    expect(find.text('Perlu Dipelajari Kembali'), findsNWidgets(2));
    expect(find.text('Pelajari Kembali'), findsNWidgets(3));
    expect(
      find.byKey(Key('review-subtopic-${_testMaterial.subtopics[1].hashCode}')),
      findsOneWidget,
    );

    await tester.ensureVisible(
      find.byKey(Key('review-subtopic-${_testMaterial.subtopics[1].hashCode}')),
    );
    await tester.tap(
      find.byKey(Key('review-subtopic-${_testMaterial.subtopics[1].hashCode}')),
    );
    await tester.pumpAndSettle();

    expect(find.text('Detail Materi'), findsOneWidget);
    expect(find.text(_testMaterial.subtopics[1]), findsOneWidget);
    final selectedSubtopicRect = tester.getRect(
      find.byKey(const Key('subtopic-card-1')),
    );
    expect(selectedSubtopicRect.top, greaterThan(0));
    expect(selectedSubtopicRect.top, lessThan(600));

    await tester.tap(find.byKey(const Key('start-remedial-evaluation')));
    await tester.pumpAndSettle();
    expect(find.text('Evaluasi Remedial'), findsOneWidget);
    expect(find.text('Soal 1 dari 10'), findsOneWidget);
    expect(find.text(_testMaterial.subtopics[1]), findsOneWidget);
    final remedialPrompt = tester.widget<Text>(
      find.byKey(const Key('remedial-question-prompt')),
    );
    expect(remedialPrompt.data, isNot('Apa fungsi utama Flutter?'));

    await tester.tap(find.text('Lanjut'));
    await tester.pump();
    expect(find.text('Soal 1 dari 10'), findsOneWidget);
    expect(find.text('Pilih jawaban terlebih dahulu.'), findsOneWidget);
    tester
        .state<ScaffoldMessengerState>(find.byType(ScaffoldMessenger))
        .hideCurrentSnackBar();
    await tester.pumpAndSettle();

    for (var questionIndex = 0; questionIndex < 10; questionIndex++) {
      final option = find.byKey(const Key('remedial-option-0'));
      await tester.ensureVisible(option);
      await tester.tap(option);
      await tester.pumpAndSettle();
      await tester.tap(find.text('Lanjut'));
      await tester.pumpAndSettle();
      if (questionIndex < 9) {
        expect(find.text('Soal ${questionIndex + 2} dari 10'), findsOneWidget);
      }
    }

    expect(find.text('Hasil Remedial'), findsOneWidget);
    expect(find.text('Remedial Selesai'), findsOneWidget);
    expect(find.byKey(const Key('remedial-correct-count')), findsOneWidget);
    expect(find.byKey(const Key('remedial-score')), findsOneWidget);
    expect(find.text('Materi masih perlu dipelajari kembali'), findsOneWidget);
    expect(find.textContaining('Perlu Dipelajari Kembali ·'), findsNWidgets(2));
    expect(progress.statusFor(0), isNot(MaterialStatus.mastered));

    await tester.ensureVisible(
      find.byKey(const Key('remedial-result-continue')),
    );
    await tester.tap(find.byKey(const Key('remedial-result-continue')));
    await tester.pumpAndSettle();
    expect(
      find.text('Yuk perkuat bagian yang masih perlu kamu kuasai.'),
      findsOneWidget,
    );
    expect(find.text('Perlu Dipelajari Kembali'), findsNWidgets(2));
    expect(find.text('Materi berhasil dikuasai'), findsNothing);
    progress.dispose();
  });

  testWidgets(
    'passing remedial masters material and returns to materials list',
    (WidgetTester tester) async {
      tester.view.physicalSize = const Size(400, 900);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      final progress = MaterialProgressState();
      await tester.pumpWidget(
        MaterialApp(home: MaterialsListScreen(progressState: progress)),
      );
      await tester.tap(find.text(_testMaterial.title));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Mulai Evaluasi'));
      await tester.pumpAndSettle();
      await _answerEvaluation(tester, const [0, 1, 0, 0, 0, 0, 0, 0, 0, 0]);
      await tester.ensureVisible(find.text('Pelajari Kembali'));
      await tester.tap(find.text('Pelajari Kembali'));
      await tester.pumpAndSettle();
      await tester.ensureVisible(
        find.byKey(
          Key('review-subtopic-${_testMaterial.subtopics[1].hashCode}'),
        ),
      );
      await tester.tap(
        find.byKey(
          Key('review-subtopic-${_testMaterial.subtopics[1].hashCode}'),
        ),
      );
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const Key('start-remedial-evaluation')));
      await tester.pumpAndSettle();

      await _answerRemedial(tester, const [1, 0, 3, 2, 1, 0, 3, 2, 1, 0]);

      expect(find.text('Hasil Remedial'), findsOneWidget);
      expect(find.text('100/100'), findsOneWidget);
      expect(find.text('Materi berhasil dikuasai'), findsOneWidget);
      expect(find.text('Materi berikutnya telah terbuka.'), findsOneWidget);
      expect(progress.statusFor(0), MaterialStatus.mastered);
      expect(progress.isUnlocked(1), isTrue);

      await tester.ensureVisible(
        find.byKey(const Key('remedial-result-continue')),
      );
      await tester.tap(find.byKey(const Key('remedial-result-continue')));
      await tester.pumpAndSettle();
      expect(find.text('Daftar Materi'), findsOneWidget);
      expect(progress.statusFor(0), MaterialStatus.mastered);
      expect(progress.isUnlocked(1), isTrue);
      await _expectMaterialCard(
        tester,
        number: 1,
        access: 'Terbuka',
        icon: Icons.lock_open_rounded,
        status: 'Dikuasai',
      );
      await _expectMaterialCard(
        tester,
        number: 2,
        access: 'Terbuka',
        icon: Icons.lock_open_rounded,
        status: 'Belum Dimulai',
      );
      for (var number = 3; number <= 5; number++) {
        await _expectMaterialCard(
          tester,
          number: number,
          access: 'Terkunci',
          icon: Icons.lock_rounded,
        );
      }
      await tester.ensureVisible(
        find.text('Materi 2 — Struktur Project Flutter'),
      );
      await tester.tap(find.text('Materi 2 — Struktur Project Flutter'));
      await tester.pumpAndSettle();
      expect(find.text('Detail Materi'), findsOneWidget);
      expect(find.text('Materi 2 — Struktur Project Flutter'), findsOneWidget);
      progress.dispose();
    },
  );

  testWidgets('a passing score masters the material and unlocks the next', (
    WidgetTester tester,
  ) async {
    final progress = MaterialProgressState();
    await tester.pumpWidget(
      MaterialApp(home: MaterialsListScreen(progressState: progress)),
    );

    await tester.tap(find.text(_testMaterial.title));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Mulai Evaluasi'));
    await tester.pumpAndSettle();
    await _answerEvaluation(tester, const [0, 1, 0, 0, 2, 1, 2, 0, 1, 3]);

    expect(find.text('Dikuasai'), findsOneWidget);
    expect(find.textContaining('Dikuasai ·'), findsNWidgets(3));
    expect(find.text('Lanjut ke Materi Berikutnya'), findsOneWidget);
    await tester.ensureVisible(find.text('Lanjut ke Materi Berikutnya'));
    await tester.tap(find.text('Lanjut ke Materi Berikutnya'));
    await tester.pumpAndSettle();

    expect(progress.statusFor(0), MaterialStatus.mastered);
    expect(progress.isUnlocked(1), isTrue);
    await tester.ensureVisible(
      find.text('Materi 2 — Struktur Project Flutter'),
    );
    await tester.tap(find.text('Materi 2 — Struktur Project Flutter'));
    await tester.pumpAndSettle();
    expect(find.text('Detail Materi'), findsOneWidget);
    expect(find.text('Materi 2 — Struktur Project Flutter'), findsOneWidget);
    progress.dispose();
  });
}

Future<void> _answerEvaluation(
  WidgetTester tester,
  List<int> selectedOptions,
) async {
  for (final optionIndex in selectedOptions) {
    final option = find.byKey(Key('evaluation-option-$optionIndex'));
    await tester.ensureVisible(option);
    await tester.tap(option);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Lanjut'));
    await tester.pumpAndSettle();
  }
}

Future<void> _answerRemedial(
  WidgetTester tester,
  List<int> selectedOptions,
) async {
  for (final optionIndex in selectedOptions) {
    final option = find.byKey(Key('remedial-option-$optionIndex'));
    await tester.ensureVisible(option);
    await tester.tap(option);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Lanjut'));
    await tester.pumpAndSettle();
  }
}

Future<void> _expectMaterialCard(
  WidgetTester tester, {
  required int number,
  required String access,
  required IconData icon,
  String? status,
}) async {
  final card = find.byKey(Key('material-card-$number'));
  await tester.scrollUntilVisible(
    card,
    200,
    scrollable: find.byType(Scrollable).last,
  );
  expect(
    find.descendant(of: card, matching: find.text(access)),
    findsOneWidget,
  );
  expect(
    find.descendant(of: card, matching: find.byIcon(icon)),
    findsOneWidget,
  );
  if (status != null) {
    expect(
      find.descendant(of: card, matching: find.text(status)),
      findsOneWidget,
    );
  }
}

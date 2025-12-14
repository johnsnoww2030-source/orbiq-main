import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:orbiq/features/exports/domain/failures/export_failure.dart';
import 'package:orbiq/features/exports/domain/repositories/export_repository.dart';
import 'package:orbiq/features/exports/domain/usecases/export_to_excel_usecase.dart';
import 'package:orbiq/features/exports/domain/usecases/export_to_pdf_usecase.dart';
import 'package:orbiq/features/exports/presentation/controller/export_bloc.dart';
import 'package:orbiq/features/exports/presentation/controller/export_event.dart';
import 'package:orbiq/features/exports/presentation/controller/export_state.dart';

/// Fake implementation of ExportRepository for testing
class FakeExportRepository implements ExportRepository {
  bool exportToPDFCalled = false;
  bool exportToExcelCalled = false;

  String? lastPdfFileName;
  String? lastExcelFileName;
  List<List<dynamic>>? lastPdfData;
  List<dynamic>? lastExcelData;

  // Configurable responses
  Either<ExportFailure, String> pdfResponse = const Right('/path/to/test.pdf');
  Either<ExportFailure, String> excelResponse = const Right(
    '/path/to/test.xlsx',
  );

  @override
  Future<Either<ExportFailure, String>> exportToPDF(
    List<List<dynamic>> data,
    String fileName,
  ) async {
    exportToPDFCalled = true;
    lastPdfFileName = fileName;
    lastPdfData = data;
    return pdfResponse;
  }

  @override
  Future<Either<ExportFailure, String>> exportToExcel(
    List<dynamic> data,
    String fileName,
  ) async {
    exportToExcelCalled = true;
    lastExcelFileName = fileName;
    lastExcelData = data;
    return excelResponse;
  }

  void reset() {
    exportToPDFCalled = false;
    exportToExcelCalled = false;
    lastPdfFileName = null;
    lastExcelFileName = null;
    lastPdfData = null;
    lastExcelData = null;
    pdfResponse = const Right('/path/to/test.pdf');
    excelResponse = const Right('/path/to/test.xlsx');
  }
}

void main() {
  group('ExportBloc', () {
    late ExportBloc bloc;
    late FakeExportRepository fakeRepository;
    late ExportToPDFUseCase pdfUseCase;
    late ExportToExcelUseCase excelUseCase;

    setUp(() {
      fakeRepository = FakeExportRepository();
      pdfUseCase = ExportToPDFUseCase(fakeRepository);
      excelUseCase = ExportToExcelUseCase(fakeRepository);
      bloc = ExportBloc(pdfUseCase, excelUseCase);
    });

    tearDown(() {
      bloc.close();
    });

    test('initial state is ExportInitial', () {
      expect(bloc.state, isA<ExportInitial>());
    });

    group('PdfExportRequested', () {
      final testData = [
        ['Header1', 'Header2'],
        ['Value1', 'Value2'],
      ];

      blocTest<ExportBloc, ExportState>(
        'emits [Exporting, ExportSuccess] when PDF export succeeds',
        build: () {
          fakeRepository.pdfResponse = const Right('/documents/test.pdf');
          return ExportBloc(pdfUseCase, excelUseCase);
        },
        act: (bloc) => bloc.add(
          PdfExportRequested(data: testData, fileName: 'test_export'),
        ),
        expect: () => [
          isA<Exporting>(),
          isA<ExportSuccess>().having(
            (s) => s.filePath,
            'filePath',
            '/documents/test.pdf',
          ),
        ],
        verify: (_) {
          expect(fakeRepository.exportToPDFCalled, true);
          expect(fakeRepository.lastPdfFileName, 'test_export');
          expect(fakeRepository.lastPdfData, testData);
        },
      );

      blocTest<ExportBloc, ExportState>(
        'emits [Exporting, ExportError] when PDF export fails',
        build: () {
          fakeRepository.pdfResponse = const Left(
            PdfExportFailure('خطا در تولید PDF'),
          );
          return ExportBloc(pdfUseCase, excelUseCase);
        },
        act: (bloc) => bloc.add(
          PdfExportRequested(data: testData, fileName: 'test_export'),
        ),
        expect: () => [
          isA<Exporting>(),
          isA<ExportError>().having(
            (s) => s.message,
            'message',
            'خطا در تولید PDF',
          ),
        ],
      );

      blocTest<ExportBloc, ExportState>(
        'emits [Exporting, ExportError] when font loading fails',
        build: () {
          fakeRepository.pdfResponse = const Left(
            FontLoadFailure('خطا در بارگذاری فونت'),
          );
          return ExportBloc(pdfUseCase, excelUseCase);
        },
        act: (bloc) => bloc.add(
          PdfExportRequested(data: testData, fileName: 'test_export'),
        ),
        expect: () => [
          isA<Exporting>(),
          isA<ExportError>().having(
            (s) => s.message,
            'message',
            'خطا در بارگذاری فونت',
          ),
        ],
      );

      blocTest<ExportBloc, ExportState>(
        'emits [Exporting, ExportError] when file system error occurs',
        build: () {
          fakeRepository.pdfResponse = const Left(
            FileSystemFailure('خطا در ذخیره فایل'),
          );
          return ExportBloc(pdfUseCase, excelUseCase);
        },
        act: (bloc) => bloc.add(
          PdfExportRequested(data: testData, fileName: 'test_export'),
        ),
        expect: () => [
          isA<Exporting>(),
          isA<ExportError>().having(
            (s) => s.message,
            'message',
            'خطا در ذخیره فایل',
          ),
        ],
      );
    });

    group('ExcelExportRequested', () {
      final testData = [
        ['Header1', 'Header2'],
        ['Value1', 'Value2'],
      ];

      blocTest<ExportBloc, ExportState>(
        'emits [Exporting, ExportSuccess] when Excel export succeeds',
        build: () {
          fakeRepository.excelResponse = const Right('/documents/test.xlsx');
          return ExportBloc(pdfUseCase, excelUseCase);
        },
        act: (bloc) => bloc.add(
          ExcelExportRequested(data: testData, fileName: 'test_export'),
        ),
        expect: () => [
          isA<Exporting>(),
          isA<ExportSuccess>().having(
            (s) => s.filePath,
            'filePath',
            '/documents/test.xlsx',
          ),
        ],
        verify: (_) {
          expect(fakeRepository.exportToExcelCalled, true);
          expect(fakeRepository.lastExcelFileName, 'test_export');
          expect(fakeRepository.lastExcelData, testData);
        },
      );

      blocTest<ExportBloc, ExportState>(
        'emits [Exporting, ExportError] when Excel export fails',
        build: () {
          fakeRepository.excelResponse = const Left(
            ExcelExportFailure('خطا در تولید Excel'),
          );
          return ExportBloc(pdfUseCase, excelUseCase);
        },
        act: (bloc) => bloc.add(
          ExcelExportRequested(data: testData, fileName: 'test_export'),
        ),
        expect: () => [
          isA<Exporting>(),
          isA<ExportError>().having(
            (s) => s.message,
            'message',
            'خطا در تولید Excel',
          ),
        ],
      );

      blocTest<ExportBloc, ExportState>(
        'emits [Exporting, ExportError] when file system error occurs',
        build: () {
          fakeRepository.excelResponse = const Left(
            FileSystemFailure('خطا در ذخیره فایل'),
          );
          return ExportBloc(pdfUseCase, excelUseCase);
        },
        act: (bloc) => bloc.add(
          ExcelExportRequested(data: testData, fileName: 'test_export'),
        ),
        expect: () => [
          isA<Exporting>(),
          isA<ExportError>().having(
            (s) => s.message,
            'message',
            'خطا در ذخیره فایل',
          ),
        ],
      );
    });
  });

  group('ExportToPDFUseCase', () {
    late FakeExportRepository fakeRepository;
    late ExportToPDFUseCase useCase;

    setUp(() {
      fakeRepository = FakeExportRepository();
      useCase = ExportToPDFUseCase(fakeRepository);
    });

    test('calls repository with correct parameters', () async {
      final testData = [
        ['A', 'B'],
        ['C', 'D'],
      ];
      const fileName = 'test_file';

      await useCase.call(testData, fileName);

      expect(fakeRepository.exportToPDFCalled, true);
      expect(fakeRepository.lastPdfFileName, fileName);
      expect(fakeRepository.lastPdfData, testData);
    });

    test('returns Right with file path on success', () async {
      fakeRepository.pdfResponse = const Right('/path/to/file.pdf');

      final result = await useCase.call([], 'test');

      expect(result.isRight(), true);
      result.fold(
        (_) => fail('Expected Right'),
        (path) => expect(path, '/path/to/file.pdf'),
      );
    });

    test('returns Left with failure on error', () async {
      fakeRepository.pdfResponse = const Left(PdfExportFailure());

      final result = await useCase.call([], 'test');

      expect(result.isLeft(), true);
      result.fold(
        (failure) => expect(failure, isA<PdfExportFailure>()),
        (_) => fail('Expected Left'),
      );
    });
  });

  group('ExportToExcelUseCase', () {
    late FakeExportRepository fakeRepository;
    late ExportToExcelUseCase useCase;

    setUp(() {
      fakeRepository = FakeExportRepository();
      useCase = ExportToExcelUseCase(fakeRepository);
    });

    test('calls repository with correct parameters', () async {
      final testData = [
        ['A', 'B'],
        ['C', 'D'],
      ];
      const fileName = 'test_file';

      await useCase.call(testData, fileName);

      expect(fakeRepository.exportToExcelCalled, true);
      expect(fakeRepository.lastExcelFileName, fileName);
      expect(fakeRepository.lastExcelData, testData);
    });

    test('returns Right with file path on success', () async {
      fakeRepository.excelResponse = const Right('/path/to/file.xlsx');

      final result = await useCase.call([], 'test');

      expect(result.isRight(), true);
      result.fold(
        (_) => fail('Expected Right'),
        (path) => expect(path, '/path/to/file.xlsx'),
      );
    });

    test('returns Left with failure on error', () async {
      fakeRepository.excelResponse = const Left(ExcelExportFailure());

      final result = await useCase.call([], 'test');

      expect(result.isLeft(), true);
      result.fold(
        (failure) => expect(failure, isA<ExcelExportFailure>()),
        (_) => fail('Expected Left'),
      );
    });
  });

  group('ExportFailure', () {
    test('PdfExportFailure has correct default message', () {
      const failure = PdfExportFailure();
      expect(failure.message, 'خطا در تولید PDF');
    });

    test('ExcelExportFailure has correct default message', () {
      const failure = ExcelExportFailure();
      expect(failure.message, 'خطا در تولید Excel');
    });

    test('FileSystemFailure has correct default message', () {
      const failure = FileSystemFailure();
      expect(failure.message, 'خطا در ذخیره فایل');
    });

    test('FontLoadFailure has correct default message', () {
      const failure = FontLoadFailure();
      expect(failure.message, 'خطا در بارگذاری فونت');
    });

    test('ExportFailure with custom message', () {
      const failure = PdfExportFailure('Custom error message');
      expect(failure.message, 'Custom error message');
    });

    test('ExportFailure props include message', () {
      const failure = PdfExportFailure('Test');
      expect(failure.props, ['Test']);
    });

    test('same failures are equal', () {
      const failure1 = PdfExportFailure('Same message');
      const failure2 = PdfExportFailure('Same message');
      expect(failure1, equals(failure2));
    });

    test('different failures are not equal', () {
      const failure1 = PdfExportFailure('Message 1');
      const failure2 = PdfExportFailure('Message 2');
      expect(failure1, isNot(equals(failure2)));
    });
  });

  group('ExportEvent', () {
    test('PdfExportRequested props include data and fileName', () {
      final event = PdfExportRequested(
        data: [
          ['A'],
        ],
        fileName: 'test',
      );
      expect(event.props, [
        [
          ['A'],
        ],
        'test',
      ]);
    });

    test('ExcelExportRequested props include data and fileName', () {
      final event = ExcelExportRequested(
        data: [
          ['A'],
        ],
        fileName: 'test',
      );
      expect(event.props, [
        [
          ['A'],
        ],
        'test',
      ]);
    });

    test('same events are equal', () {
      final event1 = PdfExportRequested(
        data: [
          ['A'],
        ],
        fileName: 'test',
      );
      final event2 = PdfExportRequested(
        data: [
          ['A'],
        ],
        fileName: 'test',
      );
      expect(event1, equals(event2));
    });
  });

  group('ExportState', () {
    test('ExportInitial props are empty', () {
      const state = ExportInitial();
      expect(state.props, isEmpty);
    });

    test('Exporting props are empty', () {
      const state = Exporting();
      expect(state.props, isEmpty);
    });

    test('ExportSuccess props include filePath', () {
      const state = ExportSuccess(filePath: '/path/to/file');
      expect(state.props, ['/path/to/file']);
    });

    test('ExportError props include message', () {
      const state = ExportError('Error message');
      expect(state.props, ['Error message']);
    });

    test('same states are equal', () {
      const state1 = ExportSuccess(filePath: '/path');
      const state2 = ExportSuccess(filePath: '/path');
      expect(state1, equals(state2));
    });
  });
}

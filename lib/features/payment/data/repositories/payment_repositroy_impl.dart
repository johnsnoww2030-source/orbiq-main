import 'dart:math';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:orbiq/features/auth/domain/failures/failure.dart';
import 'package:orbiq/features/payment/data/data_sources/local/payment_dao.dart';
import 'package:orbiq/features/payment/data/mapper/payment_mpper.dart';
import 'package:orbiq/features/payment/domain/entities/payment_entity.dart';
import 'package:orbiq/features/payment/domain/repositories/payment_repositroy.dart';

class PaginatedPayments {
  final List<PaymentEntity> payments;
  final int totalPayments;
  final int currentPage;
  final int totalPages;

  PaginatedPayments({
    required this.payments,
    required this.totalPayments,
    required this.currentPage,
    required this.totalPages,
  });
}

@LazySingleton(as: PaymentRepository)
class PaymentRepositoryImpl implements PaymentRepository {
  final PaymentDao _paymentDao;

  PaymentRepositoryImpl(this._paymentDao);

  @override
  Future<Either<Failure, void>> savePayment(PaymentEntity paymentEntity) async {
    try {
      final paymentModel = PaymentMapper.toModel(paymentEntity);
      await _paymentDao.insertPayment(paymentModel);
      return const Right(null);
    } catch (e) {
      return Left(GeneralFailure('خطا در ذخیره پرداخت: $e'));
    }
  }

  @override
  Future<Either<Failure, List<PaymentEntity>>> getPaymentsByUserId(
    int userId,
  ) async {
    try {
      final paymentModels = await _paymentDao.findPaymentsByUserId(userId);
      final paymentEntities = paymentModels
          .map(PaymentMapper.toEntity)
          .toList();
      return Right(paymentEntities);
    } catch (e) {
      return Left(GeneralFailure('خطا در دریافت پرداخت‌های کاربر: $e'));
    }
  }

  @override
  Future<Either<Failure, PaginatedPayments>> getAllPayments({
    required int page,
    required int limit,
  }) async {
    try {
      final paymentModels = await _paymentDao.findAllPayments();

      // Sort payments by paymentDateTime in descending order (newest first)
      paymentModels.sort(
        (a, b) => b.paymentDateTime.compareTo(a.paymentDateTime),
      );

      final paymentEntities = paymentModels
          .map(PaymentMapper.toEntity)
          .toList();

      final totalPayments = paymentEntities.length;
      final totalPages = (totalPayments / limit).ceil();

      final startIndex = (page - 1) * limit;
      final endIndex = min(page * limit, totalPayments);

      if (startIndex >= totalPayments && totalPayments > 0) {
        // Requested page is out of bounds but there is data
        return Right(
          PaginatedPayments(
            payments: [], // Return empty list for this page
            totalPayments: totalPayments,
            currentPage: page,
            totalPages: totalPages,
          ),
        );
      }
      if (totalPayments == 0) {
        return Right(
          PaginatedPayments(
            payments: [],
            totalPayments: 0,
            currentPage: 1,
            totalPages: 1,
          ),
        );
      }

      return Right(
        PaginatedPayments(
          payments: paymentEntities.sublist(startIndex, endIndex),
          totalPayments: totalPayments,
          currentPage: page,
          totalPages: totalPages,
        ),
      );
    } catch (e) {
      return Left(GeneralFailure('خطا در دریافت تمام پرداخت‌ها: $e'));
    }
  }

  @override
  Future<Either<Failure, List<PaymentEntity>>> getPaymentsByUserIdAndNickname(
    int userId,
    String nickname,
  ) async {
    try {
      final paymentModels = await _paymentDao.findPaymentsByUserIdAndNickname(
        userId,
        nickname,
      );
      final paymentEntities = paymentModels
          .map(PaymentMapper.toEntity)
          .toList();
      return Right(paymentEntities);
    } catch (e) {
      return Left(GeneralFailure('خطا در دریافت پرداخت‌های کاربر: $e'));
    }
  }
}

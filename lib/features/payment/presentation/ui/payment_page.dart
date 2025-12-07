import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'package:orbiq/core/shared/product/domain/entities/product_entity.dart';
import 'package:orbiq/features/auth/presentation/controller/auth_bloc.dart';
import 'package:orbiq/features/auth/presentation/controller/auth_state.dart';
import 'package:orbiq/features/payment/presentation/controller/cart_bloc.dart';
import 'package:orbiq/features/payment/presentation/controller/cart_event.dart';
import 'package:orbiq/features/payment/presentation/controller/cart_state.dart';
import 'package:orbiq/features/payment/presentation/controller/payment_bloc.dart';
import 'package:orbiq/features/payment/presentation/controller/payment_event.dart';
import 'package:orbiq/features/payment/presentation/controller/payment_state.dart';
import 'package:orbiq/features/payment/domain/entities/payment_entity.dart';
import 'package:orbiq/core/shared/currency/presentation/controller/currency_bloc.dart';
import 'package:orbiq/core/shared/currency/presentation/controller/currency_state.dart';
import 'package:orbiq/core/shared/currency/domain/entities/currency_code.dart';

class PaymentPage extends StatelessWidget {
  const PaymentPage({super.key});

  @override
  Widget build(BuildContext context) {
    final authState = context.watch<AuthBloc>().state;

    int userId;
    String userNickname;

    if (authState is AuthSuccess) {
      userId = authState.userId;
      userNickname = authState.user.nickname;
    } else {
      userId = 0;
      userNickname = 'کاربر ناشناس';
    }

    final NumberFormat currencyFormat = NumberFormat('#,##0');

    String formatPrice(double price) {
      final state = context.watch<CurrencyBloc>().state;
      if (state is CurrencyLoaded) {
        final rate = state.rates[state.selectedCurrency] ?? 1.0;
        final converted = price / rate;
        final isInt =
            state.selectedCurrency == CurrencyCode.toman ||
            state.selectedCurrency == CurrencyCode.rial ||
            state.selectedCurrency == CurrencyCode.dinar;
        final formatter = NumberFormat(isInt ? '#,##0' : '#,##0.##');
        return '${formatter.format(converted)} ${state.selectedCurrency.symbol}';
      }
      return '${currencyFormat.format(price)} تومان';
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('پرداخت'),
        backgroundColor: Colors.deepPurple,
      ),
      body: BlocConsumer<PaymentBloc, PaymentState>(
        listener: (context, state) {
          if (state is PaymentSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('پرداخت با موفقیت انجام شد'),
                backgroundColor: Colors.green,
              ),
            );

            context.read<CartBloc>().add(ClearCartEvent());

            Navigator.of(context).popUntil((route) => route.isFirst);
          } else if (state is PaymentFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('خطا در پرداخت: ${state.message}'),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is PaymentLoading) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.deepPurple),
            );
          }

          return BlocBuilder<CartBloc, CartState>(
            builder: (context, cartState) {
              List<ProductEntity> cartItems = [];
              if (cartState is CartUpdated) {
                cartItems = cartState.cartItems;
              }

              double totalPrice = cartItems.fold(
                0.0,
                (sum, item) => sum + item.originalPrice,
              );

              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'مبلغ کل: ${formatPrice(totalPrice)}',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Expanded(
                      child: ListView.builder(
                        itemCount: cartItems.length,
                        itemBuilder: (context, index) {
                          final product = cartItems[index];
                          return Card(
                            elevation: 4,
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            child: ListTile(
                              leading: const Icon(
                                Icons.shopping_bag,
                                color: Colors.deepPurple,
                              ),
                              title: Text(
                                product.name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'قیمت: ${formatPrice(product.originalPrice)}',
                                  ),
                                  Text('شماره سریال: ${product.serialNumber}'),
                                ],
                              ),
                              trailing: IconButton(
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                                onPressed: () {
                                  context.read<CartBloc>().add(
                                    RemoveFromCartEvent(product),
                                  );
                                },
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: cartItems.isEmpty
                            ? null
                            : () {
                                _handlePayment(
                                  context,
                                  userNickname,
                                  userId,
                                  cartItems,
                                  totalPrice,
                                );
                              },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurple,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                        child: const Text(
                          'تایید و پرداخت',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  void _handlePayment(
    BuildContext context,
    String userNickname,
    int userId,
    List<ProductEntity> cartItems,
    double totalPrice,
  ) {
    final productDetails = cartItems
        .map(
          (product) => {
            'name': product.name,
            'serialNumber': product.serialNumber,
          },
        )
        .toList();

    final paymentEntity = PaymentEntity(
      totalPrice: totalPrice,
      productDetails: productDetails,
      userId: userId,
      userNickname: userNickname,
      paymentDateTime: DateTime.now(),
    );

    context.read<PaymentBloc>().add(SavePaymentEvent(paymentEntity));
  }
}

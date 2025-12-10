// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:persian_datetime_picker/persian_datetime_picker.dart';
// import 'package:orbiq/features/exports/presentation/ui/export_widget.dart';
// import 'package:orbiq/features/payment/presentation/controller/payment_bloc.dart';
// import 'package:orbiq/features/payment/presentation/controller/payment_event.dart';
// import 'package:orbiq/features/payment/presentation/controller/payment_state.dart';

// class PaymentsReportPage extends StatefulWidget {
//   const PaymentsReportPage({super.key});

//   @override
//   PaymentsReportPageState createState() => PaymentsReportPageState();
// }

// class PaymentsReportPageState extends State<PaymentsReportPage> {
//   final TextEditingController _searchController = TextEditingController();
//   List<dynamic> _filteredPayments = [];

//   @override
//   void initState() {
//     super.initState();
//     context.read<PaymentBloc>().add(GetAllPaymentsEvent());
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: PreferredSize(
//         // تعیین ارتفاع استاندارد برای AppBar
//         preferredSize: const Size.fromHeight(kToolbarHeight),
//         child: BlocBuilder<PaymentBloc, PaymentState>(
//           builder: (context, state) {
//             List<dynamic> payments = [];
//             if (state is PaymentListLoaded) {
//               payments = state.payments;
//             }

//             return AppBar(
//               title: const Text('گزارش فاکتورها'),
//               elevation: 0,
//               actions: [
//                 if (payments.isNotEmpty)
//                   Padding(
//                     padding: const EdgeInsets.symmetric(
//                         horizontal: 8.0, vertical: 8.0),
//                     child: ExportWidget(
//                       data: payments
//                           .map((payment) => [
//                                 payment.id,
//                                 payment.productDetails
//                                     .map((product) =>
//                                         '${product['serialNumber']} - ${product['name']}')
//                                     .join('\n'),
//                                 payment.userNickname,
//                                 formatShamsiDateTimeWithHour(payment
//                                     .paymentDateTime.millisecondsSinceEpoch),
//                                 payment.totalPrice.toInt()
//                               ])
//                           .toList(),
//                       fileNamePrefix: 'payments',
//                     ),
//                   ),
//               ],
//             );
//           },
//         ),
//       ),
//       body: BlocConsumer<PaymentBloc, PaymentState>(
//         listener: (context, state) {
//           if (state is PaymentFailure) {
//             ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(content: Text(state.message)),
//             );
//           }
//         },
//         builder: (context, state) {
//           if (state is PaymentLoading) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (state is PaymentListLoaded) {
//             _filteredPayments = state.payments;
//             return Column(
//               children: [
//                 _buildSearchBar(),
//                 Expanded(
//                   child: _buildPaymentsList(),
//                 ),
//               ],
//             );
//           } else {
//             return const Center(child: Text('هیچ فاکتوری یافت نشد.'));
//           }
//         },
//       ),
//     );
//   }

//   Widget _buildSearchBar() {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: TextField(
//         controller: _searchController,
//         decoration: InputDecoration(
//           hintText: 'جستجو در فاکتورها...',
//           prefixIcon: const Icon(Icons.search),
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(20),
//           ),
//         ),
//         onChanged: (value) {
//           setState(() {
//             final currentState = BlocProvider.of<PaymentBloc>(context).state;
//             if (currentState is PaymentListLoaded) {
//               _filteredPayments = currentState.payments
//                   .where((payment) =>
//                       payment.id.toString().contains(value) ||
//                       payment.userNickname
//                           .toLowerCase()
//                           .contains(value.toLowerCase()))
//                   .toList();
//             }
//           });
//         },
//       ),
//     );
//   }

//   Widget _buildPaymentsList() {
//     return ListView.builder(
//       itemCount: _filteredPayments.length,
//       itemBuilder: (context, index) {
//         final payment = _filteredPayments[index];
//         return Card(
//           margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//           elevation: 2,
//           shape:
//               RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//           child: ListTile(
//             contentPadding: const EdgeInsets.all(16),
//             title: Text(
//               'فاکتور ${payment.id}',
//               style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
//             ),
//             subtitle: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const SizedBox(height: 8),
//                 Text('کاربر: ${payment.userNickname}'),
//                 Text(
//                     'تاریخ: ${formatShamsiDateTimeWithHour(payment.paymentDateTime.millisecondsSinceEpoch)}'),
//                 const SizedBox(height: 8),
//                 Text(
//                   'مبلغ: ${payment.totalPrice.toInt()} تومان',
//                   style: TextStyle(
//                     color: Theme.of(context).colorScheme.secondary,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ],
//             ),
//             trailing: IconButton(
//               icon: const Icon(Icons.remove_red_eye_outlined),
//               onPressed: () => _showPaymentDetailsDialog(context, payment),
//             ),
//           ),
//         );
//       },
//     );
//   }

//   void _showPaymentDetailsDialog(BuildContext context, dynamic payment) {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: Text('جزئیات فاکتور ${payment.id}'),
//           content: SingleChildScrollView(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 _buildDetailRow('مبلغ کل:', '${payment.totalPrice} تومان'),
//                 _buildDetailRow('کاربر:', payment.userNickname),
//                 _buildDetailRow(
//                     'تاریخ و ساعت فروش:',
//                     formatShamsiDateTimeWithHour(
//                         payment.paymentDateTime.millisecondsSinceEpoch)),
//                 const SizedBox(height: 16),
//                 const Text('لیست محصولات:',
//                     style: TextStyle(fontWeight: FontWeight.bold)),
//                 const SizedBox(height: 8),
//                 ...payment.productDetails.map(
//                   (product) => _buildProductRow(
//                       product['name'], product['serialNumber']),
//                 ),
//               ],
//             ),
//           ),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.pop(context),
//               child: const Text('بستن'),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   Widget _buildDetailRow(String label, String value) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 4),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text('$label ', style: const TextStyle(fontWeight: FontWeight.bold)),
//           Expanded(child: Text(value)),
//         ],
//       ),
//     );
//   }

//   Widget _buildProductRow(String name, String serialNumber) {
//     return Padding(
//       padding: const EdgeInsets.only(left: 16, bottom: 4),
//       child: Row(
//         children: [
//           const Icon(Icons.circle, size: 8),
//           const SizedBox(width: 8),
//           Expanded(
//             child: Text('$name - شماره سریال: $serialNumber'),
//           ),
//         ],
//       ),
//     );
//   }

//   String formatShamsiDateTimeWithHour(int millisecondsSinceEpoch) {
//     final date = DateTime.fromMillisecondsSinceEpoch(millisecondsSinceEpoch);
//     final shamsiDate = Jalali.fromDateTime(date);
//     return '${shamsiDate.year}/${shamsiDate.month}/${shamsiDate.day} ${date.hour}:${date.minute}';
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:orbiq/features/exports/presentation/ui/export_widget.dart';
import 'package:orbiq/features/payment/presentation/controller/payment_bloc.dart';
import 'package:orbiq/features/payment/presentation/controller/payment_event.dart';
import 'package:orbiq/features/payment/presentation/controller/payment_state.dart';
import 'package:orbiq/core/shared/localization/l10n/app_localizations.dart';

class PaymentsReportPage extends StatefulWidget {
  const PaymentsReportPage({super.key});

  @override
  PaymentsReportPageState createState() => PaymentsReportPageState();
}

class PaymentsReportPageState extends State<PaymentsReportPage> {
  final TextEditingController _searchController = TextEditingController();
  List<dynamic> _filteredPayments = [];

  @override
  void initState() {
    super.initState();
    context.read<PaymentBloc>().add(GetAllPaymentsEvent());
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: BlocBuilder<PaymentBloc, PaymentState>(
          builder: (context, state) {
            List<dynamic> loadedPayments = [];

            if (state is PaymentListLoaded) {
              loadedPayments = state.payments;
            }

            return AppBar(
              title: Text(l10n.invoiceReport),
              elevation: 0,
              actions: [
                if (loadedPayments.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8.0,
                      vertical: 8.0,
                    ),
                    child: ExportWidget(
                      data: _buildExportDataFromPayments(loadedPayments),
                      fileNamePrefix: 'payments',
                    ),
                  ),
              ],
            );
          },
        ),
      ),
      body: BlocConsumer<PaymentBloc, PaymentState>(
        listener: (context, state) {
          if (state is PaymentFailure) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          if (state is PaymentLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is PaymentLoadingPage) {
            // Show loading indicator but keep the old list visible if desired
            // For simplicity, we can reuse the full loading indicator or show a specific one
            return const Center(
              child: CircularProgressIndicator(color: Colors.amber),
            );
          } else if (state is PaymentListLoaded) {
            // Update _filteredPayments with the current page's data
            // If search text exists, re-apply filter, otherwise show all current page items
            if (_searchController.text.isEmpty) {
              _filteredPayments = state.payments;
            } else {
              // Re-apply search to the new page's data
              _filteredPayments = state.payments.where((payment) {
                final idMatch = payment.id.toString().contains(
                  _searchController.text,
                );
                final userMatch = payment.userNickname.toLowerCase().contains(
                  _searchController.text.toLowerCase(),
                );
                return idMatch || userMatch;
              }).toList();
            }

            return Column(
              children: [
                _buildSearchBar(l10n),
                Expanded(
                  child:
                      _filteredPayments.isEmpty &&
                          _searchController.text.isNotEmpty
                      ? Center(child: Text(l10n.noInvoiceFoundWithSearch))
                      : _filteredPayments.isEmpty &&
                            _searchController.text.isEmpty
                      ? Center(child: Text(l10n.noInvoiceFoundOnPage))
                      : _buildPaymentsList(l10n),
                ),
                _buildPaginationControls(
                  state.currentPage,
                  state.totalPages,
                  state.hasNextPage,
                  l10n,
                ),
              ],
            );
          } else if (state is PaymentFailure) {
            return Center(
              child: Text('${l10n.errorLoadingInvoices} ${state.message}'),
            );
          } else {
            // Handles PaymentInitial or other unhandled states
            return Center(child: Text(l10n.loadReportToView));
          }
        },
      ),
    );
  }

  List<List<dynamic>> _buildExportDataFromPayments(List<dynamic> payments) {
    return payments.map((payment) {
      final productDetails = payment.productDetails
          .map((product) => '${product['serialNumber']} - ${product['name']}')
          .join('\n');

      return [
        payment.id,
        productDetails,
        payment.userNickname,
        formatShamsiDateTimeWithHour(
          payment.paymentDateTime.millisecondsSinceEpoch,
        ),
        payment.totalPrice.toInt(),
      ];
    }).toList();
  }

  Widget _buildSearchBar(AppLocalizations l10n) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          hintText: l10n.searchInInvoices,
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
        ),
        onChanged: (value) {
          setState(() {
            final currentState = BlocProvider.of<PaymentBloc>(context).state;
            if (currentState is PaymentListLoaded) {
              if (value.isEmpty) {
                _filteredPayments = currentState.payments;
              } else {
                _filteredPayments = currentState.payments.where((payment) {
                  final idMatch = payment.id.toString().contains(value);
                  final userMatch = payment.userNickname.toLowerCase().contains(
                    value.toLowerCase(),
                  );
                  return idMatch || userMatch;
                }).toList();
              }
            }
          });
        },
      ),
    );
  }

  Widget _buildPaymentsList(AppLocalizations l10n) {
    return ListView.builder(
      itemCount: _filteredPayments.length,
      itemBuilder: (context, index) {
        final payment = _filteredPayments[index];
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.all(16),
            title: Text(
              '${l10n.invoiceNumber} ${payment.id}',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8),
                Text('${l10n.userLabel} ${payment.userNickname}'),
                Text(
                  '${l10n.dateLabel} ${formatShamsiDateTimeWithHour(payment.paymentDateTime.millisecondsSinceEpoch)}',
                ),
                const SizedBox(height: 8),
                Text(
                  '${l10n.amountLabel} ${payment.totalPrice.toInt()} ${l10n.currency}',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            trailing: IconButton(
              icon: const Icon(Icons.remove_red_eye_outlined),
              onPressed: () =>
                  _showPaymentDetailsDialog(context, payment, l10n),
            ),
          ),
        );
      },
    );
  }

  void _showPaymentDetailsDialog(
    BuildContext context,
    dynamic payment,
    AppLocalizations l10n,
  ) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('${l10n.invoiceDetails} ${payment.id}'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildDetailRow(
                  l10n.totalAmount,
                  '${payment.totalPrice} ${l10n.currency}',
                ),
                _buildDetailRow(l10n.userLabel, payment.userNickname),
                _buildDetailRow(
                  l10n.salesDateTime,
                  formatShamsiDateTimeWithHour(
                    payment.paymentDateTime.millisecondsSinceEpoch,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  l10n.productsList,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                ...payment.productDetails.map(
                  (product) => _buildProductRow(
                    product['name'],
                    product['serialNumber'],
                    l10n,
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(l10n.close),
            ),
          ],
        );
      },
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('$label ', style: const TextStyle(fontWeight: FontWeight.bold)),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }

  Widget _buildProductRow(
    String name,
    String serialNumber,
    AppLocalizations l10n,
  ) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, bottom: 4),
      child: Row(
        children: [
          const Icon(Icons.circle, size: 8),
          const SizedBox(width: 8),
          Expanded(
            child: Text('$name - ${l10n.serialNumberLabel} $serialNumber'),
          ),
        ],
      ),
    );
  }

  String formatShamsiDateTimeWithHour(int millisecondsSinceEpoch) {
    final date = DateTime.fromMillisecondsSinceEpoch(millisecondsSinceEpoch);
    final shamsiDate = Jalali.fromDateTime(date);
    return '${shamsiDate.year}/${shamsiDate.month}/${shamsiDate.day} ${date.hour}:${date.minute}';
  }

  Widget _buildPaginationControls(
    int currentPage,
    int totalPages,
    bool hasNextPage,
    AppLocalizations l10n,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ElevatedButton(
            onPressed: currentPage > 1
                ? () {
                    // Clear search when changing page or decide if search should persist
                    // _searchController.clear();
                    context.read<PaymentBloc>().add(
                      LoadPaymentPageEvent(currentPage - 1),
                    );
                  }
                : null,
            child: Text(l10n.previousPage),
          ),
          Text(l10n.pageOf(currentPage.toString(), totalPages.toString())),
          ElevatedButton(
            onPressed: hasNextPage
                ? () {
                    // _searchController.clear();
                    context.read<PaymentBloc>().add(
                      LoadPaymentPageEvent(currentPage + 1),
                    );
                  }
                : null,
            child: Text(l10n.nextPage),
          ),
        ],
      ),
    );
  }
}

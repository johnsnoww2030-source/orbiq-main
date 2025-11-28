// //cart_grid

// import 'dart:math';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:orbiq/core/shared/product/data/models/product_model.dart';

// class CartGrid extends StatelessWidget {
//   final List<ProductModel> cartItems;
//   final int crossAxisCount;
//   final double screenWidth;
//   final Function(ProductModel product, int index) onDelete;

//   CartGrid({
//     super.key,
//     required this.cartItems,
//     required this.crossAxisCount,
//     required this.screenWidth,
//     required this.onDelete,
//   });

//   final NumberFormat currencyFormat = NumberFormat('#,##0');

//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: GridView.builder(
//           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//             crossAxisCount: crossAxisCount,
//             crossAxisSpacing: 10.0,
//             mainAxisSpacing: 10.0,
//             childAspectRatio: 0.8,
//           ),
//           itemCount: cartItems.length,
//           itemBuilder: (context, index) {
//             final product = cartItems[index];
//             return Card(
//               elevation: 4,
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text('نام: ${product.name}', style: const TextStyle(fontWeight: FontWeight.bold)),
//                     Text('شماره سریال: ${product.serialNumber}'),
//                     Text('مدل: ${product.model}'),
//                     Text('رنگ: ${product.color}'),
//                     Text('جنس: ${product.material}'),
//                     Text('سایز: ${product.description}'),
//                     Text('قیمت: ${currencyFormat.format(product.originalPrice.toInt())} تومان'),
//                     const Spacer(),
//                     Align(
//                       alignment: Alignment.bottomRight,
//                       child: IconButton(
//                         iconSize: min(screenWidth * 0.05, 24.0),
//                         icon: const Icon(Icons.delete),
//                         onPressed: () {
//                           onDelete(product, index);
//                         },
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }

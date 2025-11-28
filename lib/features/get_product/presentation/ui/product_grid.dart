// //product_grid
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:orbiq/core/shared/product/data/models/product_model.dart';

// class ProductGrid extends StatelessWidget {
//   final List<ProductModel> products;
//   final int crossAxisCount;

//   ProductGrid({super.key, required this.products, required this.crossAxisCount});

//   final NumberFormat currencyFormat = NumberFormat('#,##0');

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(16),
//       child: GridView.builder(
//         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: crossAxisCount,
//           crossAxisSpacing: 10.0,
//           mainAxisSpacing: 10.0,
//           childAspectRatio: 0.8,
//         ),
//         itemCount: products.length,
//         itemBuilder: (context, index) {
//           final product = products[index];
//           return Card(
//             elevation: 4,
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text('نام: ${product.name}', style: const TextStyle(fontWeight: FontWeight.bold)),
//                   Text('شماره سریال: ${product.serialNumber}'),
//                   Text('مدل: ${product.model}'),
//                   Text('رنگ: ${product.color}'),
//                   Text('جنس: ${product.material}'),
//                   Text('سایز: ${product.description}'),
//                   Text('قیمت: ${currencyFormat.format(product.originalPrice.toInt())} تومان'),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

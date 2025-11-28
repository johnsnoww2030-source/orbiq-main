import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orbiq/core/shared/product/data/models/product_model.dart';
import 'package:orbiq/features/add_product/presentation/controllers/bloc/product_bloc.dart';
import 'package:orbiq/features/add_product/presentation/controllers/bloc/product_event.dart';
import 'package:orbiq/features/add_product/presentation/controllers/bloc/product_state.dart';

class EditProductPage extends StatefulWidget {
  final ProductModel product;

  const EditProductPage({super.key, required this.product});

  @override
  State<EditProductPage> createState() => _EditProductPageState();
}

class _EditProductPageState extends State<EditProductPage> {
  final _formKey = GlobalKey<FormState>();

  // کنترلرهای فیلدها
  late TextEditingController _nameController;
  late TextEditingController _serialNumberController;
  late TextEditingController _originalPriceController;
  late TextEditingController _modelController;
  late TextEditingController _colorController;
  late TextEditingController _materialController;
  late TextEditingController _currentStockController;
  late TextEditingController _descriptionController;
  late TextEditingController _brandController;
  late TextEditingController _reorderPointController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.product.name);
    _serialNumberController =
        TextEditingController(text: widget.product.serialNumber);
    _originalPriceController =
        TextEditingController(text: widget.product.originalPrice.toString());
    _modelController = TextEditingController(text: widget.product.model);
    _colorController = TextEditingController(text: widget.product.color);
    _materialController = TextEditingController(text: widget.product.material);
    _currentStockController =
        TextEditingController(text: widget.product.currentStock.toString());
    _descriptionController =
        TextEditingController(text: widget.product.description);
    _brandController = TextEditingController(text: widget.product.brand);
    _reorderPointController =
        TextEditingController(text: widget.product.reorderPoint.toString());
  }

  @override
  void dispose() {
    _nameController.dispose();
    _serialNumberController.dispose();
    _originalPriceController.dispose();
    _modelController.dispose();
    _colorController.dispose();
    _materialController.dispose();
    _currentStockController.dispose();
    _descriptionController.dispose();
    _brandController.dispose();
    _reorderPointController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProductBloc, ProductState>(
      listener: (context, state) {
        if (state is ProductUpdatedSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('محصول با موفقیت به‌روزرسانی شد!'),
              // backgroundColor: Colors.green,
            ),
          );
          Navigator.of(context).pop(true);
        } else if (state is ProductError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('خطا در به‌روزرسانی محصول: ${state.message}'),
              // backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('ویرایش محصول'),
          centerTitle: true,
          elevation: 0,
          // backgroundColor: Colors.deepPurple,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                _buildMainInfoCard(),
                const SizedBox(height: 16),
                _buildAdditionalInfoCard(),
                const SizedBox(height: 24),
                _buildSubmitButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMainInfoCard() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'اطلاعات اصلی محصول',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Colors.deepPurple,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),
            _buildTripleTextField(
              controller1: _nameController,
              label1: 'نام محصول',
              validator1: (value) =>
                  value!.isEmpty ? 'لطفاً نام محصول را وارد کنید' : null,
              controller2: _serialNumberController,
              label2: 'شماره سریال',
              validator2: (value) =>
                  value!.isEmpty ? 'لطفاً شماره سریال را وارد کنید' : null,
              keyboardType2: TextInputType.number,
              controller3: _originalPriceController,
              label3: 'قیمت (تومان)',
              validator3: (value) =>
                  value!.isEmpty ? 'لطفاً قیمت را وارد کنید' : null,
              keyboardType3: TextInputType.number,
            ),
            const SizedBox(height: 16),
            _buildDoubleTextField(
              controller1: _modelController,
              label1: 'مدل',
              validator1: (value) =>
                  value!.isEmpty ? 'لطفاً مدل را وارد کنید' : null,
              controller2: _colorController,
              label2: 'رنگ',
              validator2: (value) =>
                  value!.isEmpty ? 'لطفاً رنگ را وارد کنید' : null,
            ),
            const SizedBox(height: 16),
            _buildDoubleTextField(
              controller1: _materialController,
              label1: 'جنس',
              validator1: (value) =>
                  value!.isEmpty ? 'لطفاً جنس را وارد کنید' : null,
              controller2: _currentStockController,
              label2: 'موجودی فعلی',
              validator2: (value) =>
                  value!.isEmpty ? 'لطفاً موجودی را وارد کنید' : null,
              keyboardType2: TextInputType.number,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAdditionalInfoCard() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: ExpansionTile(
          title: Text(
            'اطلاعات تکمیلی',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Colors.deepPurple,
                  fontWeight: FontWeight.bold,
                ),
          ),
          children: [
            _buildSingleTextField(
              controller: _descriptionController,
              label: 'سایز',
              validator: (value) =>
                  value!.isEmpty ? 'لطفاً سایز را وارد کنید' : null,
            ),
            const SizedBox(height: 16),
            _buildSingleTextField(
              controller: _brandController,
              label: 'برند',
              validator: (value) =>
                  value!.isEmpty ? 'لطفاً برند را وارد کنید' : null,
            ),
            const SizedBox(height: 16),
            _buildSingleTextField(
              controller: _reorderPointController,
              label: 'نقطه سفارش مجدد',
              validator: (value) =>
                  value!.isEmpty ? 'لطفاً نقطه سفارش مجدد را وارد کنید' : null,
              keyboardType: TextInputType.number,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTripleTextField({
    required TextEditingController controller1,
    required String label1,
    required String? Function(String?)? validator1,
    TextInputType? keyboardType1,
    required TextEditingController controller2,
    required String label2,
    required String? Function(String?)? validator2,
    TextInputType? keyboardType2,
    required TextEditingController controller3,
    required String label3,
    required String? Function(String?)? validator3,
    TextInputType? keyboardType3,
  }) {
    return Row(
      children: [
        Expanded(
          child: _buildTextField(
            controller: controller1,
            label: label1,
            validator: validator1,
            keyboardType: keyboardType1,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: _buildTextField(
            controller: controller2,
            label: label2,
            validator: validator2,
            keyboardType: keyboardType2,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: _buildTextField(
            controller: controller3,
            label: label3,
            validator: validator3,
            keyboardType: keyboardType3,
          ),
        ),
      ],
    );
  }

  Widget _buildDoubleTextField({
    required TextEditingController controller1,
    required String label1,
    required String? Function(String?)? validator1,
    TextInputType? keyboardType1,
    required TextEditingController controller2,
    required String label2,
    required String? Function(String?)? validator2,
    TextInputType? keyboardType2,
  }) {
    return Row(
      children: [
        Expanded(
          child: _buildTextField(
            controller: controller1,
            label: label1,
            validator: validator1,
            keyboardType: keyboardType1,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildTextField(
            controller: controller2,
            label: label2,
            validator: validator2,
            keyboardType: keyboardType2,
          ),
        ),
      ],
    );
  }

  Widget _buildSingleTextField({
    required TextEditingController controller,
    required String label,
    required String? Function(String?)? validator,
    TextInputType? keyboardType,
  }) {
    return _buildTextField(
      controller: controller,
      label: label,
      validator: validator,
      keyboardType: keyboardType,
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String? Function(String?)? validator,
    TextInputType? keyboardType,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
          filled: true,
          fillColor: Colors.grey.shade100,
        ),
        validator: validator,
        keyboardType: keyboardType,
      ),
    );
  }

  Widget _buildSubmitButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _submitForm,
        style: ElevatedButton.styleFrom(
          // backgroundColor: Colors.deepPurple,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        child: const Text(
          'ذخیره تغییرات',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            // color: Colors.white,
          ),
        ),
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final updatedProduct = widget.product.copyWith(
        name: _nameController.text,
        serialNumber: _serialNumberController.text,
        originalPrice: double.parse(_originalPriceController.text),
        model: _modelController.text,
        color: _colorController.text,
        material: _materialController.text,
        currentStock: int.parse(_currentStockController.text),
        description: _descriptionController.text,
        brand: _brandController.text,
        reorderPoint: int.parse(_reorderPointController.text),
      );

      context
          .read<ProductBloc>()
          .add(UpdateProductEvent(updatedProduct.toEntity()));
    }
  }
}

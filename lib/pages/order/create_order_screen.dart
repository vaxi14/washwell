import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateOrderScreen extends StatefulWidget {
  const CreateOrderScreen({super.key});

  @override
  State<CreateOrderScreen> createState() => _CreateOrderScreenState();
}

class _CreateOrderScreenState extends State<CreateOrderScreen> {
  // Selected services list
  final List<SelectedService> _selectedServices = [];

  // Controllers for input fields
  final Map<String, TextEditingController> _controllers = {};

  // Prices for each service
  final Map<String, double> _servicePrices = {
    'wash': 50.0,
    'iron': 30.0,
    'dry': 40.0,
    'clean': 80.0,
  };

  @override
  void initState() {
    super.initState();
    // Initialize controllers for all services
    _servicePrices.keys.forEach((service) {
      _controllers[service] = TextEditingController(text: '1');
    });
  }

  @override
  void dispose() {
    // Dispose all controllers
    _controllers.values.forEach((controller) => controller.dispose());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: const Icon(Icons.arrow_back, color: Colors.black87),
        ),
        title: const Text(
          'Create Order',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  _buildHeader(),
                  
                  const SizedBox(height: 24),
                  
                  // Services Selection
                  _buildServicesSelection(),
                  
                  const SizedBox(height: 24),
                  
                  // Selected Services Chips
                  _buildSelectedServicesChips(),
                  
                  const SizedBox(height: 24),
                  
                  // Service-specific Input Fields
                  _buildServiceInputFields(),
                  
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
          
          // Bottom Price Summary & Button
          _buildBottomSummary(),
        ],
      ),
    );
  }

  // Header Section
  Widget _buildHeader() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Select Services',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 8),
        Text(
          'Choose services and specify quantities',
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  // Services Selection Grid
  Widget _buildServicesSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Available Services',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 12),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 1.2,
          children: [
            _buildServiceCard(
              'Wash',
              Icons.local_laundry_service,
              Colors.blue,
              'From ₹${_servicePrices['wash']!.toInt()}',
            ),
            _buildServiceCard(
              'Iron',
              Icons.iron,
              Colors.green,
              'From ₹${_servicePrices['iron']!.toInt()}',
            ),
            _buildServiceCard(
              'Dry',
              Icons.ac_unit,
              Colors.orange,
              'From ₹${_servicePrices['dry']!.toInt()}',
            ),
            _buildServiceCard(
              'Clean',
              Icons.cleaning_services,
              Colors.purple,
              'From ₹${_servicePrices['clean']!.toInt()}',
            ),
          ],
        ),
      ],
    );
  }

  // Individual Service Card
  Widget _buildServiceCard(String name, IconData icon, Color color, String price) {
    final isSelected = _selectedServices.any((service) => service.name.toLowerCase() == name.toLowerCase());
    
    return GestureDetector(
      onTap: () => _toggleService(name),
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? color.withOpacity(0.1) : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? color : Colors.grey.shade300,
            width: isSelected ? 2 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 28),
            ),
            const SizedBox(height: 8),
            Text(
              name,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: isSelected ? color : Colors.black87,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              price,
              style: TextStyle(
                fontSize: 12,
                color: isSelected ? color : Colors.grey.shade600,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Selected Services Chips
  Widget _buildSelectedServicesChips() {
    if (_selectedServices.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.grey.shade50,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: const Center(
          child: Text(
            'No services selected\nTap on services above to add',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey),
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Selected Services',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: _selectedServices.map((service) => Chip(
            label: Text(service.name),
            deleteIcon: const Icon(Icons.close, size: 18),
            onDeleted: () => _removeService(service.name),
            backgroundColor: _getServiceColor(service.name).withOpacity(0.1),
            labelStyle: TextStyle(
              color: _getServiceColor(service.name),
              fontWeight: FontWeight.w600,
            ),
          )).toList(),
        ),
      ],
    );
  }

  // Service-specific Input Fields
  Widget _buildServiceInputFields() {
    if (_selectedServices.isEmpty) {
      return const SizedBox();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Service Details',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 16),
        ..._selectedServices.map((service) => _buildServiceInputField(service)),
      ],
    );
  }

  // Individual Service Input Field
  Widget _buildServiceInputField(SelectedService service) {
    final serviceKey = service.name.toLowerCase();
    
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                _getServiceIcon(service.name),
                color: _getServiceColor(service.name),
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                service.name,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: _getServiceColor(service.name),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _buildQuantityInput(service),
        ],
      ),
    );
  }

  // Quantity Input Field
  Widget _buildQuantityInput(SelectedService service) {
    final serviceKey = service.name.toLowerCase();
    
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            controller: _controllers[serviceKey],
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: _getInputLabel(service.name),
              hintText: _getInputHint(service.name),
              border: const OutlineInputBorder(),
              suffixText: _getInputSuffix(service.name),
            ),
            onChanged: (value) {
              setState(() {
                // Update quantity and recalculate price
                final quantity = double.tryParse(value) ?? 0;
                _updateServiceQuantity(service.name, quantity);
              });
            },
          ),
        ),
        const SizedBox(width: 12),
        Column(
          children: [
            // Increment Button
            GestureDetector(
              onTap: () => _adjustQuantity(service.name, 1),
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: Colors.green.shade200),
                ),
                child: const Icon(Icons.add, size: 18, color: Colors.green),
              ),
            ),
            const SizedBox(height: 4),
            // Decrement Button
            GestureDetector(
              onTap: () => _adjustQuantity(service.name, -1),
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.red.shade50,
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: Colors.red.shade200),
                ),
                child: const Icon(Icons.remove, size: 18, color: Colors.red),
              ),
            ),
          ],
        ),
      ],
    );
  }

  // Bottom Price Summary
  Widget _buildBottomSummary() {
    final totalAmount = _calculateTotal();
    
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.grey.shade300)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Price Breakdown
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Subtotal', style: TextStyle(fontSize: 16)),
              Text('₹${totalAmount.toStringAsFixed(2)}', 
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Service Fee', style: TextStyle(fontSize: 14, color: Colors.grey)),
              Text('₹30.00', style: const TextStyle(fontSize: 14, color: Colors.grey)),
            ],
          ),
          const SizedBox(height: 8),
          const Divider(height: 1),
          const SizedBox(height: 12),
          // Total Amount
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Total Amount',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                '₹${(totalAmount + 30).toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Continue Button
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: _selectedServices.isEmpty ? null : _proceedToNext,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Continue to Details',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ==================== HELPER METHODS ====================

  // Toggle service selection
  void _toggleService(String serviceName) {
    setState(() {
      final serviceKey = serviceName.toLowerCase();
      final existingIndex = _selectedServices.indexWhere(
        (s) => s.name.toLowerCase() == serviceKey
      );
      
      if (existingIndex >= 0) {
        _selectedServices.removeAt(existingIndex);
      } else {
        _selectedServices.add(SelectedService(
          name: serviceName,
          quantity: 1,
          price: _servicePrices[serviceKey] ?? 0,
        ));
      }
    });
  }

  // Remove service
  void _removeService(String serviceName) {
    setState(() {
      _selectedServices.removeWhere((s) => s.name.toLowerCase() == serviceName.toLowerCase());
    });
  }

  // Update service quantity
  void _updateServiceQuantity(String serviceName, double quantity) {
    final index = _selectedServices.indexWhere(
      (s) => s.name.toLowerCase() == serviceName.toLowerCase()
    );
    
    if (index >= 0) {
      setState(() {
        _selectedServices[index] = _selectedServices[index].copyWith(
          quantity: quantity > 0 ? quantity : 1,
        );
      });
    }
  }

  // Adjust quantity with buttons
  void _adjustQuantity(String serviceName, int change) {
    final serviceKey = serviceName.toLowerCase();
    final currentValue = double.tryParse(_controllers[serviceKey]!.text) ?? 1;
    final newValue = currentValue + change;
    
    if (newValue >= 1) {
      _controllers[serviceKey]!.text = newValue.toInt().toString();
      _updateServiceQuantity(serviceName, newValue.toDouble());
    }
  }

  // Calculate total amount
  double _calculateTotal() {
    return _selectedServices.fold(0.0, (sum, service) {
      return sum + (service.price * service.quantity);
    });
  }

  // Proceed to next screen
  void _proceedToNext() {
    final totalAmount = _calculateTotal() + 30; // Including service fee
    
    Get.toNamed('/order-details', arguments: {
      'selectedServices': _selectedServices,
      'totalAmount': totalAmount,
    });
  }

  // Get service color
  Color _getServiceColor(String serviceName) {
    switch (serviceName.toLowerCase()) {
      case 'wash': return Colors.blue;
      case 'iron': return Colors.green;
      case 'dry': return Colors.orange;
      case 'clean': return Colors.purple;
      default: return Colors.grey;
    }
  }

  // Get service icon
  IconData _getServiceIcon(String serviceName) {
    switch (serviceName.toLowerCase()) {
      case 'wash': return Icons.local_laundry_service;
      case 'iron': return Icons.iron;
      case 'dry': return Icons.ac_unit;
      case 'clean': return Icons.cleaning_services;
      default: return Icons.help_outline;
    }
  }

  // Get input label based on service
  String _getInputLabel(String serviceName) {
    switch (serviceName.toLowerCase()) {
      case 'wash': return 'Weight (kg)';
      case 'iron': return 'Number of Items';
      case 'dry': return 'Weight (kg)';
      case 'clean': return 'Number of Items';
      default: return 'Quantity';
    }
  }

  // Get input hint based on service
  String _getInputHint(String serviceName) {
    switch (serviceName.toLowerCase()) {
      case 'wash': return 'Enter weight in kg';
      case 'iron': return 'Enter number of items';
      case 'dry': return 'Enter weight in kg';
      case 'clean': return 'Enter number of items';
      default: return 'Enter quantity';
    }
  }

  // Get input suffix based on service
  String _getInputSuffix(String serviceName) {
    switch (serviceName.toLowerCase()) {
      case 'wash': return 'kg';
      case 'dry': return 'kg';
      default: return 'items';
    }
  }
}

// Selected Service Model
class SelectedService {
  final String name;
  final double quantity;
  final double price;

  SelectedService({
    required this.name,
    required this.quantity,
    required this.price,
  });

  SelectedService copyWith({
    String? name,
    double? quantity,
    double? price,
  }) {
    return SelectedService(
      name: name ?? this.name,
      quantity: quantity ?? this.quantity,
      price: price ?? this.price,
    );
  }

  double get total => price * quantity;
}
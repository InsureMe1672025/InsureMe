import 'package:flutter/material.dart';
import 'package:insure_me/utils/app_colors.dart';
import 'package:insure_me/widgets/auth/auth_background.dart';
import 'package:insure_me/screens/quotes/quote_results_screen.dart';

class QuoteFormScreen extends StatefulWidget {
  const QuoteFormScreen({super.key});

  @override
  State<QuoteFormScreen> createState() => _QuoteFormScreenState();
}

class _QuoteFormScreenState extends State<QuoteFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _vehicleValueController = TextEditingController();
  final _ccHpController = TextEditingController();
  
  bool _isNewVehicle = true;
  String _coverType = 'Comprehensive Plus';
  String _paymentMode = 'Installment';
  String _vehicleType = 'Private Car';
  String _bodyType = 'JEEP';
  String _registrationMonth = 'January';
  String _modelYear = '2025';
  String _policyStartDate = '2025-7-15';
  
  // Additional cover options
  final Map<String, bool> _additionalCover = {
    'Third Party Property Damages': true,
    'Third Party bodily Injury': true,
    'Loss or Damage of Vehicle': true,
    'Emergency Treatment Cover': true,
    'Car Replacement Cover': true,
    'Road Assist Cover': true,
    'Agency Repair': true,
    'Personal Accident': false,
    'Geographical Extension': false,
    'Natural Perils': true,
    'RSMD COVER': false,
    'Windshield Cover': true,
    'VIP Cover': false,
    'Passenger Risk Cover': false,
    'Windows Cover': true,
    'Working Risk': true,
  };
  
  String _replacementVehicleType = 'Small';
  String _replacementDays = '8 Days';
  bool _isBelow24 = false;

  @override
  void dispose() {
    _vehicleValueController.dispose();
    _ccHpController.dispose();
    super.dispose();
  }

  void _calculateQuote() {
    if (_formKey.currentState!.validate()) {
      // Navigate to results screen
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => QuoteResultsScreen(
            vehicleValue: _vehicleValueController.text,
            isNewVehicle: _isNewVehicle,
            coverType: _coverType,
            paymentMode: _paymentMode,
            vehicleType: _vehicleType,
            bodyType: _bodyType,
            registrationMonth: _registrationMonth,
            modelYear: _modelYear,
            policyStartDate: _policyStartDate,
            ccHp: _ccHpController.text,
            additionalCover: _additionalCover,
            replacementVehicleType: _replacementVehicleType,
            replacementDays: _replacementDays,
            isBelow24: _isBelow24,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Get Motor Quote'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      body: AuthBackground(
        backgroundImage: "assets/images/homebackground.png",
        backgroundColor: Colors.white,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Get Motor Quote',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryDark,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  
                  // Vehicle Value
                  const Text(
                    'Vehicle Value',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: AppColors.primaryDark,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _vehicleValueController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter vehicle value';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  
                  // Is your vehicle brand new?
                  const Text(
                    'Is your vehicle brand new?',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: AppColors.primaryDark,
                    ),
                  ),
                  Row(
                    children: [
                      Radio<bool>(
                        value: true,
                        groupValue: _isNewVehicle,
                        onChanged: (value) {
                          setState(() {
                            _isNewVehicle = value!;
                          });
                        },
                      ),
                      const Text('Yes'),
                      const SizedBox(width: 24),
                      Radio<bool>(
                        value: false,
                        groupValue: _isNewVehicle,
                        onChanged: (value) {
                          setState(() {
                            _isNewVehicle = value!;
                          });
                        },
                      ),
                      const Text('No'),
                    ],
                  ),
                  const SizedBox(height: 16),
                  
                  // Cover
                  const Text(
                    'Cover',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: AppColors.primaryDark,
                    ),
                  ),
                  Row(
                    children: [
                      Radio<String>(
                        value: 'Third Party',
                        groupValue: _coverType,
                        onChanged: (value) {
                          setState(() {
                            _coverType = value!;
                          });
                        },
                      ),
                      const Text('Third Party'),
                      const SizedBox(width: 24),
                      Radio<String>(
                        value: 'Comprehensive Plus',
                        groupValue: _coverType,
                        onChanged: (value) {
                          setState(() {
                            _coverType = value!;
                          });
                        },
                      ),
                      const Text('Comprehensive Plus'),
                    ],
                  ),
                  const SizedBox(height: 16),
                  
                  // Mode of Payment
                  const Text(
                    'Mode of Payment',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: AppColors.primaryDark,
                    ),
                  ),
                  Row(
                    children: [
                      Radio<String>(
                        value: 'Cash',
                        groupValue: _paymentMode,
                        onChanged: (value) {
                          setState(() {
                            _paymentMode = value!;
                          });
                        },
                      ),
                      const Text('Cash'),
                      const SizedBox(width: 24),
                      Radio<String>(
                        value: 'Installment',
                        groupValue: _paymentMode,
                        onChanged: (value) {
                          setState(() {
                            _paymentMode = value!;
                          });
                        },
                      ),
                      const Text('Installment'),
                    ],
                  ),
                  const SizedBox(height: 16),
                  
                  // Type of Vehicle
                  const Text(
                    'Type of Vehicle',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: AppColors.primaryDark,
                    ),
                  ),
                  const SizedBox(height: 8),
                  _buildDropdown(
                    value: _vehicleType,
                    items: const ['Private Car', 'Commercial Vehicle', 'Motorcycle'],
                    onChanged: (value) {
                      setState(() {
                        _vehicleType = value!;
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                  
                  // Type of Body
                  const Text(
                    'Type of Body',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: AppColors.primaryDark,
                    ),
                  ),
                  const SizedBox(height: 8),
                  _buildDropdown(
                    value: _bodyType,
                    items: const ['JEEP', 'Sedan', 'SUV', 'Hatchback', 'Pickup'],
                    onChanged: (value) {
                      setState(() {
                        _bodyType = value!;
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                  
                  // Registration Month
                  const Text(
                    'Registration Month',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: AppColors.primaryDark,
                    ),
                  ),
                  const SizedBox(height: 8),
                  _buildDropdown(
                    value: _registrationMonth,
                    items: const [
                      'January', 'February', 'March', 'April', 'May', 'June',
                      'July', 'August', 'September', 'October', 'November', 'December'
                    ],
                    onChanged: (value) {
                      setState(() {
                        _registrationMonth = value!;
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                  
                  // Model year
                  const Text(
                    'Model year',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: AppColors.primaryDark,
                    ),
                  ),
                  const SizedBox(height: 8),
                  _buildDropdown(
                    value: _modelYear,
                    items: List.generate(11, (index) => (2025 - index).toString()),
                    onChanged: (value) {
                      setState(() {
                        _modelYear = value!;
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                  
                  // Policy Start Date
                  const Text(
                    'Policy Start Date',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: AppColors.primaryDark,
                    ),
                  ),
                  const SizedBox(height: 8),
                  _buildDropdown(
                    value: _policyStartDate,
                    items: const ['2025-7-15', '2025-7-16', '2025-7-17', '2025-7-18', '2025-7-19'],
                    onChanged: (value) {
                      setState(() {
                        _policyStartDate = value!;
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                  
                  // CC/HP
                  const Text(
                    'CC/HP',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: AppColors.primaryDark,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _ccHpController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter CC/HP';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 24),
                  
                  // Additional Cover
                  const Text(
                    'Additional Cover',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryDark,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ..._additionalCover.entries.map((entry) => _buildCheckboxItem(entry.key, entry.value, (value) {
                    setState(() {
                      _additionalCover[entry.key] = value!;
                    });
                  })).toList(),
                  const SizedBox(height: 16),
                  
                  // Type of replacement vehicle
                  const Text(
                    'Type of replacement vehicle',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: AppColors.primaryDark,
                    ),
                  ),
                  const SizedBox(height: 8),
                  _buildDropdown(
                    value: _replacementVehicleType,
                    items: const ['Small', 'Medium', 'Large', 'Premium'],
                    onChanged: (value) {
                      setState(() {
                        _replacementVehicleType = value!;
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                  
                  // Vehicle replacement days
                  const Text(
                    'Vehicle replacement days',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: AppColors.primaryDark,
                    ),
                  ),
                  const SizedBox(height: 8),
                  _buildDropdown(
                    value: _replacementDays,
                    items: const ['8 Days', '10 Days', '15 Days', '30 Days'],
                    onChanged: (value) {
                      setState(() {
                        _replacementDays = value!;
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                  
                  // Is your age below 24?
                  const Text(
                    'Is your age below 24?',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: AppColors.primaryDark,
                    ),
                  ),
                  Row(
                    children: [
                      Radio<bool>(
                        value: true,
                        groupValue: _isBelow24,
                        onChanged: (value) {
                          setState(() {
                            _isBelow24 = value!;
                          });
                        },
                      ),
                      const Text('Yes'),
                      const SizedBox(width: 24),
                      Radio<bool>(
                        value: false,
                        groupValue: _isBelow24,
                        onChanged: (value) {
                          setState(() {
                            _isBelow24 = value!;
                          });
                        },
                      ),
                      const Text('No'),
                    ],
                  ),
                  const SizedBox(height: 16),
                  
                  // Cover (repeated at the bottom as in the screenshot)
                  const Text(
                    'Cover',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: AppColors.primaryDark,
                    ),
                  ),
                  Row(
                    children: [
                      Radio<String>(
                        value: 'Third Party',
                        groupValue: _coverType,
                        onChanged: (value) {
                          setState(() {
                            _coverType = value!;
                          });
                        },
                      ),
                      const Text('Third Party'),
                      const SizedBox(width: 24),
                      Radio<String>(
                        value: 'Comprehensive Plus',
                        groupValue: _coverType,
                        onChanged: (value) {
                          setState(() {
                            _coverType = value!;
                          });
                        },
                      ),
                      const Text('Comprehensive Plus'),
                    ],
                  ),
                  const SizedBox(height: 24),
                  
                  // Calculate Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _calculateQuote,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.secondaryDark,
                        foregroundColor: AppColors.primaryDark,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Text(
                        'Calculate',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 190),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDropdown({
    required String value,
    required List<String> items,
    required void Function(String?) onChanged,
  }) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          items: items.map((String item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(item),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }

  Widget _buildCheckboxItem(String title, bool value, void Function(bool?) onChanged) {
    return Row(
      children: [
        Checkbox(
          value: value,
          onChanged: onChanged,
          activeColor: AppColors.primary,
        ),
        Text(title),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:insure_me/utils/app_colors.dart';
import 'package:insure_me/widgets/auth/auth_background.dart';

class OfferDetailsScreen extends StatefulWidget {
  final String companyName;
  final String price;
  final int rating;
  final String coverageDetails;

  const OfferDetailsScreen({
    super.key,
    required this.companyName,
    required this.price,
    required this.rating,
    required this.coverageDetails,
  });

  @override
  State<OfferDetailsScreen> createState() => _OfferDetailsScreenState();
}

class _OfferDetailsScreenState extends State<OfferDetailsScreen> {
  bool _isProcessing = false;
  bool _showConfirmation = false;

  void _buyInsurance() {
    setState(() {
      _isProcessing = true;
    });

    // Simulate API call
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _isProcessing = false;
        _showConfirmation = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // Calculate the number of stars based on rating
    final stars = List.generate(widget.rating, (index) => const Text(
      '★',
      style: TextStyle(
        color: Colors.amber,
        fontSize: 16,
      ),
    ));

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.companyName),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      body: AuthBackground(
        backgroundImage: "assets/images/homebackground.png",
        backgroundColor: Colors.white,
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Get the best offer',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryDark,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 24),
                    
                    // Insurance offer card
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.only(bottom: 16),
                      decoration: BoxDecoration(
                        color: AppColors.secondaryLight,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                            decoration: BoxDecoration(
                              color: AppColors.secondaryDark,
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(12),
                                topRight: Radius.circular(12),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      widget.companyName,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.primaryDark,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      '${widget.price} BHD',
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.primaryDark,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(children: stars),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Coverage Details:',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.primaryDark,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                _buildCoverageDetails(),
                                const SizedBox(height: 16),
                                const Text(
                                  'Policy Benefits:',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.primaryDark,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                _buildBenefitItem('24/7 Customer Support'),
                                _buildBenefitItem('Quick Claim Processing'),
                                _buildBenefitItem('Mobile App Access'),
                                _buildBenefitItem('No Hidden Fees'),
                                const SizedBox(height: 16),
                                const Text(
                                  'Terms & Conditions:',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.primaryDark,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                const Text(
                                  'By purchasing this insurance policy, you agree to the terms and conditions set by the insurance provider. Please read all policy documents carefully before proceeding.',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.black87,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Buy Button
                    Center(
                      child: SizedBox(
                        width: 200,
                        child: ElevatedButton(
                          onPressed: _isProcessing || _showConfirmation ? null : _buyInsurance,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.secondaryDark,
                            foregroundColor: AppColors.primaryDark,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: _isProcessing
                              ? const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    color: AppColors.primaryDark,
                                    strokeWidth: 2,
                                  ),
                                )
                              : const Text(
                                  'BUY',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 100),
                  ],
                ),
              ),
            ),
            
            // Confirmation overlay
            if (_showConfirmation)
              Container(
                color: Colors.black.withOpacity(0.5),
                child: Center(
                  child: Container(
                    margin: const EdgeInsets.all(24),
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.check_circle,
                          color: Colors.green,
                          size: 64,
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'Order Placed Successfully!',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'Your insurance request has been received. Our team will finalize your policy and contact you for payment details.',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 24),
                        ElevatedButton(
                          onPressed: () {
                            // Navigate back to home screen
                            Navigator.of(context).popUntil((route) => route.isFirst);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: const Text('Back to Home'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildCoverageDetails() {
    final coverages = widget.coverageDetails.split(', ');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: coverages.map((coverage) => _buildCoverageItem(coverage)).toList(),
    );
  }

  Widget _buildCoverageItem(String coverage) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('• ', style: TextStyle(fontWeight: FontWeight.bold)),
          Expanded(
            child: Text(
              coverage,
              style: const TextStyle(fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBenefitItem(String benefit) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          const Icon(
            Icons.check_circle,
            color: Colors.green,
            size: 16,
          ),
          const SizedBox(width: 8),
          Text(
            benefit,
            style: const TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }
}

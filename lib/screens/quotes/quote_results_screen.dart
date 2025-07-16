import 'package:flutter/material.dart';
import 'package:insure_me/screens/quotes/offer_details_screen.dart';
import 'package:insure_me/utils/app_colors.dart';
import 'package:insure_me/widgets/auth/auth_background.dart';

class QuoteResultsScreen extends StatelessWidget {
  final String vehicleValue;
  final bool isNewVehicle;
  final String coverType;
  final String paymentMode;
  final String vehicleType;
  final String bodyType;
  final String registrationMonth;
  final String modelYear;
  final String policyStartDate;
  final String ccHp;
  final Map<String, bool> additionalCover;
  final String replacementVehicleType;
  final String replacementDays;
  final bool isBelow24;

  const QuoteResultsScreen({
    super.key,
    required this.vehicleValue,
    required this.isNewVehicle,
    required this.coverType,
    required this.paymentMode,
    required this.vehicleType,
    required this.bodyType,
    required this.registrationMonth,
    required this.modelYear,
    required this.policyStartDate,
    required this.ccHp,
    required this.additionalCover,
    required this.replacementVehicleType,
    required this.replacementDays,
    required this.isBelow24,
  });

  @override
  Widget build(BuildContext context) {
    // Generate mock insurance offers based on the input
    final offers = _generateOffers();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Quote Results'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      body: AuthBackground(
        backgroundImage: "assets/images/homebackground.png",
        backgroundColor: Colors.white,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
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
                
                // Display insurance offers
                ...offers.map((offer) => _buildOfferCard(context, offer)).toList(),
                
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOfferCard(BuildContext context, InsuranceOffer offer) {
    // Calculate the number of stars based on rating
    final stars = List.generate(offer.rating, (index) => const Text(
      '★',
      style: TextStyle(
        color: Colors.amber,
        fontSize: 16,
      ),
    ));

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OfferDetailsScreen(
              companyName: offer.companyName,
              price: offer.price,
              rating: offer.rating,
              coverageDetails: offer.coverageDetails,
            ),
          ),
        );
      },
      child: Container(
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
                        offer.companyName,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryDark,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${offer.price} BHD',
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
              child: Text(
                'Cover: ${offer.coverageDetails}',
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.black87,
                ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<InsuranceOffer> _generateOffers() {
    // Generate mock offers based on the input parameters
    final selectedCoverages = additionalCover.entries
        .where((entry) => entry.value)
        .map((entry) => entry.key)
        .toList();
    
    final coverageDetailsText = selectedCoverages.join(', ');
    
    // Calculate base prices based on vehicle value and other factors
    final baseValue = double.tryParse(vehicleValue) ?? 10000;
    final basePrice = (baseValue * 0.03).round();
    
    return [
      InsuranceOffer(
        companyName: 'AGC Insurance',
        price: '${basePrice + 20}.00',
        rating: 4,
        coverageDetails: coverageDetailsText,
      ),
      InsuranceOffer(
        companyName: 'SAT Insurance',
        price: '${basePrice + 50}.00',
        rating: 3,
        coverageDetails: coverageDetailsText,
      ),
      InsuranceOffer(
        companyName: 'GTC Insurance',
        price: '${basePrice + 15}.00',
        rating: 5,
        coverageDetails: coverageDetailsText,
      ),
      InsuranceOffer(
        companyName: 'TYR Insurance',
        price: '${basePrice + 20}.00',
        rating: 4,
        coverageDetails: coverageDetailsText,
      ),
      InsuranceOffer(
        companyName: 'IBH Insurance',
        price: '${basePrice + 22}.00',
        rating: 4,
        coverageDetails: coverageDetailsText,
      ),
    ];
  }
}

class InsuranceOffer {
  final String companyName;
  final String price;
  final int rating; // 1-5 stars
  final String coverageDetails;

  InsuranceOffer({
    required this.companyName,
    required this.price,
    required this.rating,
    required this.coverageDetails,
  });
}

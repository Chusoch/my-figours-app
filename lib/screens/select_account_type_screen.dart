import 'package:flutter/material.dart';
import 'identity_verification_screen.dart';
import '../widgets/progress_bar.dart';

class SelectAccountTypeScreen extends StatefulWidget {
  const SelectAccountTypeScreen({super.key});

  @override
  State<SelectAccountTypeScreen> createState() =>
      _SelectAccountTypeScreenState();
}

class _SelectAccountTypeScreenState extends State<SelectAccountTypeScreen> {
  String? _selectedType;

  final List<Map<String, dynamic>> _accountTypes = [
    {
      'type': 'Individual',
      'description': 'For personal use and peer\n-to-peer transfers.',
      'image': 'assets/images/Individual icon.jpg',
    },
    {
      'type': 'Sole Proprietor',
      'description': 'For small business owners\nand freelancers.',
      'image': 'assets/images/Sole Proprietor icon.jpg',
    },
    {
      'type': 'Corporate',
      'description': 'For registered businesses\nand organizations.',
      'image': 'assets/images/Corporate icon.jpg',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          children: [
            const ProgressBar(currentStep: 2, totalSteps: 5),
            const SizedBox(height: 24),
            const Text(
              'Choose your account type',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF15181A),
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              "We'll tailor your experience based on this choice.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 32),

            // Account Types
            Expanded(
              child: ListView.separated(
                itemCount: _accountTypes.length,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 16),
                itemBuilder: (context, index) {
                  final typeData = _accountTypes[index];
                  final isSelected = _selectedType == typeData['type'];

                  return InkWell(
                    onTap: () {
                      setState(() {
                        _selectedType = typeData['type'];
                      });
                    },
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: isSelected
                              ? const Color(0xFF15181A)
                              : Colors.grey[200]!,
                          width: isSelected ? 1.5 : 1,
                        ),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.05),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Icon
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.grey[50],
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Image.asset(
                              typeData['image'],
                              width: 32,
                              height: 32,
                              fit: BoxFit.contain,
                            ),
                          ),
                          const SizedBox(width: 16),

                          // Content
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      typeData['type'],
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: Color(0xFF15181A),
                                      ),
                                    ),
                                    // Selection Indicator
                                    if (isSelected)
                                      const Icon(
                                        Icons.check_circle,
                                        color: Color(0xFF15181A),
                                        size: 24,
                                      )
                                    else
                                      const Icon(
                                        Icons.radio_button_unchecked,
                                        color: Colors.grey,
                                        size: 24,
                                      ),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  typeData['description'],
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.grey[600],
                                    height: 1.4,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    const Text(
                                      'Learn more',
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: Colors.amber,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const SizedBox(width: 4),
                                    const Icon(
                                      Icons.keyboard_arrow_down,
                                      size: 16,
                                      color: Colors.amber,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            // Continue Button (renamed from Next)
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _selectedType != null
                    ? () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const IdentityVerificationScreen(),
                          ),
                        );
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF15181A),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Continue',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

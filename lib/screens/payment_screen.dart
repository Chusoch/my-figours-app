import 'package:flutter/material.dart';
import 'local_transfer_screen.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});

  final List<Map<String, String>> _paymentOptions = const [
    {
      'title': 'Foreign Transfer',
      'desc': 'Send money internationally to any supported country',
      'icon': 'assets/images/Foreign Transfer.png',
    },
    {
      'title': 'Local Transfer (NGN)',
      'desc': 'Transfer funds to any Nigerian bank account instantly',
      'icon': 'assets/images/Local Transfer (NGN).png',
    },
    {
      'title': 'Convert',
      'desc': 'Exchange your funds between different currencies at live rates',
      'icon': 'assets/images/Convert.png',
    },
    {
      'title': 'Wallet Top Up',
      'desc': 'Add money to your wallet using bank, card, or USSD',
      'icon': 'assets/images/Wallet Top Up.png',
    },
    {
      'title': 'Invoice',
      'desc': 'Generate and send invoices to get paid faster',
      'icon': 'assets/images/Invoice.png',
    },
    {
      'title': 'Bills & Airtime',
      'desc': 'Pay utility bills or buy airtime and data with ease',
      'icon': 'assets/images/Bills & Airtime.png',
    },
    {
      'title': 'Scheduled Payment',
      'desc': 'Set up automatic payments for future dates and times',
      'icon': 'assets/images/Scheduled Payment.png',
    },
    {
      'title': 'Payment Link',
      'desc': 'Create a link to request or collect payments from anyone',
      'icon': 'assets/images/Payment Link.png',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Or common background color
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Payments',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF15181A),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Choose your payment type',
                style: TextStyle(fontSize: 14, color: Colors.grey[500]),
              ),
              const SizedBox(height: 24),
              Expanded(
                child: GridView.builder(
                  itemCount: _paymentOptions.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 163 / 101, // Exact ratio requested
                  ),
                  itemBuilder: (context, index) {
                    final option = _paymentOptions[index];
                    return _buildPaymentCard(
                      title: option['title']!,
                      description: option['desc']!,
                      iconPath: option['icon']!,
                      onTap: () {
                        if (option['title'] == 'Local Transfer (NGN)') {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LocalTransferScreen(),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: Text(
                                    '${option['title']} feature coming soon')),
                          );
                        }
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPaymentCard({
    required String title,
    required String description,
    required String iconPath,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10), // Reduced from 16
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(17),
          border: Border.all(color: const Color(0xFFE5ECF6)),
          boxShadow: [
            BoxShadow(
              color: const Color(0x1A307BF6),
              blurRadius: 2,
              offset: const Offset(0, 2),
              spreadRadius: 0,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  iconPath,
                  width: 28, // Reduced from 40
                  height: 28,
                  fit: BoxFit.contain,
                  errorBuilder: (ctx, err, stack) =>
                      const Icon(Icons.payment, size: 28, color: Colors.blue),
                ),
                // Chevron moved to top right to save vertical space if needed?
                // Or keep at bottom? Design usually has it at bottom.
                // Let's keep it loose, but given 101px height, maybe we don't need it?
                // Or make it small.
              ],
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(
                fontSize: 12, // Reduced from 14
                fontWeight: FontWeight.bold,
                color: Color(0xFF15181A),
                height: 1.1,
              ),
              maxLines: 1, // Force 1 line for title to save space
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 127,
                    child: Text(
                      description,
                      style: TextStyle(
                        fontSize: 9, // Reduced from 11
                        color: Colors.grey[600],
                        height: 1.1,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const Icon(
                    Icons.chevron_right,
                    size: 16,
                    color: Colors.black,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

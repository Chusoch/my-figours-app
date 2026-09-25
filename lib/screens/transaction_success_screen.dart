import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'transaction_details_screen.dart';

class TransactionSuccessScreen extends StatelessWidget {
  final double amount;
  final String recipientName;
  final String accountName;
  final String accountNumber;
  final String bankName;

  const TransactionSuccessScreen({
    super.key,
    required this.amount,
    required this.recipientName,
    required this.accountName,
    required this.accountNumber,
    required this.bankName,
  });

  String _formatCurrency(double value) {
    final format = NumberFormat("#,##0.00", "en_US");
    return '\u20A6${format.format(value)}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const SizedBox.shrink(), // Hides back button
        actions: [
          GestureDetector(
            onTap: () =>
                Navigator.of(context).popUntil((route) => route.isFirst),
            child: Container(
              margin: const EdgeInsets.only(right: 16),
              child: Image.asset('assets/images/X.png',
                  width: 24, height: 24, fit: BoxFit.contain),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Spacer to push content a bit up
            const SizedBox(height: 20),
            // Success Image
            Image.asset(
              'assets/images/successful transfer.png',
              height: 180,
            ),
            const SizedBox(height: 32),
            const Text(
              'Successful',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF15181A),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Your payment to $recipientName has been\ncompleted successfully.',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xFF6B7280),
                height: 1.5,
              ),
            ),
            const SizedBox(height: 32),
            // Amount Container
            Container(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 48),
              decoration: BoxDecoration(
                color: const Color(0xFF15181A),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                _formatCurrency(amount),
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFEAA92C), // Gold-ish color from design
                ),
              ),
            ),
            const SizedBox(height: 32),
            // Currency Flow
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/ngn currency.png',
                    width: 32, height: 32), // Guessing exact asset usage
                const SizedBox(width: 8),
                const Text('NGN',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(width: 24),
                const Icon(Icons.send_rounded,
                    color: Color(0xFFEAA92C), size: 24), // Or asset
                const SizedBox(width: 24),
                Image.asset('assets/images/ngn currency.png',
                    width: 32, height: 32),
                const SizedBox(width: 8),
                const Text('NGN',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              ],
            ),
            const Spacer(),
            // Bottom Actions
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildActionButton(
                  context,
                  'Add as benef..png',
                  'Add as benef.',
                  () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Beneficiary Added successfully')),
                    );
                  },
                ),
                _buildActionButton(
                  context,
                  'Share Receipt.png',
                  'Share Receipt',
                  () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Share Receipt coming soon')),
                    );
                  },
                ),
                _buildActionButton(
                  context,
                  'View Details.png',
                  'View Details',
                  () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TransactionDetailsScreen(
                          amount: amount,
                          recipientName: recipientName,
                          accountName: accountName,
                          accountNumber: accountNumber,
                          bankName: bankName,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 48),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(BuildContext context, String iconAsset,
      String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 100, // Fixed width for uniformity
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
          border: Border.all(color: const Color(0xFFF3F4F6)),
        ),
        child: Column(
          children: [
            Image.asset(
              'assets/images/$iconAsset',
              width: 24,
              height: 24,
              errorBuilder: (c, o, s) => const Icon(Icons.error, size: 24),
            ),
            const SizedBox(height: 12),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Color(0xFF15181A),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'new_local_transfer_screen.dart';

class TransactionDetailsScreen extends StatelessWidget {
  final double amount;
  final String recipientName;
  final String accountName;
  final String accountNumber;
  final String bankName;

  const TransactionDetailsScreen({
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
    final String formattedDate =
        DateFormat('MMM d, y, HH:mm:ss').format(DateTime.now());
    // Mock reference
    final String reference = "${DateTime.now().millisecondsSinceEpoch}736271";

    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      appBar: AppBar(
        title: const Text(
          'Transfer Details',
          style: TextStyle(
              color: Color(0xFF15181A),
              fontSize: 16,
              fontWeight: FontWeight.bold),
        ),
        centerTitle: false,
        titleSpacing: 0,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, size: 20, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: TextButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          const NewLocalTransferScreen()), // Pre-filling logic could go here
                );
              },
              icon: Transform.rotate(
                angle: -0.5, // 45 degreesish
                child: const Icon(Icons.send_rounded,
                    color: Colors.white, size: 16),
              ), // Or asset
              label: const Text('Send Again',
                  style: TextStyle(color: Colors.white, fontSize: 12)),
              style: TextButton.styleFrom(
                backgroundColor: const Color(0xFF15181A),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              // Logo
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFF15181A).withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Image.asset('assets/images/logo1.png',
                    width: 40, height: 40),
              ),
              const SizedBox(height: 24),
              Text(
                'Transfer to $recipientName',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF6B7280),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                _formatCurrency(amount),
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF15181A),
                ),
              ),
              const SizedBox(height: 24),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xFFECFDF5),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset('assets/images/mark.png',
                        width: 16,
                        height: 16,
                        color: const Color(0xFF10B981)), // Use mark.png
                    const SizedBox(width: 8),
                    const Text(
                      'Successful',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF10B981),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              const Divider(color: Color(0xFFE5ECF6)),
              const SizedBox(height: 32),
              Align(
                alignment: Alignment.centerLeft,
                child: const Text(
                  'Transaction Details',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF15181A),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              _buildDetailRow('Recipient Name',
                  '$recipientName\n$bankName | $accountNumber',
                  isMultiLine: true),
              const SizedBox(height: 20),
              _buildDetailRow('Remark',
                  'Personal Transfer'), // Hardcoded as per design or pass param
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Status',
                      style: TextStyle(color: Color(0xFF9CA3AF), fontSize: 14)),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                        color: const Color(0xFFECFDF5),
                        borderRadius: BorderRadius.circular(8)),
                    child: const Text('Successful',
                        style: TextStyle(
                            color: Color(0xFF10B981),
                            fontWeight: FontWeight.w500)),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              _buildDetailRow('Transaction Type', 'Local transfer'),
              const SizedBox(height: 20),
              _buildDetailRow('Date & Time', formattedDate),
              const SizedBox(height: 20),
              _buildDetailRow('Reference', reference),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value,
      {bool isMultiLine = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment:
          isMultiLine ? CrossAxisAlignment.start : CrossAxisAlignment.center,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            color: Color(0xFF9CA3AF),
          ),
        ),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 200),
          child: Text(
            value,
            textAlign: TextAlign.right,
            style: const TextStyle(
              fontSize: 14,
              color: Color(0xFF15181A),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}

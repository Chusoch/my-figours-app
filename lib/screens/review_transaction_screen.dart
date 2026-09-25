import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'verify_transaction_modal.dart';

class ReviewTransactionScreen extends StatefulWidget {
  final double amount;
  final String bankName;
  final String accountNumber;
  final String accountName;
  final double walletBalance;

  const ReviewTransactionScreen({
    super.key,
    required this.amount,
    required this.bankName,
    required this.accountNumber,
    required this.accountName,
    required this.walletBalance,
  });

  @override
  State<ReviewTransactionScreen> createState() =>
      _ReviewTransactionScreenState();
}

class _ReviewTransactionScreenState extends State<ReviewTransactionScreen> {
  final double _fee = 50.00;
  final TextEditingController _remarkController = TextEditingController();

  double get _totalDebited => widget.amount + _fee;

  String get _maskedAccount {
    if (widget.accountNumber.length < 4) return widget.accountNumber;
    return '******${widget.accountNumber.substring(widget.accountNumber.length - 4)}';
  }

  String _formatCurrency(double value) {
    final format = NumberFormat("#,##0.00", "en_US");
    return '\u20A6${format.format(value)}';
  }

  void _onConfirmPayment() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black.withValues(alpha: 0.25),
      transitionAnimationController: AnimationController(
        vsync: Navigator.of(context),
        duration: const Duration(milliseconds: 400),
        reverseDuration: const Duration(milliseconds: 300),
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
      ),
      builder: (context) => VerifyTransactionModal(
        amount: widget.amount,
        recipientName:
            widget.accountName, // Assuming accountName is recipientName
        accountName: widget.accountName,
        accountNumber: widget.accountNumber,
        bankName: widget.bankName,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Review transaction details',
          style: TextStyle(
            color: Color(0xFF15181A),
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, size: 20, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Review Details of Your Transaction',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Color(0xFF15181A),
              ),
            ),
            const SizedBox(height: 16),
            // Dark Summary Card
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFF15181A),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'You are sending',
                    style: TextStyle(fontSize: 12, color: Color(0xFF9CA3AF)),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _formatCurrency(widget.amount),
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Divider(color: Color(0xFF374151)),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Fee',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF9CA3AF),
                        ),
                      ),
                      Text(
                        _formatCurrency(_fee),
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Total debited',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF9CA3AF),
                        ),
                      ),
                      Text(
                        _formatCurrency(_totalDebited),
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            // Wallet Details
            const Text(
              'Wallet Details',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color(0xFF15181A),
              ),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFF3F4F6),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  _buildDetailRow('Wallet Currency', 'NGN'),
                  const SizedBox(height: 12),
                  _buildDetailRow(
                    'Wallet Balance',
                    _formatCurrency(widget.walletBalance),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            // Beneficiary Details
            const Text(
              'Beneficiary Details',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color(0xFF15181A),
              ),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFF3F4F6),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  _buildDetailRow('Beneficiary name', widget.accountName),
                  const SizedBox(height: 12),
                  _buildDetailRow('Account', _maskedAccount),
                  const SizedBox(height: 12),
                  _buildDetailRow('Bank details', widget.bankName),
                ],
              ),
            ),
            const SizedBox(height: 24),
            // Remark
            const Text(
              'Remark',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color(0xFF15181A),
              ),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFFE5ECF6)),
                borderRadius: BorderRadius.circular(8),
              ),
              child: TextField(
                controller: _remarkController,
                decoration: const InputDecoration(
                  hintText: 'Add a note for the beneficiary (optional)',
                  hintStyle: TextStyle(color: Color(0xFF9CA3AF), fontSize: 14),
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: 48),
            // Button
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _onConfirmPayment,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF15181A),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  'Confirm Payment',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            color: Color(0xFF4B5563),
            fontWeight: FontWeight.w400,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            color: Color(0xFF15181A),
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'transaction_success_screen.dart';

class VerifyTransactionModal extends StatefulWidget {
  final double amount;
  final String recipientName;
  final String accountName;
  final String accountNumber;
  final String bankName;

  const VerifyTransactionModal({
    super.key,
    required this.amount,
    required this.recipientName,
    required this.accountName,
    required this.accountNumber,
    required this.bankName,
  });

  @override
  State<VerifyTransactionModal> createState() => _VerifyTransactionModalState();
}

class _VerifyTransactionModalState extends State<VerifyTransactionModal> {
  final List<TextEditingController> _controllers =
      List.generate(6, (index) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(6, (index) => FocusNode());
  bool _isLoading = false;

  @override
  void dispose() {
    for (var c in _controllers) {
      c.dispose();
    }
    for (var f in _focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  void _onDigitEntered(int index, String value) {
    if (value.isNotEmpty) {
      if (index < 5) {
        _focusNodes[index + 1].requestFocus();
      } else {
        _focusNodes[index].unfocus();
        _verifyAndProcess();
      }
    } else {
      if (index > 0) {
        _focusNodes[index - 1].requestFocus();
      }
    }
  }

  Future<void> _verifyAndProcess() async {
    setState(() => _isLoading = true);

    // Simulate API call
    await Future.delayed(const Duration(seconds: 3));

    if (mounted) {
      Navigator.pop(context); // Close modal
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => TransactionSuccessScreen(
            amount: widget.amount,
            recipientName: widget.recipientName,
            accountName: widget.accountName,
            accountNumber: widget.accountNumber,
            bankName: widget.bankName,
          ),
        ),
      );
    }
  }

  Widget _buildPinBox(int index) {
    return Container(
      width: 42,
      height: 50,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE5ECF6), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Center(
        child: TextField(
          controller: _controllers[index],
          focusNode: _focusNodes[index],
          keyboardType: TextInputType.number,
          textAlign: TextAlign.center,
          obscureText: true,
          inputFormatters: [
            LengthLimitingTextInputFormatter(1),
            FilteringTextInputFormatter.digitsOnly,
          ],
          decoration: const InputDecoration(
            border: InputBorder.none,
            counterText: '',
            hintText: '*',
            hintStyle:
                TextStyle(fontSize: 24, color: Color(0xFF9CA3AF), height: 1.5),
          ),
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          onChanged: (value) => _onDigitEntered(index, value),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // If loading, show the GIF centered
    if (_isLoading) {
      return Container(
        height: 350,
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Center(
          child: Image.asset(
            'assets/images/figours load gif.gif',
            width: 150,
            height: 150,
          ),
        ),
      );
    }

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        height: 343, // Fixed height as requested
        width: double.infinity, // Full width (375px equivalent)
        padding: const EdgeInsets.symmetric(vertical: 29, horizontal: 15),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Verify Transaction',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF15181A),
                  ),
                ),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF3F4F6),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Image.asset('assets/images/X.png',
                          width: 16, height: 16),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8), // Keeping subtitle close to title for UX
            const Text(
              'Enter your 6 digit transaction PIN to\nauthorize this payment',
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFF6B7280),
                height: 1.5,
              ),
            ),
            const SizedBox(height: 38), // Requested gap
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFF3F4F6),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(6, (index) => _buildPinBox(index)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

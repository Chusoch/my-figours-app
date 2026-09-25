import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'review_transaction_screen.dart';

class NewLocalTransferScreen extends StatefulWidget {
  const NewLocalTransferScreen({super.key});

  @override
  State<NewLocalTransferScreen> createState() => _NewLocalTransferScreenState();
}

class _NewLocalTransferScreenState extends State<NewLocalTransferScreen> {
  // State
  String _selectedCurrency = 'NGN';
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _accountController = TextEditingController();
  String _paymentType = 'Single Payment';
  String? _selectedBank;
  String? _accountName;
  bool _isValidatingAccount = false;
  bool _isAccountVerified = false;

  // Mock Data
  final Map<String, double> _walletBalances = {
    'NGN': 50000.00,
    'EUR': 200.00,
    'GBP': 150.00,
    'USD': 500.00,
  };

  bool _isLoadingBanks = false;
  List<String> _banks = [];

  @override
  void initState() {
    super.initState();
    _fetchBanks();
  }

  Future<void> _fetchBanks() async {
    setState(() => _isLoadingBanks = true);
    try {
      final response = await http.get(
        Uri.parse(
          'https://raw.githubusercontent.com/ichtrojan/nigerian-banks/master/banks.json',
        ),
      );
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        if (mounted) {
          setState(() {
            _banks = data.map((e) => e['name'] as String).toList()..sort();
          });
        }
      }
    } catch (e) {
      debugPrint('Error loading banks: $e');
    } finally {
      setState(() => _isLoadingBanks = false);
    }
  }

  final Map<String, String> _currencyIcons = {
    'NGN': 'assets/images/ngn currency.png',
    'EUR': 'assets/images/eur.png',
    'GBP': 'assets/images/gbp.png',
    'USD': 'assets/images/usd.png',
  };

  @override
  void dispose() {
    _amountController.dispose();
    _accountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: const Text(
          'Transfer to Local Bank (NGN)',
          style: TextStyle(
            color: Color(0xFF15181A),
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildLabel('Send amount'),
              const SizedBox(height: 8),
              _buildAmountInput(),
              const SizedBox(height: 8),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  'Wallet Balance: ${_formatCurrency(_walletBalances[_selectedCurrency] ?? 0)}',
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF15181A),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              _buildLabel('Amount your beneficiary will receive'),
              const SizedBox(height: 8),
              _buildReceiveAmountDisplay(),
              const SizedBox(height: 24),
              _buildLabel('Payment Type'),
              const SizedBox(height: 8),
              _buildPaymentTypeSelector(),
              const SizedBox(height: 24),
              _buildLabel('Select Bank'),
              const SizedBox(height: 8),
              _buildBankDropdown(),
              const SizedBox(height: 24),
              _buildLabel('Account Number'),
              const SizedBox(height: 8),
              _buildAccountInput(),
              const SizedBox(height: 48),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _validateAndSubmit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF15181A),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        25,
                      ), // Rounded as per generic style or image
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Next',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: Color(0xFF15181A),
      ),
    );
  }

  Widget _buildAmountInput() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFE5ECF6)),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              controller: _amountController,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Color(0xFF15181A),
              ),
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: '0.00',
              ),
              onChanged: (val) {
                setState(() {}); // Update receive amount
              },
            ),
          ),
          GestureDetector(
            onTap: _showCurrencyPicker,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0xFFF3F4F6),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    _currencyIcons[_selectedCurrency]!,
                    width: 16,
                    height: 16,
                    errorBuilder: (ctx, err, stack) =>
                        const Icon(Icons.error, size: 16),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    _selectedCurrency,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF15181A),
                    ),
                  ),
                  const SizedBox(width: 4),
                  const Icon(Icons.keyboard_arrow_down, size: 18),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReceiveAmountDisplay() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFE5ECF6)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            _amountController.text.isEmpty ? '0.00' : _amountController.text,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Color(0xFF15181A),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFFF3F4F6),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                Image.asset(
                  _currencyIcons[
                      'NGN']!, // Always display in NGN for local transfer
                  width: 16,
                  height: 16,
                ),
                const SizedBox(width: 8),
                const Text(
                  'NGN',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentTypeSelector() {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xFFE5ECF6)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: RadioGroup<String>(
        groupValue: _paymentType,
        onChanged: (val) {
          if (val != null) {
            setState(() => _paymentType = val);
          }
        },
        child: Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () => setState(() => _paymentType = 'Single Payment'),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    color: _paymentType == 'Single Payment'
                        ? Colors.white
                        : Colors.transparent,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Radio<String>(
                        value: 'Single Payment',
                        fillColor:
                            WidgetStateProperty.all(const Color(0xFFEAA92C)),
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      const Text(
                        'Single Payment',
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () => setState(() => _paymentType = 'Bulk Payment'),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    color: _paymentType == 'Bulk Payment'
                        ? Colors.white
                        : Colors.transparent,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Radio<String>(
                        value: 'Bulk Payment',
                        fillColor:
                            WidgetStateProperty.all(const Color(0xFFEAA92C)),
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      const Text(
                        'Bulk Payment',
                        style: TextStyle(fontWeight: FontWeight.w500),
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

  Widget _buildBankDropdown() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(
          0xFFF3F4F6,
        ), // Light grey fill like image "Select beneficiary bank" field
        borderRadius: BorderRadius.circular(8),
      ),
      child: GestureDetector(
        onTap: _showBankPicker,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: const BoxDecoration(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _selectedBank ?? 'Select beneficiary bank',
                style: TextStyle(
                  fontSize: 16, // Match input text size roughly
                  color: _selectedBank == null
                      ? const Color(0xFF9CA3AF)
                      : const Color(0xFF15181A),
                ),
              ),
              const Icon(Icons.keyboard_arrow_down, color: Color(0xFF5A5C5E)),
            ],
          ),
        ),
      ),
    );
  }

  void _showBankPicker() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      barrierColor: const Color(0x40000000), // 25% Black
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      isScrollControlled: true, // Allow full height if needed/better control
      builder: (context) {
        String searchQuery = '';
        return StatefulBuilder(
          builder: (context, setModalState) {
            final filteredBanks = _banks
                .where(
                  (bank) =>
                      bank.toLowerCase().contains(searchQuery.toLowerCase()),
                )
                .toList();

            return DraggableScrollableSheet(
              initialChildSize: 0.8, // Increased for better search view
              minChildSize: 0.5,
              maxChildSize: 0.95,
              expand: false,
              builder: (context, scrollController) {
                return Column(
                  children: [
                    const SizedBox(height: 12),
                    // Handle bar
                    Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Select Bank',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF15181A),
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Search Bar
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFFF3F4F6),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: TextField(
                          onChanged: (val) {
                            setModalState(() {
                              searchQuery = val;
                            });
                          },
                          decoration: const InputDecoration(
                            hintText: 'Search bank',
                            border: InputBorder.none,
                            prefixIcon: Icon(Icons.search, color: Colors.grey),
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 14,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    if (_isLoadingBanks)
                      const Expanded(
                        child: Center(child: CircularProgressIndicator()),
                      )
                    else
                      Expanded(
                        child: filteredBanks.isEmpty
                            ? const Center(child: Text('No banks found'))
                            : ListView.builder(
                                controller: scrollController,
                                itemCount: filteredBanks.length,
                                itemBuilder: (context, index) {
                                  final bank = filteredBanks[index];
                                  final bool isSelected = bank == _selectedBank;
                                  return InkWell(
                                    onTap: () {
                                      setState(() {
                                        _selectedBank = bank;
                                      });
                                      Navigator.pop(context);
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 24,
                                        vertical: 16,
                                      ),
                                      color: isSelected
                                          ? const Color(0xFFF9FAFB)
                                          : Colors.white,
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              bank,
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                                color: Color(0xFF15181A),
                                              ),
                                            ),
                                          ),
                                          if (isSelected)
                                            const Icon(
                                              Icons.check_circle,
                                              color: Color(0xFF15181A),
                                              size: 20,
                                            ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                      ),
                  ],
                );
              },
            );
          },
        );
      },
    );
  }

  Widget _buildAccountInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFFF3F4F6),
            borderRadius: BorderRadius.circular(8),
          ),
          child: TextFormField(
            controller: _accountController,
            keyboardType: TextInputType.number,
            maxLength: 10,
            onChanged: (val) {
              setState(() {
                if (val.length == 10 && _selectedBank != null) {
                  _validateAccount(val);
                } else {
                  _accountName = null;
                  _isAccountVerified = false;
                  _isValidatingAccount = false;
                }
              });
            },
            decoration: InputDecoration(
              counterText: "",
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
              border: InputBorder.none,
              hintText: 'Enter account number',
              hintStyle: const TextStyle(color: Color(0xFF9CA3AF)),
              suffixIcon: _isValidatingAccount
                  ? const Padding(
                      padding: EdgeInsets.all(12.0),
                      child: SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                    )
                  : null,
            ),
          ),
        ),
        if (_accountController.text.isNotEmpty &&
            _accountController.text.length < 10) ...[
          const SizedBox(height: 8),
          const Text(
            'Invalid account number',
            textAlign: TextAlign.right,
            style: TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
        ] else if (_accountName != null) ...[
          const SizedBox(height: 8),
          Text(
            _accountName!,
            textAlign: TextAlign.right,
            style: const TextStyle(
              color: Color(0xFF22C55E), // Green 500
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
        ],
      ],
    );
  }

  Future<void> _validateAccount(String accountNumber) async {
    setState(() {
      _isValidatingAccount = true;
      _accountName = null;
      _isAccountVerified = false;
    });

    // Mock API delay
    await Future.delayed(const Duration(seconds: 2));

    if (mounted) {
      if (_accountController.text != accountNumber) return;
      setState(() {
        _isValidatingAccount = false;
        // Mock success
        _accountName = 'Adebayo Emmanuel';
        _isAccountVerified = true;
      });
    }
  }

  String _formatCurrency(double amount) {
    // Simple formatter, ideally usage of NumberFormat
    if (_selectedCurrency == 'NGN') return '\u20A6${amount.toStringAsFixed(2)}';
    if (_selectedCurrency == 'EUR') return '€${amount.toStringAsFixed(2)}';
    if (_selectedCurrency == 'GBP') return '£${amount.toStringAsFixed(2)}';
    if (_selectedCurrency == 'USD') return '\$${amount.toStringAsFixed(2)}';
    return '$amount';
  }

  void _showCurrencyPicker() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      barrierColor: const Color(0x40000000), // 25% Black
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 12),
              // Handle bar
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Select Currency',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF15181A),
                ),
              ),
              const SizedBox(height: 16),
              ..._walletBalances.keys.map((currency) {
                final bool isSelected = currency == _selectedCurrency;
                final double balance = _walletBalances[currency] ?? 0.0;
                String symbol = '';
                if (currency == 'NGN') symbol = '\u20A6';
                if (currency == 'EUR') symbol = '€';
                if (currency == 'GBP') symbol = '£';
                if (currency == 'USD') symbol = '\$';

                return InkWell(
                  onTap: () {
                    setState(() {
                      _selectedCurrency = currency;
                    });
                    Navigator.pop(context);
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 16,
                    ),
                    color: isSelected ? const Color(0xFFF9FAFB) : Colors.white,
                    child: Row(
                      children: [
                        Image.asset(
                          _currencyIcons[currency]!,
                          width: 24,
                          height: 24,
                          errorBuilder: (ctx, err, stack) =>
                              const Icon(Icons.error, size: 24),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                currency,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFF15181A),
                                ),
                              ),
                              Text(
                                '$symbol${balance.toStringAsFixed(2)}',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[600],
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (isSelected)
                          const Icon(
                            Icons.check_circle,
                            color: Color(0xFF15181A), // Dark theme primary
                            size: 20,
                          ),
                      ],
                    ),
                  ),
                );
              }),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  void _validateAndSubmit() {
    if (_amountController.text.isEmpty ||
        _selectedBank == null ||
        _accountController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill all fields'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (!_isAccountVerified) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please verify account details first'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Verify PIN or Navigate to Review
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ReviewTransactionScreen(
          amount: double.tryParse(_amountController.text) ?? 0.0,
          bankName: _selectedBank!,
          accountNumber: _accountController.text,
          accountName: _accountName!,
          walletBalance: _walletBalances['NGN'] ?? 0.0,
        ),
      ),
    );
  }
}

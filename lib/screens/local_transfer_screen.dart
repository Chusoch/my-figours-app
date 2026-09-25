import 'package:flutter/material.dart';
import 'new_local_transfer_screen.dart';

class LocalTransferScreen extends StatelessWidget {
  const LocalTransferScreen({super.key});

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
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Send to new recipient button
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const NewLocalTransferScreen(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF15181A),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      'Send to new recipient',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // Beneficiaries Section
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Send to existing beneficiary',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF15181A),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text(
                                  'All beneficiaries feature coming soon')),
                        );
                      },
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: const Text(
                        'View all',
                        style: TextStyle(
                          color: Color(0xFFEAA92C),
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                SizedBox(
                  height: 100,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: _beneficiaries.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(width: 12),
                    itemBuilder: (context, index) {
                      final b = _beneficiaries[index];
                      return _buildBeneficiaryCard(b['name']!, b['account']!);
                    },
                  ),
                ),
                const SizedBox(height: 24),

                // Recent Transfers Section
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Recent Transfers',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF15181A),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Transaction history coming soon')),
                        );
                      },
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: const Text(
                        'View more',
                        style: TextStyle(
                          color: Color(0xFFEAA92C),
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: _recentTransfers.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final t = _recentTransfers[index];
                    return _buildRecentTransferItem(context, t);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBeneficiaryCard(String name, String account) {
    return Container(
      width: 100, // Fixed width for cards
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFE8EDF2),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: const BoxDecoration(
              color: Colors.white, // White circle bg for icon
              shape: BoxShape.circle,
            ),
            child: Image.asset(
              'assets/images/transfers.png',
              width: 16,
              height: 16,
              errorBuilder: (context, error, stackTrace) => Icon(
                Icons.home_work_outlined,
                size: 16,
                color: Colors.orange[300],
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            name,
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color: Color(0xFF15181A),
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          Text(
            account,
            style: TextStyle(fontSize: 9, color: Colors.grey[500]),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildRecentTransferItem(
      BuildContext context, Map<String, dynamic> transfer) {
    final bool isSuccess = transfer['status'] == 'Successful';
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE5ECF6)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Status Row
          Row(
            children: [
              Image.asset(
                isSuccess
                    ? 'assets/images/Successful.png'
                    : 'assets/images/Failed.png',
                width: 14,
                height: 14,
                errorBuilder: (context, error, stackTrace) => Icon(
                  isSuccess
                      ? Icons.check_circle_outline
                      : Icons.cancel_outlined,
                  size: 14,
                  color: isSuccess ? Colors.green : Colors.red,
                ),
              ),
              const SizedBox(width: 4),
              Text(
                transfer['status'],
                style: TextStyle(
                  fontSize: 12,
                  color: isSuccess ? Colors.green : Colors.red,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Spacer(),
              Text(
                transfer['amount'],
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF15181A),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          // Name Row
          Text(
            transfer['name'],
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Color(0xFF15181A),
            ),
          ),
          const SizedBox(height: 4),
          // Details Row with Button
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Account details: ${transfer['bank']} | ${transfer['account']}',
                      style: TextStyle(fontSize: 11, color: Colors.grey[500]),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Sent ${transfer['date']}',
                      style: TextStyle(fontSize: 11, color: Colors.grey[400]),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              SizedBox(
                height: 28,
                child: OutlinedButton(
                  onPressed: () {
                    // Navigate to NewLocalTransferScreen
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const NewLocalTransferScreen(),
                      ),
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    backgroundColor: const Color(0xFFE8EDF2),
                    side: BorderSide.none,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                  ),
                  child: const Text(
                    'Send again',
                    style: TextStyle(
                      color: Color(0xFF15181A),
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Mock Data
  final List<Map<String, String>> _beneficiaries = const [
    {'name': 'Aisha Abuba...', 'account': 'A/C ***163'},
    {'name': 'Olamisd Adelola', 'account': 'A/C ***322'},
    {'name': 'Aisha Abuba...', 'account': 'A/C ***112'},
    {'name': 'John Temideyou', 'account': 'A/C ***393'},
  ];

  final List<Map<String, dynamic>> _recentTransfers = const [
    {
      'status': 'Successful',
      'name': 'Paul Mark',
      'bank': 'Access Bank',
      'account': '******1212',
      'amount': '-\u20A65,000.00',
      'date': 'May 2nd, 2025',
    },
    {
      'status': 'Failed',
      'name': 'Temitope Emmanuel',
      'bank': 'Access Bank',
      'account': '******1212',
      'amount': '-\u20A650,000.00',
      'date': 'May 2nd, 2025',
    },
    {
      'status': 'Successful',
      'name': 'Temitope Emmanuel',
      'bank': 'Access Bank',
      'account': '******1212',
      'amount': '-\u20A65,000.00',
      'date': 'May 2nd, 2025',
    },
    {
      'status': 'Successful',
      'name': 'Okolie Ola',
      'bank': 'Access Bank',
      'account': '******1212',
      'amount': '+\u20A650,000.00', // Receiving? Image shows - and +.
      'date': 'May 2nd, 2025',
    },
    {
      'status': 'Successful',
      'name': 'Chinwendu Patricia',
      'bank': 'Access Bank',
      'account': '******1212',
      'amount': '+\u20A650,000.00',
      'date': 'May 2nd, 2025',
    },
  ];
}

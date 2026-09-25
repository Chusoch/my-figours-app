import 'dart:async';
import 'package:flutter/material.dart';

import 'settings_screen.dart';
import 'payment_screen.dart';

// Figours fintech app - Home screen built by Justus Ogunduyi 🚀

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  bool _isBalanceVisible = false;

  // Carousel State
  final PageController _pageController = PageController();
  int _currentBannerIndex = 0;
  Timer? _carouselTimer;

  final List<Map<String, String>> _banners = [
    {
      'title': 'Scheduled Maintenance',
      'subtitle':
          'The system will be temporarily unavailable due to routine maintenance. Please save your work before this time.',
      'icon': 'assets/images/settings1.gif',
      'bg': '0xFFFFEEDD', // Light orange/beige
    },
    {
      'title': 'Introducing FX Rate Auto-Update',
      'subtitle':
          'Now you can enable real-time FX rate syncing across all transactions. Try it in your settings today.',
      'icon': 'assets/images/mess2.gif',
      'bg': '0xFFE3F2FD', // Light Blue
    },
    {
      'title': 'Special Naira Offer',
      'subtitle':
          'From May 15 – May 20, send money in Naira without paying any transaction fee. This is the best time to go local — fast, free, and secure!',
      'icon': 'assets/images/notification3.gif',
      'bg': '0xFFE8F5E9', // Light Green
    },
  ];

  @override
  void initState() {
    super.initState();
    _startAutoPlay();
  }

  @override
  void dispose() {
    _carouselTimer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void _startAutoPlay() {
    _carouselTimer = Timer.periodic(const Duration(seconds: 4), (timer) {
      if (_pageController.hasClients) {
        int nextPage = _currentBannerIndex + 1;
        if (nextPage >= _banners.length) {
          nextPage = 0;
        }
        _pageController.animateToPage(
          nextPage,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FB), // Light grey background
      body: SafeArea(
        child: _selectedIndex == 1
            ? const PaymentScreen()
            : _buildHomeContent(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: const Color(0xFF15181A),
        unselectedItemColor: Colors.grey,
        selectedLabelStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: const TextStyle(fontSize: 12),
        items: [
          _buildNavItem('Home', 'assets/images/Home.png', 0),
          _buildNavItem('Payment', 'assets/images/Payment.png', 1),
          _buildNavItem('Insight', 'assets/images/Insight.png', 2),
          _buildNavItem('Card', 'assets/images/card.png', 3),
          _buildNavItem('Help', 'assets/images/help.png', 4),
        ],
      ),
    );
  }

  Widget _buildHomeContent() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                Stack(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SettingsScreen(),
                          ),
                        );
                      },
                      child: CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.transparent,
                        backgroundImage: const AssetImage(
                          'assets/images/User.png',
                        ),
                      ),
                    ),
                    // Edit icon overlay if needed, based on image "Hi, Justus" with edit icon
                    Positioned(
                      right: -2,
                      bottom: -2,
                      child: Container(
                        padding: const EdgeInsets.all(2),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.edit,
                          size: 10,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 12),
                const Text(
                  'Hi, Justus',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF15181A),
                  ),
                ),
                const Spacer(),
                Image.asset(
                  'assets/images/Notification.png',
                  width: 24,
                  height: 24,
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Wallet Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFF15181A), // Dark BG
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        'assets/images/ngn.png',
                        width: 20,
                        height: 20,
                        errorBuilder: (ctx, _, __) => const Icon(
                          Icons.flag,
                          color: Colors.green,
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        'Wallet Balance',
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _isBalanceVisible = !_isBalanceVisible;
                          });
                        },
                        child: Icon(
                          _isBalanceVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    _isBalanceVisible ? 'NGN 2,500,000.00' : 'NGN XXXXXX',
                    style: const TextStyle(
                      color: Color(0xFFEAA92C), // Gold/Orange
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Text(
                                'Acct: 2781621121',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 13,
                                ),
                              ),
                              const SizedBox(width: 8),
                              GestureDetector(
                                onTap: () {
                                  // Copy logic
                                },
                                child: const Icon(
                                  Icons.copy,
                                  color: Color(0xFFEAA92C),
                                  size: 14,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            'FIG - JOHN OLAMIDE',
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Bank: Fidelity',
                            style: TextStyle(
                              color: Colors.grey[400],
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0x334CAF50),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.green),
                        ),
                        child: const Text(
                          'ACTIVE',
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            if (_isBalanceVisible) ...[
              const SizedBox(height: 24),
              // Transaction History
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 20,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey[200]!),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Transaction History',
                      style: TextStyle(color: Colors.grey, fontSize: 13),
                    ),
                    const SizedBox(height: 16),
                    _buildTransactionItem(
                      title: 'Netflix Subscription',
                      ref: 'REF: NF25639874',
                      amount: '-₦250.00',
                      time: 'Today, 10:45 AM',
                      isDebit: true,
                    ),
                    const SizedBox(height: 16),
                    _buildTransactionItem(
                      title: 'Netflix Subscription',
                      ref: 'REF: NF25639874',
                      amount: '+₦250.00',
                      time: 'Today, 10:45 AM',
                      isDebit: false,
                    ),
                    const SizedBox(height: 8),
                    const Center(
                      child: Icon(
                        Icons.keyboard_arrow_down,
                        color: Colors.black,
                        size: 20,
                      ),
                    ),
                  ],
                ),
              ),
            ],
            const SizedBox(height: 24),

            // Quick Actions Grid
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 1.4, // Aspect ratio to match cards
              children: [
                _buildActionCard('Convert', 'assets/images/Exchange_icon.png'),
                _buildActionCard('Bill & Airtime', 'assets/images/bill.png'),
                _buildActionCard('Statement', 'assets/images/statement.png'),
                _buildActionCard('More', 'assets/images/more.png'),
              ],
            ),
            const SizedBox(height: 24),

            // Carousel Banner
            SizedBox(
              height: 160,
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentBannerIndex = index;
                  });
                },
                itemCount: _banners.length,
                itemBuilder: (context, index) {
                  final banner = _banners[index];
                  // Parse color string to int

                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        10,
                      ), // Requested: 10px
                      gradient: const LinearGradient(
                        begin: Alignment
                            .centerLeft, // Approximation for 82deg (left-ish to right-ish)
                        end: Alignment.centerRight,
                        colors: [
                          Color(0xFFEAEAEA), // 45.83%
                          Color(0xFFEED4A7), // 110.28%
                        ],
                        // Custom stops not perfectly supported with just 2 colors and >100% end,
                        // but we can try to approximate visually or just standard gradient.
                        // 82deg is roughly almost vertical but tilted right.
                        // Let's use Alignment for angle.
                        // 0 deg = bottom to top. 90 deg = left to right.
                        // 82 deg is close to Left -> Right.
                        // Let's stick to standard Left->Right for simplicity as 'linear-gradient' usually implies direction.
                      ),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                banner['title']!,
                                style: TextStyle(
                                  color: Color(
                                    int.parse('0xFFEAA92C'),
                                  ), // Keep Title Orange? Design shows Orange title for "Scheduled Maintenance"
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                banner['subtitle']!,
                                style: const TextStyle(
                                  color: Color(0xFF15181A),
                                  fontSize: 12,
                                  height: 1.4,
                                ),
                                maxLines: 4,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                        Image.asset(
                          banner['icon']!,
                          width: 40,
                          height: 40,
                          errorBuilder: (c, e, s) => const Icon(
                            Icons.settings,
                            size: 40,
                            color: Colors.orange,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 12),
            // Indicators
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(_banners.length, (index) {
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 3),
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentBannerIndex == index
                        ? const Color(0xFF15181A)
                        : Colors.grey[300],
                  ),
                );
              }),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildActionCard(String title, String iconPath) {
    return Container(
      padding: const EdgeInsets.all(16),
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(3),
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
            child: Image.asset(
              iconPath,
              width: 24,
              height: 24,
              errorBuilder: (context, error, stackTrace) =>
                  const Icon(Icons.grid_view, size: 24),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF15181A),
                ),
              ),
              const Icon(Icons.chevron_right, size: 16, color: Colors.grey),
            ],
          ),
        ],
      ),
    );
  }

  BottomNavigationBarItem _buildNavItem(
    String label,
    String iconPath,
    int index,
  ) {
    return BottomNavigationBarItem(
      icon: ImageIcon(AssetImage(iconPath), size: 24),
      label: label,
    );
  }

  Widget _buildTransactionItem({
    required String title,
    required String ref,
    required String amount,
    required String time,
    required bool isDebit,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: isDebit ? const Color(0xFFFFE5E5) : const Color(0xFFE5FFEA),
            shape: BoxShape.circle,
          ),
          child: Icon(
            isDebit ? Icons.arrow_upward : Icons.arrow_downward,
            color: isDebit ? Colors.red : Colors.green,
            size: 20,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 15, // Slightly larger looking
                  color: Color(0xFF15181A),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                ref,
                style: TextStyle(color: Colors.grey[500], fontSize: 12),
              ),
              const SizedBox(height: 2),
              Text(
                time,
                style: TextStyle(color: Colors.grey[400], fontSize: 12),
              ),
            ],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              amount,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: isDebit ? Colors.red : Colors.green,
              ),
            ),
            const SizedBox(height: 4),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: const Color(0x1A4CAF50),
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Text(
                'Success',
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

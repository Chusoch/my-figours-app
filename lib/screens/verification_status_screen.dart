import 'package:flutter/material.dart';
import 'login_screen.dart'; // Suggests navigation back to login

class VerificationStatusScreen extends StatelessWidget {
  const VerificationStatusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false, // No back button
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      // Main Image
                      Container(
                        width: 120,
                        height: 120,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFFF5F5F5),
                        ),
                        child: ClipOval(
                          child: Image.asset(
                            'assets/images/Verification.png',
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                const Icon(Icons.verified_user, size: 60),
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),

                      // Title
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            'Verification In Progress',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF15181A),
                            ),
                          ),
                          SizedBox(width: 8),
                          Text('⏳', style: TextStyle(fontSize: 20)),
                        ],
                      ),
                      const SizedBox(height: 16),

                      Text(
                        'Thank you for completing your verification.\nOur compliance team is currently reviewing your information.\nThis process will take less than to 48 hours.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: 40),

                      // What happens next
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'What happens next?',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF15181A),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      _buildStep(
                        number: '1',
                        title: 'Compliance Review',
                        description:
                            'Our compliance team will review your KYC documents and assign a risk rating',
                      ),
                      const SizedBox(height: 16),
                      _buildStep(
                        number: '2',
                        title: 'Account Creation',
                        description:
                            'Upon approval, your account(s) will be created based on your riskprofile',
                      ),
                      const SizedBox(height: 16),
                      _buildStep(
                        number: '3',
                        title: 'Email Notification',
                        description:
                            'You\'ll receive an email with your account details and next steps',
                      ),

                      const SizedBox(height: 32),

                      // Need help
                      Wrap(
                        alignment: WrapAlignment.center,
                        children: [
                          Icon(
                            Icons.help_outline,
                            size: 16,
                            color: Colors.grey[600],
                          ),
                          const SizedBox(width: 4),
                          Text(
                            'Need help? ',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              // Action
                            },
                            child: const Text(
                              'support@figuresapp.com',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.amber,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              ),
              // Button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginScreen(),
                      ),
                      (route) => false,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF15181A),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Back to Log In',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStep({
    required String number,
    required String title,
    required String description,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 24,
          height: 24,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.grey[100],
            shape: BoxShape.circle,
          ),
          child: Text(
            number,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12,
              color: Colors.black,
            ),
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
                  fontSize: 14,
                  color: Color(0xFF15181A),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: TextStyle(fontSize: 13, color: Colors.grey[600]),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

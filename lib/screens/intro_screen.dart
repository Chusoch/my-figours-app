import 'package:flutter/material.dart';

import 'login_screen.dart';
import 'create_account_screen.dart';
import 'package:google_fonts/google_fonts.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen>
    with TickerProviderStateMixin {
  // Staggered entrance states
  bool _showGlobe = false;
  bool _showText = false;
  bool _showButtons = false;

  // Floating animation
  late AnimationController _floatingController;
  late Animation<double> _floatingAnimation;

  // Interactive scale
  double _scale = 1.0;

  @override
  void initState() {
    super.initState();

    // Initialize floating controller
    _floatingController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat(reverse: true);

    _floatingAnimation = Tween<double>(begin: 0, end: 15.0).animate(
      CurvedAnimation(parent: _floatingController, curve: Curves.easeInOut),
    );

    // Staggered entrance sequence
    _startEntranceSequence();
  }

  void _startEntranceSequence() async {
    await Future.delayed(const Duration(milliseconds: 300));
    if (mounted) setState(() => _showGlobe = true);

    await Future.delayed(const Duration(milliseconds: 600));
    if (mounted) setState(() => _showText = true);

    await Future.delayed(const Duration(milliseconds: 400));
    if (mounted) setState(() => _showButtons = true);
  }

  @override
  void dispose() {
    _floatingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Brand Colors
    const Color primaryColor = Color(0xFF15181A);
    const Color accentColor = Color(0xFFF0B140);

    return Scaffold(
      backgroundColor: primaryColor,
      body: Stack(
        children: [
          // Background Elements
          SafeArea(
            child: Column(
              children: [
                Expanded(
                  flex: 5, // Gives more space to the hero section
                  child: Center(
                    child: AnimatedOpacity(
                      duration: const Duration(milliseconds: 800),
                      opacity: _showGlobe ? 1.0 : 0.0,
                      curve: Curves.easeOut,
                      child: GestureDetector(
                        onTapDown: (_) => setState(() => _scale = 0.95),
                        onTapUp: (_) => setState(() => _scale = 1.0),
                        onTapCancel: () => setState(() => _scale = 1.0),
                        child: AnimatedScale(
                          scale: _scale,
                          duration: const Duration(milliseconds: 100),
                          child: AnimatedBuilder(
                            animation: _floatingAnimation,
                            builder: (context, child) {
                              return Transform.translate(
                                offset: Offset(0, -_floatingAnimation.value),
                                child: child,
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(24.0),
                              child: Image.asset(
                                'assets/images/2hero.png',
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                // Typography Section
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: AnimatedSlide(
                      offset: _showText ? Offset.zero : const Offset(0, 0.2),
                      duration: const Duration(milliseconds: 800),
                      curve: Curves.easeOutQuart,
                      child: AnimatedOpacity(
                        duration: const Duration(milliseconds: 800),
                        opacity: _showText ? 1.0 : 0.0,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'Global Financial\nEmpowerment',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.inter(
                                fontSize: 32,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                                height: 1.1,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Access the world’s economy, anytime.',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.inter(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: const Color.fromRGBO(255, 255, 255, 0.7),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                // CTA Section
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 0, 24, 32),
                  child: AnimatedSlide(
                    offset: _showButtons ? Offset.zero : const Offset(0, 0.5),
                    duration: const Duration(milliseconds: 800),
                    curve: Curves.easeOutCubic,
                    child: AnimatedOpacity(
                      duration: const Duration(milliseconds: 800),
                      opacity: _showButtons ? 1.0 : 0.0,
                      child: Column(
                        children: [
                          // Primary Button: Get Started
                          Container(
                            width: double.infinity,
                            height: 56,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(32),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color.fromRGBO(240, 177, 64, 0.2),
                                  blurRadius: 16,
                                  offset: Offset(0, 4),
                                ),
                              ],
                            ),
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const CreateAccountScreen(),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: accentColor,
                                foregroundColor: Colors.black,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(32),
                                ),
                              ),
                              child: Text(
                                'Get Started',
                                style: GoogleFonts.inter(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),

                          // Secondary Button: Sign In
                          SizedBox(
                            width: double.infinity,
                            height: 56,
                            child: OutlinedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const LoginScreen(),
                                  ),
                                );
                              },
                              style: OutlinedButton.styleFrom(
                                foregroundColor: Colors.white,
                                side: const BorderSide(
                                  color: Color(0xFF2C3E50), // Soft gray border
                                  width: 1,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(32),
                                ),
                              ),
                              child: Text(
                                'Sign In',
                                style: GoogleFonts.inter(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

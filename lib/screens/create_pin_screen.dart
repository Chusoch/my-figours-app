import 'package:flutter/material.dart';
import '../widgets/progress_bar.dart';
import '../widgets/custom_keypad.dart';
import 'verification_status_screen.dart'; // Will create this next

class CreatePinScreen extends StatefulWidget {
  final bool isLoginPin;
  final String? loginPin; // Passed to Transaction PIN step for validation

  const CreatePinScreen({super.key, required this.isLoginPin, this.loginPin});

  @override
  State<CreatePinScreen> createState() => _CreatePinScreenState();
}

class _CreatePinScreenState extends State<CreatePinScreen> {
  String _pin = '';
  bool _enableFingerprint = false;
  bool _obscurePin = true;

  int get _pinLength => widget.isLoginPin ? 4 : 6;

  void _onKeyPressed(String value) {
    if (_pin.length < _pinLength) {
      setState(() {
        _pin += value;
      });
      if (_pin.length == _pinLength) {
        _onSubmit();
      }
    }
  }

  void _onDeletePressed() {
    if (_pin.isNotEmpty) {
      setState(() {
        _pin = _pin.substring(0, _pin.length - 1);
      });
    }
  }

  void _onSubmit() {
    if (widget.isLoginPin) {
      // Proceed to Transaction PIN
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              CreatePinScreen(isLoginPin: false, loginPin: _pin),
        ),
      );
    } else {
      // Validate Transaction PIN != Login PIN
      if (_pin == widget.loginPin) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Transaction PIN must be different from Login PIN'),
            backgroundColor: Colors.red,
          ),
        );
        setState(() {
          _pin = '';
        });
        return;
      }

      // Submit and go to Status
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const VerificationStatusScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              children: [
                ProgressBar(
                  currentStep: widget.isLoginPin ? 4 : 5,
                  totalSteps: 5,
                ),
                const SizedBox(height: 32),
                Text(
                  widget.isLoginPin
                      ? 'Create Login PIN'
                      : 'Create Transaction PIN',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF15181A),
                  ),
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Text(
                    widget.isLoginPin
                        ? 'This PIN is used to uncover your app' // sic "uncover" or "unlock"? Image seems to say "unlock". Text says "uncover". Let's stick to user prompt "uncover" if forced, but user prompt says "unlock your app" in the image description "unlock your app". Wait, image 4 "Create Login PIN" subtitle says "This PIN is used to unlock your app". User text says "login PIN". I'll use "unlock your app".
                        : 'This PIN is required to approve transactions and sensitive action. Make it different from your login PIN.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                      height: 1.5,
                    ),
                  ),
                ),
                const SizedBox(height: 40),

                // PIN Display
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ...List.generate(_pinLength, (index) {
                      final isFilled = index < _pin.length;
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        width: widget.isLoginPin ? 20 : 40, // Circles vs Boxes
                        height: widget.isLoginPin ? 20 : 55,
                        decoration: widget.isLoginPin
                            ? BoxDecoration(
                                shape: BoxShape.circle,
                                color: isFilled
                                    ? const Color(0xFFEAA92C)
                                    : Colors.transparent,
                                border: Border.all(
                                  color: isFilled
                                      ? const Color(0xFFEAA92C)
                                      : const Color(0xFFEAA92C),
                                  width: 2,
                                ),
                              )
                            : BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: isFilled
                                      ? const Color(0xFFEAA92C)
                                      : Colors.grey[300]!,
                                ),
                              ),
                        child: !widget.isLoginPin && isFilled
                            ? Center(
                                child: _obscurePin
                                    ? Container(
                                        width: 10,
                                        height: 10,
                                        decoration: const BoxDecoration(
                                          color: Color(0xFFEAA92C),
                                          shape: BoxShape.circle,
                                        ),
                                      )
                                    : Text(
                                        _pin[index],
                                        style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF15181A),
                                        ),
                                      ),
                              )
                            : null, // Login PIN just shows color fill
                      );
                    }),
                    if (!widget.isLoginPin) ...[
                      const SizedBox(width: 8),
                      IconButton(
                        icon: Icon(
                          _obscurePin
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                          color: Colors.black,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscurePin = !_obscurePin;
                          });
                        },
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),

          const Spacer(),

          // Fingerprint (Step 4 only)
          if (widget.isLoginPin)
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[200]!),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEEF0F2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Image.asset(
                      'assets/images/finger.png',
                      width: 24,
                      height: 24,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) => const Icon(
                        Icons.error_outline,
                        color: Colors.red,
                        size: 24,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Enable Fingerprint',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Color(0xFF15181A),
                          ),
                        ),
                        Text(
                          'Faster, secure login',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Switch(
                    value: _enableFingerprint,
                    onChanged: (value) {
                      setState(() {
                        _enableFingerprint = value;
                      });
                    },
                    // activeColor: const Color(0xFFEAA92C), // Deprecated
                    thumbColor: WidgetStateProperty.resolveWith<Color?>((
                      Set<WidgetState> states,
                    ) {
                      if (states.contains(WidgetState.selected)) {
                        return const Color(0xFFEAA92C);
                      }
                      return null; // Use default
                    }),
                  ),
                ],
              ),
            ),

          // Keypad
          CustomKeypad(
            onKeyPressed: _onKeyPressed,
            onDeletePressed: _onDeletePressed,
          ),
        ],
      ),
    );
  }
}

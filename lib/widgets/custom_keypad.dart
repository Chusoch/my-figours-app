import 'package:flutter/material.dart';

class CustomKeypad extends StatelessWidget {
  final Function(String) onKeyPressed;
  final VoidCallback onDeletePressed;
  final bool biometricEnabled;
  final VoidCallback? onBiometricPressed;

  const CustomKeypad({
    super.key,
    required this.onKeyPressed,
    required this.onDeletePressed,
    this.biometricEnabled = false,
    this.onBiometricPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[200], // Light grey background like generic keypad
      padding: const EdgeInsets.only(bottom: 20, top: 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildKey('1', ''),
              _buildKey('2', 'ABC'),
              _buildKey('3', 'DEF'),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildKey('4', 'GHI'),
              _buildKey('5', 'JKL'),
              _buildKey('6', 'MNO'),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildKey('7', 'PQRS'),
              _buildKey('8', 'TUV'),
              _buildKey('9', 'WXYZ'),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const SizedBox(width: 100), // Filler for left side of 0
              _buildKey('0', ''),
              SizedBox(
                width: 100,
                height: 50,
                child: Center(
                  child: IconButton(
                    icon: const Icon(Icons.backspace_outlined),
                    onPressed: onDeletePressed,
                    color: Colors.black54,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildKey(String value, String letters) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: Material(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          elevation: 0,
          child: InkWell(
            onTap: () => onKeyPressed(value),
            borderRadius: BorderRadius.circular(5),
            child: Container(
              height: 50,
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    value,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                  ),
                  if (letters.isNotEmpty)
                    Text(
                      letters,
                      style: const TextStyle(
                        fontSize: 9,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        letterSpacing: 1.5,
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

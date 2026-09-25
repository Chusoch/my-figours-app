import 'package:flutter/material.dart';

class ProgressBar extends StatelessWidget {
  final int currentStep;
  final int totalSteps;

  const ProgressBar({
    super.key,
    required this.currentStep,
    this.totalSteps = 5,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: List.generate(totalSteps, (index) {
            final isActive = index + 1 <= currentStep;
            final isCurrent = index + 1 == currentStep;

            return Expanded(
              child: Container(
                height: 4,
                margin: const EdgeInsets.symmetric(horizontal: 2),
                decoration: BoxDecoration(
                  color: isActive
                      ? (isCurrent
                          ? const Color(0xFFEAA92C)
                          : const Color(0xFFEAA92C).withValues(
                              alpha:
                                  0.5)) // Current is solid, active invalid is inactive color in some designs but let's stick to active color or grey.
                      // Looking at design:
                      // Step 1: All grey except 1? No, usually previous are completed.
                      // Design shows active step is Orange. Previous steps are likely completed (also Orange or Grey?).
                      // Let's assume Active = Orange, Inactive = Grey[200].
                      // Wait, Looking at Step 2 image: Step 1 is orange, Step 2 is orange, others grey.
                      // So index < currentStep => Completed (Orange?)
                      // index == currentStep => Current (Orange?)
                      // Actually, let's look at the images again.
                      // Step 1: 1st bar Orange, others Grey.
                      // Step 2: 1st bar Orange, 2nd bar Orange, others Grey.
                      // Step 3: 1, 2, 3 Orange.
                      // So simplistic logic: index < currentStep ? Orange : Grey.
                      : Colors.grey[200],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            );
          }),
        ),
        const SizedBox(height: 8),
        Text(
          'Step $currentStep of $totalSteps',
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

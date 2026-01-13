import 'package:flutter/material.dart';
import '../../../../constant/application_colors.dart';
import '../../../viewmodel/ai_call_viewmodel.dart';

class PulsingAvatar extends StatefulWidget {
  final AiState aiState;

  const PulsingAvatar({super.key, required this.aiState});

  @override
  State<PulsingAvatar> createState() => _PulsingAvatarState();
}

class _PulsingAvatarState extends State<PulsingAvatar> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Sadece Lingo konuşurken animasyon çalışacaktır
    if (widget.aiState == AiState.speaking) {
      if (!_controller.isAnimating) _controller.repeat(reverse: true);
    } else {
      _controller.stop();
      _controller.value = 0.0;
    }

    return Stack(
      alignment: Alignment.center,
      children: [
        if (widget.aiState == AiState.speaking)
          ScaleTransition(
            scale: _scaleAnimation,
            child: Container(
              width: 220,
              height: 220,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: ApplicationColors.accent.withValues(alpha: 0.2),
              ),
            ),
          ),

        if (widget.aiState == AiState.speaking)
          ScaleTransition(
            scale: Tween<double>(begin: 1.0, end: 1.1).animate(_controller),
            child: Container(
              width: 190,
              height: 190,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: ApplicationColors.accent.withValues(alpha: 0.4),
              ),
            ),
          ),

        Container(
          width: 160,
          height: 160,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
            border: Border.all(color: Colors.white, width: 4),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 20,
                offset: const Offset(0, 10),
              )
            ],
            image: const DecorationImage(
              image: AssetImage('assets/images/lingo.png'),
              fit: BoxFit.contain,
            ),
          ),
        ),
      ],
    );
  }
}
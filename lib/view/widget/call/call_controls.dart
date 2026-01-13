import 'package:flutter/material.dart';
import 'package:internship_project_template/constant/application_colors.dart';

import '../../../viewmodel/ai_call_viewmodel.dart';

class CallControls extends StatelessWidget {
  final AiCallViewModel viewModel;

  const CallControls({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32.0),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(40),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildCircleButton(
            icon: viewModel.isMicMuted ? Icons.mic_off : Icons.mic,
            color: viewModel.isMicMuted ? ApplicationColors.darkGrey : Colors.white,
            bgColor: viewModel.isMicMuted ? Colors.white : Colors.white.withValues(alpha: 0.2),
            onTap: viewModel.toggleMute,
          ),

          const SizedBox(width: 32),

          _buildCircleButton(
            icon: Icons.call_end,
            color: Colors.white,
            bgColor: Colors.redAccent,
            size: 72,
            iconSize: 32,
            onTap: () => viewModel.endCall(context),
          ),

          const SizedBox(width: 32),

          _buildCircleButton(
            icon: Icons.volume_up,
            color: viewModel.isSpeakerOn ? ApplicationColors.darkGrey : Colors.white,
            bgColor: viewModel.isSpeakerOn ? Colors.white : Colors.white.withValues(alpha: 0.2),
            onTap: viewModel.toggleSpeaker,
          ),
        ],
      ),
    );
  }

  Widget _buildCircleButton({
    required IconData icon,
    required Color color,
    required Color bgColor,
    required VoidCallback onTap,
    double size = 56,
    double iconSize = 28,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: bgColor,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: color, size: iconSize),
      ),
    );
  }
}
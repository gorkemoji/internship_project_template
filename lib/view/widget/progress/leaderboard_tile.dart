import 'package:flutter/material.dart';
import '../../../../constant/application_colors.dart';

class LeaderboardTile extends StatelessWidget {
  final int rank;
  final String name;
  final int points;
  final bool isMe;

  const LeaderboardTile({
    super.key,
    required this.rank,
    required this.name,
    required this.points,
    required this.isMe,
  });

  @override
  Widget build(BuildContext context) {
    Color rankColor = Colors.grey.shade400;
    if (rank == 1) {
      rankColor = ApplicationColors.goldRank;
    } else if (rank == 2) {
      rankColor = ApplicationColors.silverRank;
    }
    else if (rank == 3) {
      rankColor = ApplicationColors.bronzeRank;
    }

    return Container(
      color: isMe ? ApplicationColors.accent.withValues(alpha: 0.05) : Colors.transparent,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
        leading: SizedBox(
          width: 40,
          child: Center(
            child: rank <= 3
                ? Icon(Icons.emoji_events, color: rankColor)
                : Text("$rank", style: TextStyle(fontWeight: FontWeight.bold, color: rankColor, fontSize: 16)),
          ),
        ),
        title: Row(
          children: [
            Text(
              name,
              style: TextStyle(
                fontWeight: isMe ? FontWeight.bold : FontWeight.normal,
                color: isMe ? ApplicationColors.accent : Colors.black87,
              ),
            ),
          ],
        ),
        trailing: Text(
          "$points XP",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey.shade600),
        ),
      ),
    );
  }
}
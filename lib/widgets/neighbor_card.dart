import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../theme/colors.dart';
import '../theme/text_styles.dart';

class NeighborCard extends StatelessWidget {
  final UserModel user;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;

  const NeighborCard({
    super.key,
    required this.user,
    this.onTap,
    this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    final initials =
        user.name.trim().isEmpty
            ? '?'
            : user.name
                .trim()
                .split(' ')
                .where((s) => s.isNotEmpty)
                .map((s) => s[0])
                .take(2)
                .join()
                .toUpperCase();

    return InkWell(
      onTap: onTap,
      onLongPress: onLongPress,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
              color: Color(0x11000000),
              blurRadius: 6,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 26,
              backgroundColor: AppColors.primary,
              child: Text(
                initials,
                style: AppTextStyles.body1.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user.name,
                    style: AppTextStyles.body1.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  if (user.email != null && user.email!.isNotEmpty)
                    Text(
                      user.email!,
                      style: AppTextStyles.body2.copyWith(
                        color: Colors.black54,
                      ),
                    ),
                  if ((user.phone ?? '').isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 6.0),
                      child: Text(
                        user.phone!,
                        style: AppTextStyles.body2.copyWith(
                          color: Colors.black54,
                        ),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Icon(Icons.chevron_right, color: Colors.grey[400]),
          ],
        ),
      ),
    );
  }
}

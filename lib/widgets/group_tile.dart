import 'package:flutter/material.dart';
import 'package:material_3_expressive/material_3_expressive.dart';
import 'package:enclave/models/group_model.dart';

class GroupTile extends StatelessWidget {
  final GroupModel group;
  final VoidCallback onTap;
  final int? itemCount;

  const GroupTile({
    super.key,
    required this.group,
    required this.onTap,
    this.itemCount,
  });

  @override
  Widget build(BuildContext context) {
    final colors = M3ETheme.of(context).colorScheme;
    const radius = 28.0;

    return Container(
      margin: const EdgeInsets.fromLTRB(16, 8, 16, 18),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            left: 26,
            right: 26,
            bottom: -12,
            height: 32,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: colors.secondaryContainer.withValues(alpha: 0.45),
                borderRadius: BorderRadius.circular(radius - 6),
              ),
            ),
          ),
          Positioned(
            left: 13,
            right: 13,
            bottom: -6,
            height: 32,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: colors.secondaryContainer.withValues(alpha: 0.75),
                borderRadius: BorderRadius.circular(radius - 3),
              ),
            ),
          ),
          Material(
            color: colors.secondaryContainer,
            borderRadius: BorderRadius.circular(radius),
            clipBehavior: Clip.antiAlias,
            child: InkWell(
              onTap: onTap,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 20, 16, 20),
                child: Row(
                  children: [
                    Container(
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                        color: colors.primary,
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Icon(
                        Icons.folder_rounded,
                        color: colors.onSecondary,
                        size: 28,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            group.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              letterSpacing: -0.2,
                              color: colors.onSecondaryContainer,
                            ),
                          ),
                          if (itemCount != null) ...[
                            const SizedBox(height: 6),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 3,
                              ),
                              decoration: BoxDecoration(
                                color: colors.onSecondaryContainer.withValues(
                                  alpha: 0.12,
                                ),
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: Text(
                                itemCount == 1 ? '1 item' : '$itemCount items',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: colors.onSecondaryContainer,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: colors.onSecondaryContainer.withValues(
                          alpha: 0.10,
                        ),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.arrow_forward_rounded,
                        color: colors.onSecondaryContainer,
                        size: 20,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

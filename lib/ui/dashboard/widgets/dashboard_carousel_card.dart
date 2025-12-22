import 'package:ememoink/ui/dashboard/dashboard_screen.dart';
import 'package:flutter/material.dart';

class DashboardCarouselCard extends StatelessWidget {
  const DashboardCarouselCard({super.key, required this.cardInfo});

  final CarouselCardInfo cardInfo;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      // margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      decoration: BoxDecoration(
        color: cardInfo.getBackgroundColor(context),
        borderRadius: BorderRadius.circular(16),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          // Dostosuj rozmiary do dostępnej przestrzeni
          final iconSize = constraints.maxWidth * 0.12; // 12% szerokości

          return Padding(
            padding: const EdgeInsets.all(24.0), // Zmniejszony padding
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  cardInfo.icon,
                  color: cardInfo.getColor(context),
                  size: iconSize.clamp(32.0, 48.0), // Min 32, max 48
                ),
                const SizedBox(height: 12),
                Flexible(
                  child: Text(
                    cardInfo.title,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: cardInfo.getColor(context),
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
                const SizedBox(height: 6),
                Flexible(
                  child: Text(
                    cardInfo.subtitle,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: cardInfo.getColor(context).withValues(alpha: 0.7),
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

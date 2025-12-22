import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:ememoink/ui/dashboard/view_model/dashboard_view_model.dart';
import 'package:ememoink/ui/dashboard/dashboard_screen.dart';

class DashboardCarouselIndicator extends StatelessWidget {
  const DashboardCarouselIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: CarouselCardInfo.values.map((entry) {
          return Consumer<DashboardViewModel>(
            builder: (context, vm, child) {
              if (vm.isLoading) {
                return SizedBox();
              }
              
              return GestureDetector(
                onTap: () => vm.carouselController.animateToPage(entry.index),
                child: Container(
                  width: vm.currentPage == entry.index ? 12.0 : 10.0,
                  height: vm.currentPage == entry.index ? 12.0 : 10.0,
                  margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(context).colorScheme.primary.withValues(
                      alpha: vm.currentPage == entry.index ? 0.9 : 0.4,
                    ),
                  ),
                ),
              );
            },
          );
        }).toList(),
      ),
    );
  }
}

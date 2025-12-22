import 'package:carousel_slider/carousel_slider.dart';
import 'package:ememoink/ui/dashboard/dashboard_screen.dart';
import 'package:ememoink/ui/dashboard/view_model/dashboard_view_model.dart';
import 'package:ememoink/ui/dashboard/widgets/dashboard_carousel_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DashboardCarouselView extends StatelessWidget {
  const DashboardCarouselView({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 8.0),
        child: ConstrainedBox(
          constraints: BoxConstraints(maxHeight: 200),
          child: Consumer<DashboardViewModel>(
            builder: (context, vm, child) => CarouselSlider.builder(
              carouselController: vm.carouselController,
              options: CarouselOptions(
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 15),
                autoPlayAnimationDuration: const Duration(seconds: 2),
                enlargeCenterPage: true,
                onPageChanged: (index, reason) {
                  vm.currentPage = index;
                },
              ),
              itemCount: CarouselCardInfo.values.length,
              itemBuilder: (context, index, realIndex) {
                return DashboardCarouselCard(cardInfo: CarouselCardInfo.values[index]);
              },
            ),
          ),
        ),
      ),
    );
  }
}

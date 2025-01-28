import 'package:concentric_transition/concentric_transition.dart';
import 'package:flutter/material.dart';
import 'package:ui_projects_example/utils/show_popup.dart';

class CoolOnboarding extends StatelessWidget {
  const CoolOnboarding({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: ConcentricPageView(
        colors: pages.map((p) => p.bgColor).toList(),
        radius: screenWidth * 0.1,
        nextButtonBuilder: (context) => Padding(
          padding: const EdgeInsets.only(left: 3),
          child: Icon(
            Icons.navigate_next,
            size: screenWidth * 0.08,
          ),
        ),
        // itemCount: pages.length,
        duration: const Duration(milliseconds: 1000),

        // opacityFactor: 2.0,
        // scaleFactor: 0.2,
        // verticalPosition: 0.7,
        // direction: Axis.vertical,
        itemCount: pages.length,
        // physics: NeverScrollableScrollPhysics(),
        itemBuilder: (index) {
          final page = pages[index % pages.length];
          return SafeArea(
            child: _Page(page: page),
          );
        },
        onFinish: () {
          showPopup(context, message: 'Redirect to other page...');
        },
      ),
    );
  }
}

class PageData {
  final String? title;
  final IconData? icon;
  final String? image;
  final Color bgColor;
  final Color textColor;

  const PageData({
    required this.bgColor,
    required this.textColor,
    this.title,
    this.icon,
    this.image,
  }) : assert(
          (icon != null && image == null) || (icon == null && image != null),
          'PageData: Either icon or image must be provided, but not both.',
        );
}

final pages = [
  const PageData(
    icon: Icons.bubble_chart,
    title: "PAGE 1",
    bgColor: Color(0xFF0043D0),
    textColor: Colors.white,
  ),
  const PageData(
    image:
        'https://ouch-cdn2.icons8.com/SIriq_ItrW7l_a6QbUiYQb75fB61QDWzXPh685wRvys/rs:fit:368:313/czM6Ly9pY29uczgu/b3VjaC1wcm9kLmFz/c2V0cy9zdmcvMzEw/L2Y5ODRlNzY1LWIz/YmUtNDI1MS1iYThh/LTQ1YzNhOTdlMzI1/Zi5zdmc.png',
    title: "PAGE 2",
    textColor: Colors.white,
    bgColor: Color(0xFFFDBFDD),
  ),
  const PageData(
    icon: Icons.hdr_weak,
    title: "PAGE 3",
    bgColor: Color(0xFFFFFFFF),
    textColor: Colors.black,
  ),
];

class _Page extends StatelessWidget {
  final PageData page;

  const _Page({super.key, required this.page});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    space(double p) => SizedBox(height: screenHeight * p / 100);
    return Column(
      children: [
        space(10),
        _Image(
          page: page,
          size: 190,
          iconSize: 170,
        ),
        space(8),
        _Text(
          page: page,
          style: TextStyle(
            fontSize: screenHeight * 0.046,
          ),
        ),
      ],
    );
  }
}

class _Text extends StatelessWidget {
  const _Text({
    super.key,
    required this.page,
    this.style,
  });

  final PageData page;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return Text(
      page.title ?? '',
      style: TextStyle(
        color: page.textColor,
        fontWeight: FontWeight.w600,
        fontFamily: 'Helvetica',
        letterSpacing: 0.0,
        fontSize: 18,
        height: 1.2,
      ).merge(style),
      textAlign: TextAlign.center,
    );
  }
}

class _Image extends StatelessWidget {
  const _Image({
    super.key,
    required this.page,
    required this.size,
    required this.iconSize,
  });

  final PageData page;
  final double size;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    final bgColor = page.bgColor
        .withGreen(page.bgColor.green + 20)
        .withRed(page.bgColor.red - 100)
        .withAlpha(90);

    final icon1Color =
        page.bgColor.withBlue(page.bgColor.blue - 10).withGreen(220);
    final icon2Color = page.bgColor.withGreen(66).withRed(77);
    final icon3Color = page.bgColor.withRed(111).withGreen(220);

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(60.0)),
        color: bgColor,
      ),
      child: Stack(
        clipBehavior: Clip.none,
        fit: StackFit.expand,
        children: [
          if (page.icon != null) ...[
            Positioned.fill(
              right: -5,
              bottom: -5,
              child: RotatedBox(
                quarterTurns: 2,
                child: Icon(
                  page.icon,
                  size: iconSize + 20,
                  color: icon1Color,
                ),
              ),
            ),
            Positioned.fill(
              child: RotatedBox(
                quarterTurns: 5,
                child: Icon(
                  page.icon,
                  size: iconSize + 20,
                  color: icon2Color,
                ),
              ),
            ),
            Icon(
              page.icon,
              size: iconSize,
              color: icon3Color,
            ),
          ] else if (page.image != null) ...[
            Positioned.fill(
              child: Image.network(
                page.image!,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => const Center(
                  child: Text(
                    'Image not found',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ),
            ),
          ]
        ],
      ),
    );
  }
}

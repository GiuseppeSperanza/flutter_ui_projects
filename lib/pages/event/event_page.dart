import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:ui_projects_example/pages/event/animation/fade_animation.dart';
import 'package:ui_projects_example/pages/event/find_event_page.dart';

class EventPage extends StatefulWidget {
  const EventPage({super.key});

  @override
  _EventPageState createState() => _EventPageState();
}

class _EventPageState extends State<EventPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _scaleController;
  late Animation<double> _scaleAnimation;
  bool hide = false;

  @override
  void initState() {
    super.initState();

    _scaleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _scaleAnimation =
        Tween<double>(begin: 1.0, end: 30.0).animate(_scaleController)
          ..addStatusListener(
            (status) {
              if (status == AnimationStatus.completed) {
                Navigator.push(
                  context,
                  PageTransition(
                    child: const FindEventPage(),
                    type: PageTransitionType.fade,
                  ),
                ).then((_) {
                  setState(() {
                    hide = false;
                    _scaleController.reset();
                  });
                });
              }
            },
          );
  }

  @override
  void dispose() {
    _scaleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FadeAnimation(
        0.2,
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/background.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
            padding: const EdgeInsets.all(30),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(.5),
                  Colors.black.withOpacity(.6),
                  Colors.black.withOpacity(.5),
                  Colors.black.withOpacity(.7),
                  Colors.black.withOpacity(.6),
                ],
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const FadeAnimation(
                  1,
                  EventTitle(),
                ),
                const SizedBox(height: 30),
                const FadeAnimation(
                  1.2,
                  EventSubtitle(),
                ),
                const SizedBox(height: 150),
                FadeAnimation(
                  1.4,
                  ExploreButton(
                    scaleController: _scaleController,
                    scaleAnimation: _scaleAnimation,
                    onPressed: () {
                      setState(() => hide = true);
                      _scaleController.forward();
                    },
                    hide: hide,
                  ),
                ),
                const SizedBox(height: 60),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class EventTitle extends StatelessWidget {
  const EventTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      "Your Guide to the Best Local Venues for a Great Night Out",
      style: TextStyle(
        color: Colors.white,
        fontSize: 44,
        fontWeight: FontWeight.w900,
        height: 1.1,
      ),
    );
  }
}

class EventSubtitle extends StatelessWidget {
  const EventSubtitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      "Let us find you an event for your interest",
      style: TextStyle(
        color: Colors.white.withOpacity(.8),
        fontSize: 25,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}

class ExploreButton extends StatelessWidget {
  final AnimationController scaleController;
  final Animation<double> scaleAnimation;
  final VoidCallback onPressed;
  final bool hide;

  const ExploreButton({
    super.key,
    required this.scaleController,
    required this.scaleAnimation,
    required this.onPressed,
    required this.hide,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: AnimatedBuilder(
        animation: scaleController,
        builder: (context, child) => Transform.scale(
          scale: scaleAnimation.value,
          child: Container(
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: Colors.yellow[700],
            ),
            child: hide
                ? null
                : const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        "Explore Events",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}

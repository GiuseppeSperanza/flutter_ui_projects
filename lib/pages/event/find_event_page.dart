import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ui_projects_example/pages/event/animation/fade_animation.dart';

class FindEventPage extends StatelessWidget {
  const FindEventPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color.fromRGBO(246, 248, 253, 1),
      appBar: CustomAppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: EventList(),
        ),
      ),
    );
  }
}

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(56.0);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      leading: const Icon(Icons.menu, color: Colors.black),
      actions: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: CircleAvatar(
            backgroundImage: const AssetImage('assets/images/four.jpg'),
            radius: 17.5,
            child: Align(
              alignment: Alignment.topRight,
              child: Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  color: Colors.yellow[800],
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                ),
              ),
            ),
          ),
        )
      ],
      systemOverlayStyle: SystemUiOverlayStyle.dark,
    );
  }
}

class EventList extends StatelessWidget {
  const EventList({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> events = [
      {'image': 'assets/images/one.jpg', 'date': 2},
      {'image': 'assets/images/two.jpg', 'date': 10},
      {'image': 'assets/images/three.jpg', 'date': 16},
      {'image': 'assets/images/four.jpg', 'date': 24},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const FadeAnimation(
          1,
          SearchField(),
        ),
        const SizedBox(height: 30),
        ...events.asMap().entries.map((entry) {
          final index = entry.key;
          final event = entry.value;
          return Column(
            children: [
              FadeAnimation(
                1.2 + (index * 0.1),
                EventItem(
                  image: event['image'] as String,
                  date: event['date'] as int,
                ),
              ),
              const SizedBox(height: 20),
            ],
          );
        }),
      ],
    );
  }
}

class SearchField extends StatelessWidget {
  const SearchField({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 5),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(50),
        color: Colors.white,
      ),
      child: const TextField(
        decoration: InputDecoration(
          border: InputBorder.none,
          prefixIcon: Icon(Icons.search, color: Colors.black),
          hintText: "Search Event",
          hintStyle: TextStyle(color: Colors.black),
        ),
      ),
    );
  }
}

class EventItem extends StatelessWidget {
  final String image;
  final int date;

  const EventItem({
    super.key,
    required this.image,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        DateBadge(date: date),
        Expanded(
          child: Container(
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image:
                  DecorationImage(image: AssetImage(image), fit: BoxFit.cover),
            ),
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(
                  colors: [
                    Colors.black.withOpacity(0.4),
                    Colors.black.withOpacity(0.1),
                  ],
                ),
              ),
              child: const EventDetails(),
            ),
          ),
        ),
      ],
    );
  }
}

class DateBadge extends StatelessWidget {
  final int date;

  const DateBadge({super.key, required this.date});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 200,
      margin: const EdgeInsets.only(right: 20),
      child: Column(
        children: [
          Text(
            date.toString(),
            style: const TextStyle(
              color: Colors.blue,
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Text(
            "FEB",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

class EventDetails extends StatelessWidget {
  const EventDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.end,
      children: const [
        Text(
          "Nome Evento",
          style: TextStyle(
            color: Colors.white,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10),
        Row(
          children: [
            Icon(Icons.access_time, color: Colors.white),
            SizedBox(width: 10),
            Text(
              "21:00 PM",
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ],
    );
  }
}

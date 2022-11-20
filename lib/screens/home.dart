import 'package:flutter/material.dart';
import 'package:flutter_todolist_firebase/screens/today.dart';
import 'package:flutter_todolist_firebase/screens/tomorrow.dart';
import 'package:flutter_todolist_firebase/screens/upcoming.dart';

import '../utils/style.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  final List myList = [
    'Today',
    'Tomorrow',
    'Upcoming',
  ];
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: myList.length,
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                constraints: const BoxConstraints.expand(height: 50),
                child: Align(
                  alignment: Alignment.center,
                  child: TabBar(
                    tabs: List.generate(
                      myList.length,
                      (index) => Tab(
                        text: myList[index].toString(),
                      ),
                    ),
                    labelStyle: const TextStyle(fontWeight: FontWeight.w700),
                    labelColor: primaryColor,
                    unselectedLabelColor: customGreyColor,
                    indicatorColor: primaryColor,
                    indicatorSize: TabBarIndicatorSize.label,
                    indicatorWeight: 3.0,
                    indicator: const CustomIndicator(
                      indicatorHeight: 3.0,
                      indicatorColor: primaryColor,
                      indicatorSize: CustomIndicatorSize.normal,
                    ),
                    onTap: (index) {
                      print("You are clicking the $index");
                    },
                  ),
                ),
              ),
              const Expanded(
                child: SizedBox(
                  child: TabBarView(
                    // children: List.generate(
                    //   myList.length,
                    //   (index) => Center(
                    //     child: Text(
                    //       "${myList[index]} Page",
                    //       style: const TextStyle(color: Colors.black),
                    //     ),
                    //   ),
                    // ),
                    children: [
                      TodayPage(),
                      TomorrowPage(),
                      UpComingPage(),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

enum CustomIndicatorSize {
  tiny,
  normal,
  full,
}

class CustomIndicator extends Decoration {
  final double indicatorHeight;
  final Color indicatorColor;
  final CustomIndicatorSize indicatorSize;

  const CustomIndicator(
      {required this.indicatorHeight,
      required this.indicatorColor,
      required this.indicatorSize});

  @override
  _CustomPainter createBoxPainter([VoidCallback? onChanged]) {
    return _CustomPainter(this, onChanged!);
  }
}

class _CustomPainter extends BoxPainter {
  final CustomIndicator decoration;

  _CustomPainter(this.decoration, VoidCallback onChanged)
      : assert(decoration != null),
        super(onChanged);

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    assert(configuration != null);
    assert(configuration.size != null);

    Rect? rect;
    if (decoration.indicatorSize == CustomIndicatorSize.full) {
      rect = Offset(offset.dx,
              (configuration.size!.height - decoration.indicatorHeight)) &
          Size(configuration.size!.width, decoration.indicatorHeight);
    } else if (decoration.indicatorSize == CustomIndicatorSize.normal) {
      rect = Offset(offset.dx + 6,
              (configuration.size!.height - decoration.indicatorHeight)) &
          Size(configuration.size!.width - 12, decoration.indicatorHeight);
    } else if (decoration.indicatorSize == CustomIndicatorSize.tiny) {
      rect = Offset(offset.dx + configuration.size!.width / 2 - 8,
              (configuration.size!.height - decoration.indicatorHeight)) &
          Size(16, decoration.indicatorHeight);
    }

    final Paint paint = Paint();
    paint.color = decoration.indicatorColor;
    paint.style = PaintingStyle.fill;
    canvas.drawRRect(
        RRect.fromRectAndCorners(rect!,
            topRight: const Radius.circular(8),
            topLeft: const Radius.circular(8)),
        paint);
  }
}

import 'package:flutter/material.dart';
import 'package:sparks/ui/components/search_bar.dart' as components;

var items = [
  "item1",
  "item2",
  "item3",
  "item4",
  "item5",
  "item6",
  "item7",
  "item8",
  "item9",
  "item10"
];

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      double width = constraints.maxWidth;

      return CustomScrollView(
        slivers: [
          // Sticky search bar header.
          SliverPersistentHeader(
            pinned: true,
            delegate: _SliverSearchBarDelegate(
              child: Container(
                width: 900,
                height: 100,
                color: Colors.white,
                child: Row(

                  children: [
                    components.MySearchBar(),
                  ],
                ),
              ), minExtent: 160, maxExtent: 260
              // adjust as needed
            ),
          ),
          // Optionally add some padding.
          SliverPadding(
            padding: const EdgeInsets.all(8.0),
            sliver: SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: width < 1024 ? 2 : 3,
                mainAxisSpacing: 8.0,
                crossAxisSpacing: 8.0,
              ),
              delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                  return Card(
                    semanticContainer: false,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    color: Colors.grey,
                    child: Center(child: Text(items[index])),
                  );
                },
                childCount: items.length,
              ),
            ),
          ),
        ],
      );
    });
  }
}

// A custom SliverPersistentHeaderDelegate for the search bar.
class _SliverSearchBarDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;
  final double minExtent;
  final double maxExtent;

  _SliverSearchBarDelegate({
    required this.child,
    required this.minExtent,
    required this.maxExtent,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.white, // Use the background color you want.
      child: child,
    );
  }

  @override
  bool shouldRebuild(covariant _SliverSearchBarDelegate oldDelegate) {
    return oldDelegate.child != child ||
        oldDelegate.minExtent != minExtent ||
        oldDelegate.maxExtent != maxExtent;
  }
}

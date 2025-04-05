

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:sparks/models/porfile_card_model.dart';
import 'package:sparks/ui/components/profile_card.dart';
import 'package:sparks/ui/theme.dart'; // Ensure WHITE90, DARK_GRAY, etc. are defined here.
import 'package:sparks/ui/components/search_bar.dart' as components;
import 'package:sparks/ui/components/icon_button.dart'; // Assuming MyIconButton is defined
import 'package:sparks/ui/components/my_costum_button.dart'; // Assuming MyButton is defined

var items = [
  ProfileCardInfo(internId: "3452354", name: "EL-HILALY Yahya", division: "MARWAN", gender: "male", imageUrl: "assets/images/dummy.jpeg", isSaved: false),
  ProfileCardInfo(internId: "ehfhladfa", name: "Jhon DOE", division: "MARWAN", gender: "male", imageUrl: "assets/images/dummy.jpeg", isSaved: false),
  ProfileCardInfo(internId: "Random(100)".toString(), name: "EL-HILALY Yahya", division: "MARWAN", gender: "male", imageUrl: "assets/images/dummy.jpeg", isSaved: false),


];

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    // Determine screen width for responsive adjustments.

    return Scaffold(
      body: LayoutBuilder(
          builder: (context, constraints) {
            // Use constraints.maxWidth for grid responsiveness.
            double gridWidth = constraints.maxWidth;
            return Container(
              color: Colors.white,
              child: CustomScrollView(
                slivers: [
                  // Optionally add some space at the top.
                  const SliverToBoxAdapter(child: SizedBox(height: 320)),

                  // Sticky header with search bar and buttons.
                  SliverPersistentHeader(
                    pinned: true,
                    delegate: _SliverSearchBarDelegate(
                      // Use a responsive row:
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Row(
                          children: [
                            // Expanded search bar takes available space.
                            Expanded(child: components.MySearchBar()),
                            const SizedBox(width: 25),
                            // Icon button (adjust size if needed)
                            MyIconButton(iconAsset: 'assets/icons/icon=filter.svg',),
                            const SizedBox(width: 25),
                            // Custom button.
                            MyButton(text: 'Add Intern', iconAsset: 'assets/icons/icon=add.svg', ),
                          ],
                        ),
                      ),
                      minExtent: 116,
                      maxExtent: 116,
                    ),
                  ),

                  // Optionally add a divider or spacing.
                  const SliverToBoxAdapter(child: SizedBox(height: 10)),

                  // Grid of items.
                  SliverPadding(
                    padding: const EdgeInsets.all(8.0),
                    sliver: SliverGrid(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: (740>=gridWidth && gridWidth>610)? 1:(gridWidth < 1280 )? 2 : 3,
                        mainAxisSpacing: 8.0,
                        crossAxisSpacing: 8.0,
                        childAspectRatio: 511 / 160,
                      ),
                      delegate: SliverChildBuilderDelegate(
                            (BuildContext context, int index) {
                          return ProfileCard(
                            profile: items[index],
                          );
                        },
                        childCount: items.length,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
      ),
    );
  }
}

// Custom delegate for the sticky search bar header.
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
      width: double.infinity,
      color: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // The header row (search bar and buttons).
          Expanded(child: child),
          // Optional: a label below the row.
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              "Results: ${items.length}",
              style: TextStyle(
                fontFamily: "lato",
                fontSize: 18,
                fontWeight: FontWeight.w200,
                color: DARK_GRAY,
              ),
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  @override
  bool shouldRebuild(covariant _SliverSearchBarDelegate oldDelegate) {
    return oldDelegate.child != child ||
        oldDelegate.minExtent != minExtent ||
        oldDelegate.maxExtent != maxExtent;
  }

  @override
  FloatingHeaderSnapConfiguration? get snapConfiguration => null;
}

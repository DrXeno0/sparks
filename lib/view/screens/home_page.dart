import 'package:flutter/material.dart';
import 'package:sparks/model/intern.dart';
import 'package:sparks/nav_system/my_custome_nav.dart';
import 'package:sparks/repository/database_repository.dart';
import 'package:sparks/utils/PdfGenerator.dart';
import 'package:sparks/view/components/icon_button.dart';
import 'package:sparks/view/components/my_custom_button.dart';
import 'package:sparks/view/components/profile_card.dart';
import 'package:sparks/view/components/search_bar.dart' as components;
import 'package:sparks/view/screens/add_intern_page.dart';
import 'package:sparks/view/theme.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late DatabaseRepository _databaseRepository = DatabaseRepository();
  late List<Intern>? items = null;

  void getAllInterns() async {
    final loadedItems = await _databaseRepository.getAllInterns();
    setState(() => items = loadedItems);
    print(items?[0].toJson());
  }

  @override
  initState() {
    getAllInterns();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(builder: (ctx, cts) {
        final gridWidth = cts.maxWidth;
        final maxHeight = cts.maxHeight;

        return Container(
          color: Colors.white,
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(child: SizedBox(height: maxHeight / 4)),
              SliverPersistentHeader(
                pinned: true,
                delegate: _SliverSearchBarDelegate(
                  results: items == null ? 0 : items!.length,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Row(
                      children: [
                        Expanded(child: components.MySearchBar()),
                        const SizedBox(width: 25),
                        MyIconButton(
                          iconAsset: 'assets/icons/icon=filter.svg',
                          onPressed: () {
                            DocumentGenerator().generateAndPrintPDF(items![0]);
                          },
                        ),
                        const SizedBox(width: 25),
                        MyButton(
                          text: 'Add Intern',
                          iconAsset: 'assets/icons/icon=add.svg',
                          onPressed: () => RouteController.goTo(
                              const AddInternPage(), 'add_intern'),
                        ),
                      ],
                    ),
                  ),
                  minExtent: 116,
                  maxExtent: 116,
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 10)),
              items == null
                  ? SliverToBoxAdapter(
                      child: Container(
                      alignment: Alignment.center,
                      child: SizedBox(
                          width: 30,
                          height: 30,
                          child: CircularProgressIndicator()),
                    ))
                  : SliverPadding(
                      padding: const EdgeInsets.all(8),
                      sliver: SliverGrid(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: (gridWidth > 780)
                              ? (gridWidth < 1280 ? 2 : 3)
                              : (gridWidth > 610 ? 1 : 1),
                          mainAxisSpacing: 8,
                          crossAxisSpacing: 8,
                          childAspectRatio: 511 / 160,
                        ),
                        delegate: SliverChildBuilderDelegate(
                          (context, index) =>
                              ProfileCard(profile: items![index]),
                          childCount: items!.length,
                        ),
                      ),
                    ),
            ],
          ),
        );
      }),
    );
  }
}

class _SliverSearchBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverSearchBarDelegate({
    required this.child,
    required this.minExtent,
    required this.maxExtent,
    this.results = 0,
  });

  int results;

  final Widget child;
  @override
  final double minExtent;
  @override
  final double maxExtent;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlaps) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Expanded(child: child),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Results: ${results}',
              style: const TextStyle(
                fontFamily: 'lato',
                fontSize: 18,
                fontWeight: FontWeight.w200,
                color: darkGray,
              ),
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  @override
  bool shouldRebuild(covariant _SliverSearchBarDelegate old) =>
      old.child != child ||
      old.minExtent != minExtent ||
      old.maxExtent != maxExtent;
}

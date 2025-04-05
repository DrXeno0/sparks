import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sparks/ui/theme.dart';

class MySearchBar extends StatefulWidget {
  const MySearchBar({super.key});

  @override
  State<MySearchBar> createState() => _MySearchBarState();
}

class _MySearchBarState extends State<MySearchBar> {
  final TextEditingController _searchController = TextEditingController();
  bool _showClearButton = false;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    setState(() {
      _showClearButton = _searchController.text.isNotEmpty;
    });
  }

  void _clearSearch() {
    setState(() {
      _searchController.clear();
      _showClearButton = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(  // Added Material here
      color: Colors.transparent,
      child: Container(
        decoration:
        BoxDecoration(
          borderRadius: BorderRadius.circular(13),
          color: WHITE90

        )
        ,
padding: EdgeInsets.symmetric(horizontal: 13),
        height: 56,
        width: MediaQuery.of(context).size.width /2.5,

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(

              style: TextStyle(
                  fontFamily: "calibri",
                  fontSize: 23,
                  fontWeight: FontWeight.w200,
                  color: Colors.black
              ),
              controller: _searchController,
              decoration: InputDecoration(
                fillColor: WHITE90,
                hintText: 'Search...',

                hintStyle: TextStyle(
                  fontFamily: "calibri",
                  fontSize: 23,
                  fontWeight: FontWeight.w200,
                  color: Colors.black.withValues(alpha: .25)
                ),

                suffixIcon: _showClearButton
                    ? IconButton(
                  hoverColor: Colors.red.withValues(alpha: .25),
                  icon: SvgPicture.asset("assets/icons/icon=cancel.svg",
                      width: 20,
                      height: 20,
                      color: Colors.black.withValues(alpha: .25)),
                  onPressed: _clearSearch,
                )
                    : SvgPicture.asset("assets/icons/icon=search.svg",
                width: 34,
                height: 34,
                color: Colors.black.withValues(alpha: .25),),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(13.0),
                  borderSide: const BorderSide(width: 0, style: BorderStyle.none),
                ),
                filled: false,
                contentPadding: const EdgeInsets.symmetric(horizontal: 20),
              ),
              onChanged: (value) {
                // Implement your search logic here.
                print('Search term: $value');
              },
            ),
          ],
        ),
      ),
    );
  }
}

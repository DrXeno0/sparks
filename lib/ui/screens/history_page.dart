import 'package:flutter/cupertino.dart';
import 'package:sparks/ui/components/search_bar.dart';

class HistoryPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _HistoryPageState();
}

class _HistoryPageState  extends State<HistoryPage>{
  @override
  Widget build(BuildContext context) {
    return Center(
        child :
            MySearchBar(),


        );
  }
}
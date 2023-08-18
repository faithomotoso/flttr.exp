/**
 * Creating a sectioned list with dynamic persistent headers
 */

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:sliver_tools/sliver_tools.dart';

class SliverListWHeaders extends StatefulWidget {
  const SliverListWHeaders({super.key});

  static const String routeName = "sliver-list-headers";

  @override
  State<SliverListWHeaders> createState() => _SliverListWHeadersState();
}

class _SliverListWHeadersState extends State<SliverListWHeaders> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("An app bar here"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12).copyWith(top: 10),
        child: CustomScrollView(
          slivers: [
            MultiSliver(
              pushPinnedChildren: true,
              children: [
                SliverPinnedHeader(
                  child: Container(
                    color: Colors.white,
                    child: Text("Heading 1"),
                  ),
                ),

                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    childCount: 50,
                    (context, index) => Text("Index $index"),
                  ),
                ),
                SliverPersistentHeader(
                    delegate: HeadingPersistentDelegate(color: Colors.purple),
                    pinned: true),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    childCount: 50,
                    (context, index) => Text("Index $index"),
                  ),
                ),
                SliverPersistentHeader(
                    delegate: HeadingPersistentDelegate(color: Colors.blue),
                    pinned: true),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    childCount: 50,
                    (context, index) => Text("Index $index"),
                  ),
                )
              ],
            ),
            MultiSliver(children: [
              SliverPinnedHeader(
                child: Container(
                  color: Colors.white,
                  child: Text("Heading 1"),
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  childCount: 50,
                  (context, index) => Text("Index $index"),
                ),
              ),
            ])
          ],
        ),
      ),
    );
  }
}

class HeadingPersistentDelegate extends SliverPersistentHeaderDelegate {
  final Color color;

  HeadingPersistentDelegate({this.color = Colors.green});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    print(
        "Color ${this.color.toString()}: Shrink offset: $shrinkOffset, overlapsContent: $overlapsContent");

    return Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(color: color),
        child: const Text(
          "A title here",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ));
  }

  @override
  double get maxExtent => 30;

  @override
  double get minExtent => 30;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}

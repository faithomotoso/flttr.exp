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
              children: [
                SliverPersistentHeader(
                    delegate: HeadingPersistentDelegate(color: Colors.yellow), pinned: false),

                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    childCount: 50,
                        (context, index) => Text("Index $index"),
                  ),
                ),

                // SliverToBoxAdapter(child: SmallListConfig()),

                SliverPersistentHeader(
                    delegate: HeadingPersistentDelegate(color: Colors.purple), pinned: true),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    childCount: 50,
                        (context, index) => Text("Index $index"),
                  ),
                ),

                // SliverToBoxAdapter(child: SmallListConfig()),
                // SliverToBoxAdapter(child: SmallListConfig()),

                SliverPersistentHeader(
                    delegate: HeadingPersistentDelegate(color: Colors.blue), pinned: true),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    childCount: 50,
                        (context, index) => Text("Index $index"),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class SmallListConfig extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      shrinkWrap: true,
      primary: false,
      slivers: [
        SliverPersistentHeader(
            delegate: HeadingPersistentDelegate(), pinned: true),
        // SliverAppBar(
        //   title: Text("Title 1"), pinned: true, primary: false,
        // ),

        SliverList(
          delegate: SliverChildBuilderDelegate(
            childCount: 50,
            (context, index) => Text("Index $index"),
          ),
        )
      ],
    );
  }
}

class HeadingPersistentDelegate extends SliverPersistentHeaderDelegate {
  final Color color;

  HeadingPersistentDelegate({this.color = Colors.green});
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    print("Color ${this.color.toString()}: Shrink offset: $shrinkOffset, overlapsContent: $overlapsContent");

    return Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(color: color),
        child: const Text(
          "A title here",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ));
  }

  @override
  // TODO: implement maxExtent
  double get maxExtent => 30;

  @override
  // TODO: implement minExtent
  double get minExtent => 20;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }

}

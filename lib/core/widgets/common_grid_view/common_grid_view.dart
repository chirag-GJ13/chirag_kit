// core/commonWidgets/common_masonry_grid.dart
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class CommonMasonryGridView<T> extends StatelessWidget {
  final List<T> items;
  final Widget Function(BuildContext, T) itemBuilder;
  final int crossAxisCount;
  final double mainAxisSpacing;
  final double crossAxisSpacing;
  final EdgeInsetsGeometry padding;
  final ScrollController? scrollController;
  final bool isLoading;
  final Widget? shimmerWidget;

  const CommonMasonryGridView({
    super.key,
    required this.items,
    required this.itemBuilder,
    this.crossAxisCount = 2,
    this.mainAxisSpacing = 8.0,
    this.crossAxisSpacing = 8.0,
    this.padding = const EdgeInsets.all(8.0),
    this.scrollController,
    this.isLoading = false,
    this.shimmerWidget,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return shimmerWidget ?? const SizedBox.shrink();
    }

    return MasonryGridView.count(
      controller: scrollController,
      padding: padding,
      crossAxisCount: crossAxisCount,
      mainAxisSpacing: mainAxisSpacing,
      crossAxisSpacing: crossAxisSpacing,
      itemCount: items.length,
      itemBuilder: (context, index) => itemBuilder(context, items[index]),
    );
  }
}

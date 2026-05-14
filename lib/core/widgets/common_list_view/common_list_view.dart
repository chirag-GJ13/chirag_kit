// core/commonWidgets/common_list_view.dart
import 'package:flutter/material.dart';

class CommonListView<T> extends StatelessWidget {
  final List<T> items;
  final Widget Function(BuildContext, T) itemBuilder;
  final ScrollController? scrollController;
  final bool shrinkWrap;
  final ScrollPhysics? physics;
  final EdgeInsetsGeometry padding;
  final bool isLoading;
  final Widget? shimmerWidget;

  const CommonListView({
    super.key,
    required this.items,
    required this.itemBuilder,
    this.scrollController,
    this.shrinkWrap = false,
    this.physics,
    this.padding = const EdgeInsets.all(8.0),
    this.isLoading = false,
    this.shimmerWidget,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) return shimmerWidget ?? const SizedBox.shrink();

    return ListView.builder(
      controller: scrollController,
      shrinkWrap: shrinkWrap,
      physics: physics,
      padding: padding,
      itemCount: items.length,
      itemBuilder: (context, index) => itemBuilder(context, items[index]),
    );
  }
}

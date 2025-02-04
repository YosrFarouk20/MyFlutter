import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_shop_app/app/core/Helper/AppConstant/AppTextStyleConstant.dart';

class CustomListView extends StatefulWidget {
  const CustomListView({
    Key? key,
    required this.itemCount,
    required this.itemBuilder,
    required this.onRefresh,
    this.loadMore,
    this.hasMore = false,
    this.stateType,
    this.pageSize = 10,
    this.padding,
    this.itemExtent,
  }) : super(key: key);

  final RefreshCallback onRefresh;
  final LoadMoreCallback? loadMore;
  final int itemCount;
  final bool hasMore;
  final IndexedWidgetBuilder itemBuilder;
  final Widget? stateType;

  /// عدد العناصر في كل صفحة، الافتراضي 10
  final int pageSize;

  /// هامش `padding`
  final EdgeInsetsGeometry? padding;
  final double? itemExtent;

  @override
  _CustomListViewState createState() => _CustomListViewState();
}

typedef RefreshCallback = Future<void> Function();
typedef LoadMoreCallback = Future<void> Function();

class _CustomListViewState extends State<CustomListView> {
  /// لتحديد ما إذا كان يتم تحميل المزيد
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final Widget child = RefreshIndicator(
      onRefresh: widget.onRefresh,
      child: widget.itemCount == 0
          ? widget.stateType ?? Container()
          : ListView.builder(
        itemCount: widget.loadMore == null ? widget.itemCount : widget.itemCount + 1,
        padding: widget.padding,
        itemExtent: widget.itemExtent,
        itemBuilder: (BuildContext context, int index) {
          if (widget.loadMore == null) {
            return widget.itemBuilder(context, index);
          } else {
            return index < widget.itemCount
                ? widget.itemBuilder(context, index)
                : MoreWidget(widget.itemCount, widget.hasMore, widget.pageSize);
          }
        },
      ),
    );

    return SafeArea(
      child: NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification note) {
          if (!_isLoading &&
              widget.hasMore &&
              note.metrics.pixels == note.metrics.maxScrollExtent &&
              note.metrics.axis == Axis.vertical) {
            _loadMore();
          }
          return true;
        },
        child: child,
      ),
    );
  }

  Future<void> _loadMore() async {
    if (widget.loadMore == null || _isLoading || !widget.hasMore) return;
    _isLoading = true;
    await widget.loadMore?.call();
    if (mounted) {
      setState(() {
        _isLoading = false;
      });
    }
  }
}

class MoreWidget extends StatelessWidget {
  const MoreWidget(this.itemCount, this.hasMore, this.pageSize, {Key? key}) : super(key: key);

  final int itemCount;
  final bool hasMore;
  final int pageSize;

  @override
  Widget build(BuildContext context) {
    final TextStyle style = Get.isDarkMode
        ? AppTextStyle.h1
        : const TextStyle(color: Color(0x8A000000));

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          if (hasMore) const CupertinoActivityIndicator(),
          const SizedBox(width: 5),
          Text(
            hasMore ? 'جارٍ تحميل المزيد...' : (itemCount < pageSize ? '' : 'لا يوجد المزيد'),
            style: style,
          ),
        ],
      ),
    );
  }
}

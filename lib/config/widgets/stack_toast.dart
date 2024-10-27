import 'package:animate_do/animate_do.dart';
import 'package:animated_toast_list/animated_toast_list.dart';
import 'package:flutter/material.dart';
import 'package:iconify_flutter/icons/wi.dart';
import 'package:whatsevr_app/config/routes/router.dart';

class WhatsevrStackToast extends StatelessWidget {
  final Widget child;

  const WhatsevrStackToast({super.key, required this.child});

  static showInfo(String message) {
    AppNavigationService.currentContext!.showToast(
      _StackToastModel(message, StackToastType.info),
    );
  }

  static showSuccess(String message) {
    AppNavigationService.currentContext!.showToast(
      _StackToastModel(message, StackToastType.success),
    );
  }

  static showWarning(String message) {
    AppNavigationService.currentContext!.showToast(
      _StackToastModel(message, StackToastType.warning),
    );
  }

  static showFailed(String message) {
    AppNavigationService.currentContext!.showToast(
      _StackToastModel(message, StackToastType.failed),
    );
  }

  Widget _buildItem(
    BuildContext context,
    _StackToastModel item,
    int index,
    Animation<double> animation,
  ) {
    return _ToastItem(
      animation: animation,
      item: item,
      onTap: () => context.hideToast(
        item,
        (context, animation) => _buildItem(context, item, index, animation),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ToastListOverlay<_StackToastModel>(
      child: child,
      itemBuilder: (
        BuildContext context,
        _StackToastModel item,
        int index,
        Animation<double> animation,
      ) =>
          _buildItem(context, item, index, animation),
    );
  }
}

class _ToastItem extends StatelessWidget {
  const _ToastItem({
    Key? key,
    this.onTap,
    required this.animation,
    required this.item,
  }) : super(key: key);

  final Animation<double> animation;
  final VoidCallback? onTap;
  final _StackToastModel item;

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = TextStyle(color: Colors.white);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: FadeTransition(
        opacity: animation,
        child: SizeTransition(
          sizeFactor: animation,
          child: Container(
            decoration: BoxDecoration(
              color: _getTypeColor(item.type),
              borderRadius: const BorderRadius.all(Radius.circular(12.0)),
            ),
            child: ListTile(
              title: Text('Item ${item.message}', style: textStyle),
              trailing: IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => onTap?.call()),
            ),
          ),
        ),
      ),
    );
  }

  Color _getTypeColor(StackToastType type) {
    switch (type) {
      case StackToastType.success:
        return const Color(0xFF00FF00);
      case StackToastType.warning:
        return const Color(0xFFFFFF00);
      case StackToastType.info:
        return const Color(0xFFFFFFFF);
      case StackToastType.failed:
        return const Color(0xFFFF0000);
      default:
        return const Color(0xFFFFFFFF);
    }
  }
}

enum StackToastType { success, failed, warning, info }

class _StackToastModel {
  String message;
  StackToastType type;

  _StackToastModel(this.message, this.type);
}

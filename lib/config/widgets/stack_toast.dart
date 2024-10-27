import 'package:animated_toast_list/animated_toast_list.dart';
import 'package:flutter/material.dart';
import 'package:whatsevr_app/config/routes/router.dart';
import 'package:whatsevr_app/config/themes/theme.dart';

class WhatsevrStackToast extends StatelessWidget {
  final Widget child;

  const WhatsevrStackToast({super.key, required this.child});

  static showInfo(String message) {
    AppNavigationService.currentContext!.showToast(
      _StackToastModel(message, _StackToastType.info),
    );
  }

  static showSuccess(String message) {
    AppNavigationService.currentContext!.showToast(
      _StackToastModel(message, _StackToastType.success),
    );
  }

  static showWarning(String message) {
    AppNavigationService.currentContext!.showToast(
      _StackToastModel(message, _StackToastType.warning),
    );
  }

  static showFailed(String message) {
    AppNavigationService.currentContext!.showToast(
      _StackToastModel(message, _StackToastType.failed),
    );
  }

  Widget _buildItem(
    BuildContext context,
    _StackToastModel item,
    int index,
    Animation<double> animation,
  ) {
    return _StackToastItem(
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
      width: double.infinity,
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

class _StackToastItem extends StatelessWidget {
  const _StackToastItem({
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
    TextStyle textStyle = TextStyle(color: context.whatsevrTheme.text);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      child: FadeTransition(
        opacity: animation,
        child: SizeTransition(
          sizeFactor: animation,
          child: Stack(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: _getTypeColor(item.type),
                  borderRadius: const BorderRadius.all(Radius.circular(12.0)),
                  border: Border.all(
                    color: _getTypeColor(item.type),
                    width: 2,
                  ),
                ),
                child: Text(
                  item.message,
                  style: textStyle,
                ),
              ),
              Positioned(
                right: 8,
                top: 8,
                child: GestureDetector(
                  onTap: onTap,
                  child: Icon(
                    Icons.close,
                    color: context.whatsevrTheme.text,
                    size: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getTypeColor(_StackToastType type) {
    AppTheme theme = AppNavigationService.currentContext!.whatsevrTheme;
    switch (type) {
      case _StackToastType.success:
        return theme.surface;
      case _StackToastType.warning:
        return theme.accent;
      case _StackToastType.info:
        return theme.surface;
      case _StackToastType.failed:
        return theme.accent;
      default:
        return theme.surface;
    }
  }
}

enum _StackToastType { success, failed, warning, info }

class _StackToastModel {
  String message;
  _StackToastType type;

  _StackToastModel(this.message, this.type);
}

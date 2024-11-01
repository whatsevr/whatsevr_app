import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/ant_design.dart';
import 'package:iconify_flutter/icons/la.dart';
import 'package:iconify_flutter/icons/octicon.dart';
import 'package:iconify_flutter/icons/ph.dart';
import 'package:iconify_flutter/icons/system_uicons.dart';
import 'package:like_button/like_button.dart';
import 'package:whatsevr_app/config/services/react_unreact_bloc/react_unreact_bloc.dart';
import 'package:whatsevr_app/config/themes/theme.dart';
import 'package:whatsevr_app/config/widgets/buttons/two_state_ui.dart';
import 'package:whatsevr_app/config/widgets/stack_toast.dart';

class WhatsevrReactButton extends StatefulWidget {
  final int? reactionCount;
  final Color? firstColor;
  final double? size;
  final String? videoPostUid;
  final String? flickPostUid;
  final String? memoryUid;
  final String? offerPostUid;
  final String? photoPostUid;
  final String? pdfUid;
  final Function(bool isLiked)? onReact;
  final Function(bool isUnLiked)? onUnreact;
  final Function()? onTapSide;
  final bool arrangeVertically;

  const WhatsevrReactButton({
    super.key,
    this.reactionCount,
    this.size,
    this.firstColor,
    this.videoPostUid,
    this.flickPostUid,
    this.memoryUid,
    this.offerPostUid,
    this.photoPostUid,
    this.pdfUid,
    this.onReact,
    this.onUnreact,
    this.onTapSide,
    this.arrangeVertically = false,
  });

  @override
  State<WhatsevrReactButton> createState() => _WhatsevrReactButtonState();
}

class _WhatsevrReactButtonState extends State<WhatsevrReactButton> {
  bool _isReacted = false;
  int _reactionCount = 0;

  @override
  void initState() {
    super.initState();
    _reactionCount = widget.reactionCount ?? 0;
    _isReacted = BlocProvider.of<ReactUnreactBloc>(context)
        .state
        .reactedItemIds
        .contains(_getReactionUid());
  }

  String? _getReactionUid() {
    //assure only one of the uid is passed
    assert(
      [
            widget.videoPostUid,
            widget.flickPostUid,
            widget.memoryUid,
            widget.offerPostUid,
            widget.photoPostUid,
            widget.pdfUid
          ].where((element) => element != null).length ==
          1,
      'Only one of the uid should be passed',
    );
    return widget.videoPostUid ??
        widget.flickPostUid ??
        widget.memoryUid ??
        widget.offerPostUid ??
        widget.photoPostUid ??
        widget.pdfUid;
  }

  @override
  Widget build(BuildContext context) {
    return UnconstrainedBox(
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          widget.onTapSide?.call();
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: BlocBuilder<ReactUnreactBloc, ReactUnreactState>(
            builder: (context, state) {
              final reactionUid = _getReactionUid();
              _isReacted = state.reactedItemIds.contains(reactionUid);

              final List<Widget> children = [
                LikeButton(
                  size: widget.size ?? 26,
                  padding: const EdgeInsets.all(6),
                  likeBuilder: (bool isLiked) {
                    return Iconify(
                      isLiked
                          ? AntDesign.heart_filled
                          : AntDesign.heart_outlined,
                      color: isLiked
                          ? Colors.red
                          : widget.firstColor ?? Colors.black,
                    );
                  },
                  isLiked: _isReacted,
                  onTap: (isReacted) async {
                    final bloc = BlocProvider.of<ReactUnreactBloc>(context);

                    bloc.add(ToggleReaction(
                      reactionType:
                          'like', // or other reaction type if available
                      videoPostUid: widget.videoPostUid,
                      flickPostUid: widget.flickPostUid,
                      memoryUid: widget.memoryUid,
                      offerPostUid: widget.offerPostUid,
                      photoPostUid: widget.photoPostUid,
                      pdfUid: widget.pdfUid,
                    ));

                    setState(() {
                      _isReacted = !_isReacted;
                      _reactionCount += _isReacted ? 1 : -1;
                    });

                    return !_isReacted;
                  },
                ),
                if (_reactionCount != 0)
                  Text(
                    '${_reactionCount}',
                    style: TextStyle(color: widget.firstColor ?? Colors.black),
                  ),
              ];
              return widget.arrangeVertically
                  ? Column(children: children)
                  : Row(children: children);
            },
          ),
        ),
      ),
    );
  }
}

class WhatsevrBookmarkButton extends StatelessWidget {
  final Color? firstStateColor;
  final Color? secondStateColor;
  final bool? isBookmarked;
  final Function(bool? actionSuccess)? onBookmarked;
  final Function(bool? actionSuccess)? onUnBookmarkRemoved;

  const WhatsevrBookmarkButton({
    super.key,
    this.isBookmarked,
    this.onBookmarked,
    this.onUnBookmarkRemoved,
    this.firstStateColor,
    this.secondStateColor,
  });

  @override
  Widget build(BuildContext context) {
    final AppTheme theme = context.whatsevrTheme;
    return WhatsevrTwoStateUi(
      isSecondState: isBookmarked ?? false,
      onStateChanged: (isSecondState, isFirstState) {
        if (isSecondState) {
          WhatsevrStackToast.showSuccess('Added to bookmarks');
          onBookmarked?.call(null);
        } else if (isFirstState) {
          WhatsevrStackToast.showWarning('Removed from bookmarks');
          onUnBookmarkRemoved?.call(null);
        }
      },
      firstStateUi: Iconify(
        Ph.bookmark_simple_thin,
        color: firstStateColor ?? theme.icon,
      ),
      secondStateUi:
          Iconify(Ph.bookmark_fill, color: secondStateColor ?? theme.icon),
    );
  }
}

class WhatsevrCommentButton extends StatelessWidget {
  final Color? iconColor;
  final Function()? onTapComment;

  const WhatsevrCommentButton({super.key, this.onTapComment, this.iconColor});

  @override
  Widget build(BuildContext context) {
    final AppTheme theme = context.whatsevrTheme;
    return IconButton(
      onPressed: () {
        onTapComment?.call();
      },
      icon: Iconify(Octicon.comment_24, color: iconColor ?? theme.icon),
    );
  }
}

class WhatsevrShareButton extends StatelessWidget {
  final Color? iconColor;
  final Function()? onTapShare;

  const WhatsevrShareButton({super.key, this.onTapShare, this.iconColor});

  @override
  Widget build(BuildContext context) {
    final AppTheme theme = context.whatsevrTheme;
    return IconButton(
      onPressed: () {
        onTapShare?.call();
      },
      icon: Iconify(
        La.share,
        color: iconColor ?? theme.icon,
      ),
    );
  }
}

class Whatsevr3DotMenuButton extends StatelessWidget {
  final Color? iconColor;
  final Function()? onTapMenu;

  const Whatsevr3DotMenuButton({super.key, this.onTapMenu, this.iconColor});

  @override
  Widget build(BuildContext context) {
    final AppTheme theme = context.whatsevrTheme;
    return IconButton(
      onPressed: () {
        onTapMenu?.call();
      },
      icon: Iconify(
        SystemUicons.menu_vertical,
        color: iconColor ?? theme.icon,
      ),
    );
  }
}

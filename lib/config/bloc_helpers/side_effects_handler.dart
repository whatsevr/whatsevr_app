import 'package:flutter/material.dart';

import 'package:whatsevr_app/config/bloc_helpers/bloc_side_effects.dart';

void handleBlocSideEffectsForFlipkart(
  BuildContext context, {
  required List<BlocSideEffect>? sideEffects,
}) {
  if (sideEffects == null || sideEffects.isEmpty) {
    return;
  }
  for (final BlocSideEffect sideEffect in sideEffects) {
    if (sideEffect is BlocSideEffectShowSnackbar) {}
    if (sideEffect is BlocSideEffectShowToast) {}

    if (sideEffect is BlocSideEffectShowLoader) {}
    if (sideEffect is BlocSideEffectHideLoader) {}
  }
}

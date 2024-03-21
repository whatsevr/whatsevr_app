import 'package:flutter/material.dart';

import 'bloc_side_effects.dart';

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

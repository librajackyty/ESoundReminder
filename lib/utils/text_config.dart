import 'package:flutter/material.dart';

import 'constants.dart' as c;

enum AppTextSize { L, M, S }

fromSizeValToType(String value) {
  switch (value) {
    case "L":
      return AppTextSize.L;
    case "M":
      return AppTextSize.M;
    case "S":
      return AppTextSize.S;
    default:
      return AppTextSize.L;
  }
}

fromTypeToSizeVal(AppTextSize value) {
  switch (value) {
    case AppTextSize.L:
      return 'L';
    case AppTextSize.M:
      return 'M';
    case AppTextSize.S:
      return 'S';
    default:
      return 'L';
  }
}

void updateAppTxtSize({AppTextSize? size}) {
  switch (size) {
    case AppTextSize.L:
      _updateToLSize();
      break;
    case AppTextSize.M:
      _updateToMSize();
      break;
    case AppTextSize.S:
      _updateToSSize();
      break;
    default:
      _updateToLSize();
  }
}

void _updateToLSize() {
  c.appTextTitleSize = c.textLTitleSize;
  c.appTextNormalSize = c.textLNormalSize;
  c.appTextSmallSize = c.textLSmallSize;
  c.appTextExSmallSize = c.textLExSmallSize;
  c.appTextBtnSize = c.textLBtnSize;
  c.appTextBtnSmallSize = c.textLBtnSmallSize;
}

void _updateToMSize() {
  c.appTextTitleSize = c.textMTitleSize;
  c.appTextNormalSize = c.textMNormalSize;
  c.appTextSmallSize = c.textMSmallSize;
  c.appTextExSmallSize = c.textMExSmallSize;
  c.appTextBtnSize = c.textMBtnSize;
  c.appTextBtnSmallSize = c.textMBtnSmallSize;
}

void _updateToSSize() {
  c.appTextTitleSize = c.textSTitleSize;
  c.appTextNormalSize = c.textSNormalSize;
  c.appTextSmallSize = c.textSSmallSize;
  c.appTextExSmallSize = c.textSExSmallSize;
  c.appTextBtnSize = c.textSBtnSize;
  c.appTextBtnSmallSize = c.textSBtnSmallSize;
}

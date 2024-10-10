enum WhatsevrAspectRatio {
  square(ratio: 1 / 1, valueLabel: '1:1', label: 'Square'),
  portrait4by5(ratio: 4 / 5, valueLabel: '4:5', label: 'Portrait'),
  portrait2by3(ratio: 2 / 3, valueLabel: '2:3', label: 'Portrait'),
  vertical9by16(ratio: 9 / 16, valueLabel: '9:16', label: 'Portrait'),
  widescreen16by9(ratio: 16 / 9, valueLabel: '16:9', label: 'Widescreen'),
  ultraWide21by9(ratio: 21 / 9, valueLabel: '21:9', label: 'Ultra Wide'),
  horizontal3by2(ratio: 3 / 2, valueLabel: '3:2', label: 'Landscape'),
  landscape(ratio: 1.91 / 1, valueLabel: '1.91:1', label: 'Landscape'),
  ;

  final double ratio;
  final String valueLabel;
  final String label;

  const WhatsevrAspectRatio({
    required this.ratio,
    required this.valueLabel,
    required this.label,
  });
}

List<WhatsevrAspectRatio> videoPostAspectRatio = <WhatsevrAspectRatio>[
  WhatsevrAspectRatio.square,
  WhatsevrAspectRatio.horizontal3by2,
  WhatsevrAspectRatio.landscape,
  WhatsevrAspectRatio.widescreen16by9,
  WhatsevrAspectRatio.ultraWide21by9,
];
List<WhatsevrAspectRatio> offerPostAspectRatio = <WhatsevrAspectRatio>[
  WhatsevrAspectRatio.square,
  WhatsevrAspectRatio.horizontal3by2,
  WhatsevrAspectRatio.landscape,
  WhatsevrAspectRatio.widescreen16by9,
  WhatsevrAspectRatio.ultraWide21by9,
];
List<WhatsevrAspectRatio> imagePostAspectRatio = <WhatsevrAspectRatio>[
  WhatsevrAspectRatio.square,
  WhatsevrAspectRatio.portrait4by5,
  WhatsevrAspectRatio.portrait2by3,
  WhatsevrAspectRatio.vertical9by16,
  WhatsevrAspectRatio.horizontal3by2,
  WhatsevrAspectRatio.widescreen16by9,
  WhatsevrAspectRatio.ultraWide21by9,
  WhatsevrAspectRatio.landscape,
];

List<WhatsevrAspectRatio> memoriesAspectRatio = <WhatsevrAspectRatio>[
  WhatsevrAspectRatio.square,
  WhatsevrAspectRatio.portrait4by5,
  WhatsevrAspectRatio.portrait2by3,
  WhatsevrAspectRatio.vertical9by16,
];

List<WhatsevrAspectRatio> flicksAspectRatio = <WhatsevrAspectRatio>[
  WhatsevrAspectRatio.portrait4by5,
  WhatsevrAspectRatio.portrait2by3,
  WhatsevrAspectRatio.vertical9by16,
];

List<WhatsevrAspectRatio> coverMediaAspectRatio = <WhatsevrAspectRatio>[
  WhatsevrAspectRatio.horizontal3by2,
  WhatsevrAspectRatio.widescreen16by9,
  WhatsevrAspectRatio.ultraWide21by9,
  WhatsevrAspectRatio.landscape,
];

extension AspectRatioExtension on double? {
  bool get isAspectRatioLandscapeOrSquare =>
      this != null && this! > 1 || this == 1;
  bool get isAspectRatioPortrait => this != null && this! < 1;
}

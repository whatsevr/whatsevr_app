enum WhatsevrAspectRatio {
  square(ratio: 1 / 1),
  portrait4by5(ratio: 4 / 5),
  vertical9by16(ratio: 9 / 16),
  widescreen16by9(ratio: 16 / 9),
  ultraWide21by9(ratio: 21 / 9),
  landscape(ratio: 1.91 / 1),
  ;

  final double ratio;

  const WhatsevrAspectRatio({required this.ratio});
}

List<WhatsevrAspectRatio> videoPostAspectRatio = <WhatsevrAspectRatio>[
  WhatsevrAspectRatio.square,
  WhatsevrAspectRatio.widescreen16by9,
  WhatsevrAspectRatio.ultraWide21by9,
  WhatsevrAspectRatio.landscape,
];

List<WhatsevrAspectRatio> imagePostAspectRatio = <WhatsevrAspectRatio>[
  WhatsevrAspectRatio.square,
  WhatsevrAspectRatio.portrait4by5,
  WhatsevrAspectRatio.vertical9by16,
  WhatsevrAspectRatio.widescreen16by9,
  WhatsevrAspectRatio.ultraWide21by9,
  WhatsevrAspectRatio.landscape,
];

List<WhatsevrAspectRatio> memoriesAspectRatio = <WhatsevrAspectRatio>[
  WhatsevrAspectRatio.square,
  WhatsevrAspectRatio.portrait4by5,
  WhatsevrAspectRatio.vertical9by16,
];

List<WhatsevrAspectRatio> flicksAspectRatio = <WhatsevrAspectRatio>[
  WhatsevrAspectRatio.portrait4by5,
  WhatsevrAspectRatio.vertical9by16,
];

List<WhatsevrAspectRatio> coverMediaAspectRatio = <WhatsevrAspectRatio>[
  WhatsevrAspectRatio.widescreen16by9,
  WhatsevrAspectRatio.ultraWide21by9,
  WhatsevrAspectRatio.landscape,
];

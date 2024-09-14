enum WhatsevrAspectRatio {
  square(ratio: 1.0),
  fourByFive(ratio: 4 / 5),
  sixteenByNine(ratio: 16 / 9),

  nineBySixteen(ratio: 9 / 16),
  fourByThree(ratio: 4 / 3),
  ;

  final double ratio;

  const WhatsevrAspectRatio({required this.ratio});
}

List<WhatsevrAspectRatio> videoAspectRatio = <WhatsevrAspectRatio>[
  WhatsevrAspectRatio.nineBySixteen,
  WhatsevrAspectRatio.sixteenByNine,
  WhatsevrAspectRatio.square,
];

List<WhatsevrAspectRatio> imageAspectRatio = <WhatsevrAspectRatio>[
  WhatsevrAspectRatio.square,
  WhatsevrAspectRatio.sixteenByNine,
  WhatsevrAspectRatio.fourByThree,
];

List<WhatsevrAspectRatio> memoriesAspectRatio = <WhatsevrAspectRatio>[
  WhatsevrAspectRatio.nineBySixteen,
];

List<WhatsevrAspectRatio> flicksAspectRatio = <WhatsevrAspectRatio>[
  WhatsevrAspectRatio.nineBySixteen,
];

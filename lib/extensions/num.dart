import 'package:postly/config/size_config.dart';

extension SizeExtension on num {
  num get h => SizeConfig.height(this.toDouble());

  num get w => SizeConfig.width(this.toDouble());

  num get text => SizeConfig.textSize(this.toDouble());
}

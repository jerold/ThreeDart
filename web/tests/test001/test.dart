library ThreeDart.test.test001;

import 'package:ThreeDart/ThreeDart.dart' as ThreeDart;
import 'package:ThreeDart/Shapes.dart' as Shapes;
import 'package:ThreeDart/Movers.dart' as Movers;
import 'package:ThreeDart/Techniques.dart' as Techniques;
import 'package:ThreeDart/Scenes.dart' as Scenes;
import '../../common/common.dart' as common;

void main() {
  new common.ShellPage("Test 001")
    ..addLargeCanvas("testCanvas")
    ..addPar(["Test of the Depth shader, a basic fog shader with a single auto-rotating shape."])
    ..addPar(["«[Back to Tests|../]"]);

  ThreeDart.Entity obj = new ThreeDart.Entity()
    ..shape = Shapes.toroid()
    ..mover = new Movers.Rotater();

  Scenes.EntityPass pass = new Scenes.EntityPass()
    ..children.add(obj)
    ..technique = new Techniques.Depth(fogStart: 3.0, fogStop: 6.0)
    ..camera.mover = new Movers.Constant.translate(0.0, 0.0, 5.0);

  ThreeDart.ThreeDart td = new ThreeDart.ThreeDart.fromId("testCanvas")
    ..scene = pass;

  common.showFPS(td);
}

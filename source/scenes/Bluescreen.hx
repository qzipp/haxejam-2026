package scenes;

import flixel.FlxG;
import flixel.FlxState;
import flixel.text.FlxText;
import system.State;


class Bluescreen extends FlxState {
  public function new() {
    super();

    FlxG.camera.bgColor = 0xFF0082C3;
		FlxG.sound.play(AssetPaths.tada__wav);
    
    var face = new FlxText(50, 50, ":c");
    face.size = 32;
    add(face);

    var score = new FlxText(150, 50);
    score.size = 32;
    score.text = 'score: ${State.SCORE}\n u win';
    add(score);

  }
}
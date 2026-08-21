package objects;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxContainer;
import objects.ui.UIButton;
import objects.ui.UIObject;

class Taskbar extends UIObject {
  public function new() {
    super();
  
    // setGraphicSize(1, 1);
    makeGraphic(1, 1, 0x00FFFFFF);

    
    y = FlxG.height - 16;

    var bg = new FlxSprite();
		bg.makeGraphic(1, 1, 0xFF19191D);
		bg.setGraphicSize(FlxG.width, 16);
		bg.updateHitbox();
    bg.y = y;
    add(bg);

    var start_button = new UIButton();
    start_button.y = y;
    start_button.setGraphicSize(48, 16);
    start_button.updateHitbox();

    var logo = new FlxSprite();
    logo.loadGraphic(AssetPaths.haxe__png);
    logo.setGraphicSize(12, 12);
    logo.x = start_button.x;
    logo.y = start_button.y;
    start_button.add(logo);

    // start_button.text.y = y;
    start_button.text.text = "start";
    start_button.text.offset.set(-7, 0);
    add(start_button);
  }
}
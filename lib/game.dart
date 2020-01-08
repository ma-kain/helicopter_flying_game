import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import 'helicopter.dart';

class GameScreen extends BaseGame {
  /*
  * Steps for creating Sprite sheet
  * https://www.codeandweb.com/free-sprite-sheet-packer
  * Upload sprites one-by-one to tool and generate png and json
  * json has correct spritesheet dimensions under meta/size property
  * 
  */
  
  final Size _screenSize;
  Helicopter _helicopter; 

  GameScreen(this._screenSize){
    _helicopter = Helicopter(_screenSize);
    _helicopter.x = 0.0;
    _helicopter.y = 50.0;
    //add top boundary
    //add bottom boundary
    //add left boundary
    //add right boundary

    add(_helicopter);
  }
}

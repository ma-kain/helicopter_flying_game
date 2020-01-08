import 'dart:math' as math;

import 'package:vector_math/vector_math_64.dart' as vec;
import 'package:flame/components/animation_component.dart';
import 'package:flutter/material.dart';
import 'package:flame/animation.dart' as flame_animation;

class Helicopter extends AnimationComponent {
  static const _width = 86.0;
  static const _height = 68.0;
  static const _imagePath = 'helicopter.png';
  static const _frames = 4;
  static const deg2rad = math.pi / 180.0;

  static final _animation = flame_animation.Animation.sequenced(_imagePath, _frames, 
    textureWidth: _width, textureHeight: _height);

  // static const stepSize = 10.0;
  var _angle = 10.0;
  vec.Vector2 _velVec;
  vec.Vector2 _posVec;

  final Size screenSize;

  Helicopter(this.screenSize) : super(_width, _height, _animation){
    var velocity = 500.0;
    var radians = _angle * deg2rad;
    var velx = velocity * math.cos(radians);
    var vely = velocity * math.sin(radians);
    _velVec = vec.Vector2(velx, vely);
    _posVec = vec.Vector2(0.0, 0.0);
    renderFlipX = false;
  }

  @override
  void update(double dt) {
    super.update(dt);
    _posVec = _posVec + (_velVec * dt);
    x = _posVec.x;
    y = _posVec.y;
    // print('$x $y $dt $_angle');

    _detectBoundaryCollision();
  }

  _detectBoundaryCollision(){
    if (x <= (0.0 - width) || x >= screenSize.width) {
      var oldAngle = _angle;
      _angle = 180 - oldAngle;
      var angleOfRotation = _angle - oldAngle;
      _rebound(angleOfRotation);

    } else if (y <= (0.0 - height) || y >= screenSize.height) {
      _angle = - _angle;
      var angleOfRotation = _angle * 2;
      _rebound(angleOfRotation);
    }

  }

  _rebound(angleOfRotation) {
    //Following this video https://www.youtube.com/watch?v=DOMg0lXWatM
    //This is rotation matrix for vector rotation
    var radians = angleOfRotation * deg2rad;
    vec.Matrix2 multiplier = vec.Matrix2(math.cos(radians), -math.sin(radians), 
      math.sin(radians), math.cos(radians));
    
    //after multiple, vector is rotated by radians (anti-clockwise)
    _velVec.postmultiply(multiplier);
    _angle = math.atan2(_velVec.y, _velVec.x) / deg2rad;

    //this will flip helicopter image
    renderFlipX = _velVec.x < 0 ? true : false;
  }

}
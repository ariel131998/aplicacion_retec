//palette.dart
import 'package:flutter/material.dart'; 
class Palette { 
  static const MaterialColor kToDark =  MaterialColor( 
  0xFFFFD54F, // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch. 
     <int, Color>{ 
      50:   Color(0xf3d780FF),//10% 
      100:  Color(0xf5db8eFF),//20% 
      200:  Color(0xf6e09cFF),//30% 
      300:  Color(0xf7e4aaFF),//40% 
      400:  Color(0xf9e9b9FF),//50% 
      500:  Color(0xfaedc7FF),//60% 
      600:  Color(0xfbf2d5FF),//70% 
      700:  Color(0xfcf6e3FF),//80% 
      800:  Color(0xfefbf1FF),//90% 
      900:  Color(0xffffffFF),//100% 
    }, 
  ); 
} // you can define define int 500 as the default shade and add your lighter tints above and darker tints below. 
//palette.dart
import 'package:flutter/material.dart'; 
class Palette { 
  static const MaterialColor kToDark =  MaterialColor( 
  0xFFFFD54F, // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch. 
     <int, Color>{ 
      50: const Color(0xf3d780),//10% 
      100: const Color(0xf5db8e),//20% 
      200: const Color(0xf6e09c),//30% 
      300: const Color(0xf7e4aa),//40% 
      400: const Color(0xf9e9b9),//50% 
      500: const Color(0xfaedc7),//60% 
      600: const Color(0xfbf2d5),//70% 
      700: const Color(0xfcf6e3),//80% 
      800: const Color(0xfefbf1),//90% 
      900: const Color(0xffffff),//100% 
    }, 
  ); 
} // you can define define int 500 as the default shade and add your lighter tints above and darker tints below. 
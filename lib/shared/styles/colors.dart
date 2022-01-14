
//palette.dart
import 'package:flutter/material.dart'; 
class Palette { 
  static const MaterialColor myColor =  MaterialColor( 
    0xff0097A7, // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch. 
     <int, Color>{ 
      50:  Color(0xff0097a7),//10% 
      100:  Color(0xff008896),//20% 
      200:  Color(0xff007986),//30% 
      300:  Color(0xff006a75),//40% 
      400:  Color(0xff005b64),//50% 
      500:  Color(0xff004c54),//60% 
      600:  Color(0xff003c43),//70% 
      700:  Color(0xff002d32),//80% 
      800:  Color(0xff001e21),//90% 
      900:  Color(0xff000f11),//100% 
    }, 
  ); 
} 
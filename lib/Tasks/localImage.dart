import 'package:flutter/material.dart';

class Localimages extends StatelessWidget {
  const Localimages({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Local Images"),
      ),
      body: Center(
        child: Image(

              image: AssetImage('Assets/images.jpeg'), // image source (Asset/Network/File/Memory)
              width: 300,                               // image ki width
              height:  300,                              // image ki height
              fit: BoxFit.contain,                        // space ke andar kaise fit ho
              alignment: Alignment.center,              // image ka alignment box ke andar

              colorBlendMode: BlendMode.darken,         // color kaise blend ho (color ke sath use hota hai)
              repeat: ImageRepeat.noRepeat,             // image repeat kare ya nahi (tile jaisa)
              filterQuality: FilterQuality.medium,      // scaling quality (low/medium/high)
              gaplessPlayback: false,                   // naya image load hone tak purana dikhaye rakhe
              semanticLabel: "description",             // accessibility ke liye label
              excludeFromSemantics: false,              // screen reader se exclude karna hai ya nahi
            )

      ),
    );
  }
}
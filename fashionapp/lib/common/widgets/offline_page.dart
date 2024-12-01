import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class OfflinePage extends StatelessWidget {
  const OfflinePage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Icon(
          Ionicons.wifi_outline,
          size: 150,
          color: Colors.grey,
        ),
         Center(
           child: SizedBox(
            width: MediaQuery.of(context).size.width* 0.7,
             child: const Text(
              "Oops! Seems like youare not connected to the internet.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.black),
                     ),
           ),
         )
      ],
    );
  }
}

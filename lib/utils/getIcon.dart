import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Widget getIcon(String animal) {
  if (animal.toLowerCase() == "dog")
    return const FaIcon(FontAwesomeIcons.dog, size: 28, color: Colors.white);
  else if (animal.toLowerCase() == "cat")
    return const FaIcon(FontAwesomeIcons.cat, size: 28, color: Colors.white);
  else if (animal.toLowerCase() == "bird")
    return const FaIcon(FontAwesomeIcons.kiwiBird,
        size: 28, color: Colors.white);
  else
    return const FaIcon(FontAwesomeIcons.fish, size: 28, color: Colors.white);
}

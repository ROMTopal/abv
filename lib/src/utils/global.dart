import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class IconModel {
  FaIcon icon;
  String display;
  String id;

  IconModel({required this.icon, required this.display, required this.id});
}

class Global {
  static List<IconModel> iconsList = [
    IconModel(icon: const FaIcon(FontAwesomeIcons.notesMedical), id: "notesMedical", display: "Notes Medical"),
    IconModel(icon: const FaIcon(FontAwesomeIcons.file), id: "file", display: "File"),
    IconModel(icon: const FaIcon(FontAwesomeIcons.piggyBank), id: "piggyBank", display: "Piggy Bank"),
    IconModel(icon: const FaIcon(FontAwesomeIcons.car), id: "car", display: "Car"),
    IconModel(icon: const FaIcon(FontAwesomeIcons.tag), id: "tag", display: "Tag"),
    IconModel(icon: const FaIcon(FontAwesomeIcons.star), id: "star", display: "Star"),
    IconModel(icon: const FaIcon(FontAwesomeIcons.heart), id: "heart", display: "Heart"),
    IconModel(icon: const FaIcon(FontAwesomeIcons.heartPulse), id: "heartPulse", display: "Heart Pulse"),
    IconModel(icon: const FaIcon(FontAwesomeIcons.house), id: "house", display: "House"),
    IconModel(icon: const FaIcon(FontAwesomeIcons.briefcase), id: "briefcase", display: "Briefcase"),
    IconModel(icon: const FaIcon(FontAwesomeIcons.arrowTrendUp), id: "arrowTrendUp", display: "Arrow Trend Up"),
    IconModel(icon: const FaIcon(FontAwesomeIcons.receipt), id: "receipt", display: "Receipt"),
    IconModel(icon: const FaIcon(FontAwesomeIcons.fileInvoice), id: "fileInvoice", display: "File Invoice"),
    IconModel(icon: const FaIcon(FontAwesomeIcons.paw), id: "paw", display: "Paw"),
    IconModel(icon: const FaIcon(FontAwesomeIcons.plug), id: "plug", display: "Plug"),
    IconModel(icon: const FaIcon(FontAwesomeIcons.faucet), id: "faucet", display: "Faucet"),
    IconModel(icon: const FaIcon(FontAwesomeIcons.envelope), id: "envelope", display: "Envelope"),
    IconModel(icon: const FaIcon(FontAwesomeIcons.houseSignal), id: "houseSignal", display: "House Signal"),
    IconModel(icon: const FaIcon(FontAwesomeIcons.couch), id: "couch", display: "Couch"),
    IconModel(icon: const FaIcon(FontAwesomeIcons.graduationCap), id: "graduationCap", display: "Graduation Cap"),
    IconModel(icon: const FaIcon(FontAwesomeIcons.landmark), id: "landmark", display: "Landmark"),
    IconModel(icon: const FaIcon(FontAwesomeIcons.scaleBalanced), id: "scaleBalanced", display: "Scale Balanced"),
    IconModel(icon: const FaIcon(FontAwesomeIcons.handshake), id: "handshake", display: "Handshake"),
  ];

  static IconModel getIcon(String id)
  {
    return iconsList.firstWhere((element) => element.id == id);
  }

}

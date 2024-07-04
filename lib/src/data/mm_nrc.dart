import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:mm_nrc_kit/src/data/nrc_data.dart';
import 'package:mm_nrc_kit/src/model/model.dart';

class MmNrc {
  static bool checkValid({required String enNrcString}) {
    RegExp enRegExp = RegExp(NrcData.enPattern);
    if (enRegExp.hasMatch(enNrcString)) {
      return true;
    }
    return false;
  }

  static bool checkValidMm({required String mmNrcString}) {
    RegExp enRegExp = RegExp(NrcData.mmPattern);
    if (enRegExp.hasMatch(mmNrcString)) {
      return true;
    }
    return false;
  }

  static bool checkPrefixValid({required String enNrcString}) {
    RegExp enRegExp = RegExp(NrcData.enPrefixPattern);
    if (enRegExp.hasMatch(enNrcString)) {
      return true;
    }
    return false;
  }

  static bool checkPrefixValidMm({required String mmNrcString}) {
    RegExp enRegExp = RegExp(NrcData.mmPrefixPattern);
    if (enRegExp.hasMatch(mmNrcString)) {
      return true;
    }
    return false;
  }

  static Future<Township> getNrcTownshipsByShortCode(
      {required String shortCode}) async {
    List<Township> townshipList = await townships();
    Township township = townshipList.firstWhere((element) =>
        (element.short.en == shortCode || element.short.mm == shortCode));
    return township;
  }

  static Future<Township> getNrcTownshipsByStateCode(
      {required String stateCode}) async {
    List<Township> townshipList = await townships();
    Township township =
        townshipList.firstWhere((element) => element.stateCode == stateCode);
    return township;
  }

  static Future<Township> getNrcTownshipsByStateId(
      {required String stateId}) async {
    List<Township> townshipList = await townships();
    Township township =
        townshipList.firstWhere((element) => element.stateId == stateId);
    return township;
  }

  static Future<List<Township>> getNrcTownshipListByStateId(
      {required String stateId}) async {
    List<Township> townshipList = await townships();
    List<Township> township =
        townshipList.where((element) => element.stateId == stateId).toList();
    return township;
  }

  static Future<List<Township>> getNrcTownshipListByStateCode(
      {required String stateCode}) async {
    List<Township> townshipList = await townships();
    List<Township> township = townshipList
        .where((element) => element.stateCode == stateCode)
        .toList();
    return township;
  }

  static Future<Types> getNrcTypeById({required String typeId}) async {
    List<Types> typesList = await types();
    Types type = typesList.firstWhere((element) => element.id == typeId);
    return type;
  }

  static Future<Types> getNrcTypeByName({required String nrcType}) async {
    List<Types> typesList = await types();
    Types type = typesList.firstWhere((element) =>
        (element.name.en == nrcType || element.name.mm == nrcType));
    return type;
  }

  static Future<StateDivision?> getStateByStateCode(
      {required String stateCode}) async {
    List<StateDivision?> stateList = await states();

    StateDivision? state = stateList.firstWhere(
      (element) =>
          (element?.number.en == stateCode || element?.number.mm == stateCode),
    );
    return state;
  }

  static Nrc splitNrc(String nrcFullString) {
    var list = nrcFullString.split(RegExp(r"[/()]"));
    Nrc nrc = Nrc(
        stateCode: list[0],
        townshipCode: list[1],
        nrcType: list[2],
        nrcNo: list[3]);
    return nrc;
  }

  static Future<List<StateDivision?>> states() async {
    final String response = await rootBundle.loadString(NrcData.state);
    Iterable data = await json.decode(response);
    List<StateDivision> states = List<StateDivision>.from(
        data.map((model) => StateDivision.fromMap(model)));
    return states;
  }

  static Future<List<Township>> townships() async {
    final String response = await rootBundle.loadString(NrcData.township);
    Iterable data = await json.decode(response);

    List<Township> township =
        List<Township>.from(data.map((model) => Township.fromMap(model)));

    return township;
  }

  static Future<List<Types>> types() async {
    final String response = await rootBundle.loadString(NrcData.type);
    Iterable data = await json.decode(response);
    List<Types> type =
        List<Types>.from(data.map((model) => Types.fromMap(model)));

    return type;
  }
}

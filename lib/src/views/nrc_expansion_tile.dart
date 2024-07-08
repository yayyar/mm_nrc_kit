import 'package:flutter/material.dart';
import 'package:mm_nrc_kit/src/config/constants.dart';
import 'package:mm_nrc_kit/src/data/mm_nrc.dart';
import 'package:mm_nrc_kit/src/model/model.dart';
import 'package:mm_nrc_kit/src/utils/digit_util.dart';
import 'package:mm_nrc_kit/src/widgets/ui_expansion_tile.dart';

import 'nrc_picker.dart';

class NrcExpansionTile extends StatefulWidget {
  const NrcExpansionTile(
      {super.key,
      required this.onChanged,
      this.nrcValueString,
      this.pickerItemColor,
      this.language = NrcLanguage.myanmar,
      this.backgroundColor,
      this.leadingTitleColor});
  final Function(String?) onChanged;
  final String? nrcValueString;
  final Color? pickerItemColor;
  final NrcLanguage language;
  final Color? backgroundColor;
  final Color? leadingTitleColor;

  @override
  State<NrcExpansionTile> createState() => _NrcPopupMenuButtonState();
}

class _NrcPopupMenuButtonState extends State<NrcExpansionTile> {
  String? _nrcValueString;

  int _stateDivisionIndex = 0;
  int _townshipIndex = 0;
  int _typeIndex = 0;

  List<StateDivision?> _stateDevisionList = [];
  List<Township> _townshipList = [];
  List<Types> _typeList = [];

  String _trailingLabel = "";
  String _titleLabel = "";

  _getTypeList() {
    MmNrc.types().then((value) {
      _typeList = value;
    });
  }

  _getStateList() {
    MmNrc.states().then((value) {
      _stateDevisionList = value;
      if (_nrcValueString == null) {
        MmNrc.getNrcTownshipListByStateCode(stateCode: defaultStateCode)
            .then((value) {
          setState(() {
            _townshipList = value;
            debugPrint("_getStateList _townshipList => $_townshipList");
          });
        });
      }
    });
  }

  void _checkSelectedIndex() {
    if (_nrcValueString != null) {
      if (widget.language == NrcLanguage.english) {
        if (MmNrc.checkPrefixValid(enNrcString: _nrcValueString!)) {
          Nrc nrc = MmNrc.splitNrc(_nrcValueString!);

          MmNrc.getNrcTownshipListByStateCode(stateCode: nrc.stateCode)
              .then((value) {
            setState(() {
              _townshipList = value;
              debugPrint(
                  "_checkSelectedIndex one _townshipList => $_townshipList");
            });
            _stateDivisionIndex = _stateDevisionList
                .indexWhere((element) => element!.number.en == nrc.stateCode);

            _townshipIndex = _townshipList.indexWhere((element) =>
                element.short.en.toLowerCase() ==
                nrc.townshipCode.toLowerCase());

            _typeIndex = _typeList
                .indexWhere((element) => element.name.en == nrc.nrcType);
          });
        }
      } else {
        if (MmNrc.checkPrefixValidMm(mmNrcString: _nrcValueString!)) {
          Nrc nrc = MmNrc.splitNrc(_nrcValueString!);

          String stateCode = DigitUtil.myanmarToEnglishDigit(nrc.stateCode);

          MmNrc.getNrcTownshipListByStateCode(stateCode: stateCode)
              .then((value) {
            setState(() {
              _townshipList = value;
              debugPrint(
                  "_checkSelectedIndex two _townshipList => $_townshipList");
            });
            _stateDivisionIndex = _stateDevisionList
                .indexWhere((element) => element!.number.mm == nrc.stateCode);

            _townshipIndex = _townshipList.indexWhere((element) =>
                element.short.mm.toLowerCase() ==
                nrc.townshipCode.toLowerCase());

            _typeIndex = _typeList
                .indexWhere((element) => element.name.mm == nrc.nrcType);
          });
        }
      }
      debugPrint(
          "ExpansionTile:  $_stateDivisionIndex / $_townshipIndex / $_typeIndex");
    }
  }

  @override
  void initState() {
    _nrcValueString = widget.nrcValueString;

    _getStateList();
    _getTypeList();
    _checkSelectedIndex();

    _trailingLabel = widget.language == NrcLanguage.english
        ? defaultNrcValueLabel
        : defaultNrcValueLabelMm;

    _titleLabel =
        widget.language == NrcLanguage.english ? nrcLabel : nrcLabelMm;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);

    return UIExpansionTile(
      leadingTitleColor: widget.leadingTitleColor,
      backgroundColor: widget.backgroundColor,
      onExpansionChanged: (isExpand) {
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.focusedChild?.unfocus();
        }
      },
      leadingTitle: _titleLabel,
      trailingTitle: _nrcValueString ?? _trailingLabel,
      children: [
        NrcPicker(
            language: widget.language,
            pickerItemColor: widget.pickerItemColor,
            stateDevisionList: _stateDevisionList,
            townshipList: _townshipList,
            typeList: _typeList,
            nrcValueString: _nrcValueString,
            selectedTypeIndex: _typeIndex,
            selectedTownshipIndex: _townshipIndex,
            selectedStateDivisionIndex: _stateDivisionIndex,
            onSelected: (value) {
              setState(() {
                _nrcValueString = value;
              });
              widget.onChanged(value);
            },
            onSelectedIndex: (value) {
              _stateDivisionIndex = value[0];
              _townshipIndex = value[1];
              _typeIndex = value[2];
            }),
      ],
    );
  }
}

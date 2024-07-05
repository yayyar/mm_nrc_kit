import 'package:flutter/material.dart';
import 'package:mm_nrc_kit/src/config/constants.dart';
import 'package:mm_nrc_kit/src/data/mm_nrc.dart';
import 'package:mm_nrc_kit/src/model/model.dart';
import 'package:mm_nrc_kit/src/widgets/ui_expansion_tile.dart';

import 'nrc_picker.dart';

class NrcExpansionTile extends StatefulWidget {
  const NrcExpansionTile(
      {super.key,
      required this.onChanged,
      this.nrcValueString,
      this.pickerItemColor,
      this.language = NrcLanguage.myanmar});
  final Function(String?) onChanged;
  final String? nrcValueString;
  final Color? pickerItemColor;
  final NrcLanguage language;

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

  void _getTypeList() {
    MmNrc.types().then((value) {
      _typeList = value;
    });
  }

  void _getStateList() {
    MmNrc.states().then((value) {
      _stateDevisionList = value;
      MmNrc.getNrcTownshipListByStateId(stateId: defaultStateId).then((value) {
        setState(() {
          _townshipList = value;
        });
      });
    });
  }

  @override
  void initState() {
    if (widget.nrcValueString != null &&
        MmNrc.checkPrefixValid(enNrcString: widget.nrcValueString ?? "")) {
      _nrcValueString = widget.nrcValueString!;
    }
    _getStateList();
    _getTypeList();

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

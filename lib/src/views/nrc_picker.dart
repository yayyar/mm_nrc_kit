import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mm_nrc_kit/src/config/colors.dart';
import 'package:mm_nrc_kit/src/config/constants.dart';
import 'package:mm_nrc_kit/src/data/mm_nrc.dart';
import 'package:mm_nrc_kit/src/model/model.dart';

class NrcPicker extends StatefulWidget {
  const NrcPicker(
      {super.key,
      required this.onSelected,
      required this.nrcPrefixString,
      required this.stateDevisionList,
      required this.townshipList,
      required this.typeList,
      required this.onSelectedIndex,
      this.selectedStateDivisionIndex = 0,
      this.selectedTownshipIndex = 0,
      this.selectedTypeIndex = 0,
      this.pickerColor,
      this.pickerItemColor});

  final Function(String) onSelected;
  final Function(List<int>) onSelectedIndex;
  final String nrcPrefixString;
  final List<StateDivision?> stateDevisionList;
  final List<Township> townshipList;
  final List<Types> typeList;
  final int selectedStateDivisionIndex;
  final int selectedTownshipIndex;
  final int selectedTypeIndex;
  final Color? pickerColor;
  final Color? pickerItemColor;

  @override
  State<NrcPicker> createState() => _NrcPickerState();
}

class _NrcPickerState extends State<NrcPicker> {
  int _defaultStateDivisionIndex = 0;
  int _defaultTownshipIndex = 0;
  int _defaultTypeIndex = 0;

  List<StateDivision?> _stateDevisionList = [];
  List<Township> _townshipList = [];
  List<Types> _typeList = [];

  String _stateDivision = defaultStateCodeHint;
  String _township = defaultTownshipHint;
  String _type = defaultTypeHint;

  String _nrcPrefixString = "";

  void _updateNrc() {
    _nrcPrefixString = "$_stateDivision/$_township($_type)";
    widget.onSelected(_nrcPrefixString);
    widget.onSelectedIndex(
        [_defaultStateDivisionIndex, _defaultTownshipIndex, _defaultTypeIndex]);
  }

  void _onTypeSelectedItemChanged(int index) {
    _defaultTypeIndex = index;
    if (_typeList.isNotEmpty) {
      _type = _typeList[index].name.en;
      _updateNrc();
    }
  }

  void _onTownshipSelectedItemChanged(int index) async {
    _defaultTownshipIndex = index;
    if (_townshipList.isNotEmpty) {
      try {
        _township = _townshipList[index].short.en;
      } on Error {
        _township = _townshipList[0].short.en;
      }
      _updateNrc();
    }
  }

  void _onStateDivisionSelectedItemChanged(index, setState) {
    _defaultStateDivisionIndex = index;
    if (_stateDevisionList.isNotEmpty) {
      _stateDivision = _stateDevisionList[index]!.number.en;

      String id = _stateDevisionList[index]!.id;
      MmNrc.getNrcTownshipListByStateId(stateId: id).then((value) {
        setState(() {
          _townshipList = value;
        });
        _onTownshipSelectedItemChanged(_defaultTownshipIndex);
      });
    }
  }

  @override
  void initState() {
    _defaultStateDivisionIndex = widget.selectedStateDivisionIndex;
    _defaultTownshipIndex = widget.selectedTownshipIndex;
    _defaultTypeIndex = widget.selectedTypeIndex;

    _stateDevisionList = widget.stateDevisionList;
    _townshipList = widget.townshipList;
    _typeList = widget.typeList;

    _nrcPrefixString = widget.nrcPrefixString;

    // if (MmNrc.checkPrefixValid(enNrcString: _nrcPrefixString)) {
    Nrc nrc = MmNrc.splitNrc(_nrcPrefixString);
    _stateDivision = nrc.stateCode;
    _township = nrc.townshipCode;
    _type = nrc.nrcType;
    // }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 50,
          child: CupertinoPicker(
              backgroundColor: widget.pickerColor ?? lightTintColor,
              itemExtent: 32.0,
              scrollController: FixedExtentScrollController(
                initialItem: _defaultStateDivisionIndex,
              ),
              onSelectedItemChanged: (index) {
                _onStateDivisionSelectedItemChanged(index, setState);
              },
              children: [
                for (var data in _stateDevisionList) ...[
                  Center(
                    child: Text(
                      data!.number.en,
                      style: TextStyle(
                          color: widget.pickerItemColor ?? Colors.black),
                    ),
                  )
                ]
              ]),
        ),
        SizedBox(
          width: 155,
          child: CupertinoPicker(
            backgroundColor: widget.pickerColor ?? lightTintColor,
            itemExtent: 32.0,
            scrollController: FixedExtentScrollController(
              initialItem: _defaultTownshipIndex,
            ),
            onSelectedItemChanged: _onTownshipSelectedItemChanged,
            children: [
              for (var data in _townshipList) ...[
                Center(
                  child: Text(
                    data.short.en,
                    style: TextStyle(
                        color: widget.pickerItemColor ?? Colors.black),
                  ),
                )
              ]
            ],
          ),
        ),
        SizedBox(
          width: 50,
          child: CupertinoPicker(
            backgroundColor: widget.pickerColor ?? lightTintColor,
            itemExtent: 32.0,
            scrollController: FixedExtentScrollController(
              initialItem: _defaultTypeIndex,
            ),
            onSelectedItemChanged: _onTypeSelectedItemChanged,
            children: [
              for (var data in _typeList) ...[
                Center(
                  child: Text(
                    data.name.en,
                    style: TextStyle(
                        color: widget.pickerItemColor ?? Colors.black),
                  ),
                )
              ]
            ],
          ),
        ),
      ],
    );
  }
}

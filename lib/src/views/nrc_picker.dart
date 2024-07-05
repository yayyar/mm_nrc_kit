import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mm_nrc_kit/src/config/constants.dart';
import 'package:mm_nrc_kit/src/data/mm_nrc.dart';
import 'package:mm_nrc_kit/src/model/model.dart';

class NrcPicker extends StatefulWidget {
  const NrcPicker(
      {super.key,
      required this.onSelected,
      this.nrcValueString,
      required this.stateDevisionList,
      required this.townshipList,
      required this.typeList,
      required this.onSelectedIndex,
      this.selectedStateDivisionIndex = 0,
      this.selectedTownshipIndex = 0,
      this.selectedTypeIndex = 0,
      this.pickerItemColor,
      this.language = NrcLanguage.myanmar});

  final Function(String?) onSelected;
  final Function(List<int>) onSelectedIndex;
  final String? nrcValueString;
  final List<StateDivision?> stateDevisionList;
  final List<Township> townshipList;
  final List<Types> typeList;
  final int selectedStateDivisionIndex;
  final int selectedTownshipIndex;
  final int selectedTypeIndex;
  final Color? pickerItemColor;
  final NrcLanguage language;

  @override
  State<NrcPicker> createState() => _NrcPickerState();
}

class _NrcPickerState extends State<NrcPicker> {
  final TextEditingController _nrcTextEditingController =
      TextEditingController();

  int _defaultStateDivisionIndex = 0;
  int _defaultTownshipIndex = 0;
  int _defaultTypeIndex = 0;

  List<StateDivision?> _stateDevisionList = [];
  List<Township> _townshipList = [];
  List<Types> _typeList = [];

  String _stateDivision = "";
  String _township = "";
  String _type = "";

  String? _nrcValueString;
  String _nrcNumber = "";

  String _numberTextFieldHint = "";
  String _nrcClearLabel = "";

  late FixedExtentScrollController _townshipScrollController;

  void _updateNrc({isClear = false}) {
    _nrcValueString =
        !isClear ? "$_stateDivision/$_township($_type)$_nrcNumber" : null;
    widget.onSelected(_nrcValueString);
    widget.onSelectedIndex(
        [_defaultStateDivisionIndex, _defaultTownshipIndex, _defaultTypeIndex]);
  }

  void _onTypeSelectedItemChanged(int index) {
    _defaultTypeIndex = index;
    if (_typeList.isNotEmpty) {
      _type = widget.language == NrcLanguage.english
          ? _typeList[index].name.en
          : _typeList[index].name.mm;
      _updateNrc();
    }
  }

  void _onTownshipSelectedItemChanged(int index) async {
    _defaultTownshipIndex = index;
    if (_townshipList.isNotEmpty) {
      _township = widget.language == NrcLanguage.english
          ? _townshipList[index].short.en
          : _townshipList[index].short.mm;
      _updateNrc();
    }
  }

  void _onStateDivisionSelectedItemChanged(index, setState) {
    _defaultStateDivisionIndex = index;
    if (_stateDevisionList.isNotEmpty) {
      _stateDivision = widget.language == NrcLanguage.english
          ? _stateDevisionList[index]!.number.en
          : _stateDevisionList[index]!.number.mm;

      String id = _stateDevisionList[index]!.id;
      MmNrc.getNrcTownshipListByStateId(stateId: id).then((value) {
        setState(() {
          _townshipList = value;
          _defaultTownshipIndex = 0;
          _townshipScrollController.jumpToItem(_defaultTownshipIndex);
        });

        _onTownshipSelectedItemChanged(_defaultTownshipIndex);
      });
    }
  }

  @override
  void initState() {
    _nrcValueString = widget.nrcValueString;

    _nrcClearLabel = widget.language == NrcLanguage.english
        ? defaultNrcClearLabel
        : defaultNrcClearLabelMm;

    _stateDevisionList = widget.stateDevisionList;
    _townshipList = widget.townshipList;
    _typeList = widget.typeList;

    _checkNRC();

    super.initState();
  }

  Future<void> _checkNRC() async {
    if (_nrcValueString != null) {
      if (widget.language == NrcLanguage.english) {
        if (MmNrc.checkValid(enNrcString: _nrcValueString!)) {
          Nrc nrc = MmNrc.splitNrc(_nrcValueString!);
          _stateDivision = nrc.stateCode;
          _township = nrc.townshipCode;
          _type = nrc.nrcType;
          _nrcTextEditingController.text = nrc.nrcNo;
          _nrcNumber = nrc.nrcNo;
          setState(() {
            _defaultStateDivisionIndex = widget.selectedStateDivisionIndex;
            _defaultTownshipIndex = widget.selectedTownshipIndex;
            _defaultTypeIndex = widget.selectedTypeIndex;
          });
        }
      } else {
        if (MmNrc.checkValidMm(mmNrcString: _nrcValueString!)) {
          Nrc nrc = MmNrc.splitNrc(_nrcValueString!);
          _stateDivision = nrc.stateCode;
          _township = nrc.townshipCode;
          _type = nrc.nrcType;
          _nrcTextEditingController.text = nrc.nrcNo;
          _nrcNumber = nrc.nrcNo;
          setState(() {
            _defaultStateDivisionIndex = widget.selectedStateDivisionIndex;
            _defaultTownshipIndex = widget.selectedTownshipIndex;
            _defaultTypeIndex = widget.selectedTypeIndex;
          });
        }
      }
    } else {
      setState(() {
        _defaultStateDivisionIndex = 7;
        _defaultTownshipIndex = 22;
        _defaultTypeIndex = 0;
      });

      _numberTextFieldHint = widget.language == NrcLanguage.english
          ? defaultNrcNumberHint
          : defaultNrcNumberHintMm;

      _stateDivision = widget.language == NrcLanguage.english
          ? defaultStateCodeHint
          : defaultStateCodeHintMm;
      _township = widget.language == NrcLanguage.english
          ? defaultTownshipHint
          : defaultTownshipHintMm;
      _type = widget.language == NrcLanguage.english
          ? defaultTypeHint
          : defaultTypeHintMm;
    }

    _townshipScrollController = FixedExtentScrollController(
      initialItem: _defaultTownshipIndex,
    );

    debugPrint(
        "_defaultStateDivisionIndex => $_defaultStateDivisionIndex , _defaultTownshipIndex => $_defaultTownshipIndex, _defaultTypeIndex => $_defaultTypeIndex");

    await Future.delayed(const Duration(milliseconds: 500));
    _updateNrc();
  }

  _onChanged(value) {
    _nrcNumber = value;
    _updateNrc();
  }

  _clearNrcValue() {
    _updateNrc(isClear: true);
    _nrcTextEditingController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Divider(
          thickness: 0.5,
          height: 1,
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 50,
              height: 200,
              child: CupertinoPicker(
                  itemExtent:
                      widget.language == NrcLanguage.english ? 32.0 : 40.0,
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
                          widget.language == NrcLanguage.english
                              ? data!.number.en
                              : data!.number.mm,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: widget.pickerItemColor ?? Colors.black),
                        ),
                      )
                    ]
                  ]),
            ),
            SizedBox(
              width: 155,
              height: 200,
              child: CupertinoPicker(
                itemExtent:
                    widget.language == NrcLanguage.english ? 32.0 : 40.0,
                scrollController: _townshipScrollController,
                onSelectedItemChanged: _onTownshipSelectedItemChanged,
                children: [
                  for (var data in _townshipList) ...[
                    Center(
                      child: Text(
                        widget.language == NrcLanguage.english
                            ? data.short.en
                            : data.short.mm,
                        style: TextStyle(
                            color: widget.pickerItemColor ?? Colors.black),
                      ),
                    )
                  ]
                ],
              ),
            ),
            SizedBox(
              width: widget.language == NrcLanguage.english ? 50 : 100,
              height: 200,
              child: CupertinoPicker(
                itemExtent:
                    widget.language == NrcLanguage.english ? 32.0 : 40.0,
                scrollController: FixedExtentScrollController(
                  initialItem: _defaultTypeIndex,
                ),
                onSelectedItemChanged: _onTypeSelectedItemChanged,
                children: [
                  for (var data in _typeList) ...[
                    Center(
                      child: Text(
                        widget.language == NrcLanguage.english
                            ? data.name.en
                            : data.name.mm,
                        style: TextStyle(
                            color: widget.pickerItemColor ?? Colors.black),
                      ),
                    )
                  ]
                ],
              ),
            ),
          ],
        ),
        Container(
          margin: const EdgeInsets.only(top: 8),
          child: TextFormField(
            onChanged: _onChanged,
            controller: _nrcTextEditingController,
            textDirection: TextDirection.rtl,
            maxLength: 6,
            keyboardType: TextInputType.number,
            textAlignVertical: TextAlignVertical.center,
            style: TextStyle(
                letterSpacing: 4.0,
                color: widget.pickerItemColor ?? Colors.black,
                fontSize: 16),
            decoration: InputDecoration(
              hintText: _numberTextFieldHint,
              hintTextDirection: TextDirection.ltr,
              hintStyle: const TextStyle(
                  letterSpacing: 1.0,
                  fontSize: 16,
                  color: Colors.grey,
                  fontWeight: FontWeight.w400),
              counterText: "",
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 0, horizontal: 8),
              disabledBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(width: 1, color: Colors.white)),
              focusedErrorBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(width: 1, color: Colors.red)),
              errorBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(width: 1, color: Colors.red)),
              focusedBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(width: 1, color: Colors.deepPurple)),
              enabledBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(width: 0.5, color: Colors.grey)),
            ),
          ),
        ),
        GestureDetector(
            onTap: _clearNrcValue,
            child: Container(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Text(
                  _nrcClearLabel,
                  style: const TextStyle(
                      fontSize: 16,
                      color: Colors.deepPurple,
                      fontWeight: FontWeight.w600),
                )))
      ],
    );
  }
}

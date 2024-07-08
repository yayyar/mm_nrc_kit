import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mm_nrc_kit/src/config/constants.dart';
import 'package:mm_nrc_kit/src/data/mm_nrc.dart';
import 'package:mm_nrc_kit/src/model/model.dart';
import 'package:mm_nrc_kit/src/views/number_keyboard/english_number_keyboard.dart';
import 'package:mm_nrc_kit/src/views/number_keyboard/myanmar_number_keyboard.dart';
import 'package:mm_nrc_kit/src/widgets/ui_text_field.dart';

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
  final List<TextEditingController> _numberEditingControllerList = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];

  bool _isShowKeyboard = false;

  int _currentController = 0;

  final FocusNode _focusNode = FocusNode();

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

  String _nrcClearLabel = "";

  late FixedExtentScrollController _townshipScrollController;

  void _updateNrc({isClear = false}) {
    _nrcValueString =
        !isClear ? "$_stateDivision/$_township($_type)$_nrcNumber" : null;
    widget.onSelected(_nrcValueString);
    widget.onSelectedIndex(
        [_defaultStateDivisionIndex, _defaultTownshipIndex, _defaultTypeIndex]);
    // if (isClear) {
    //   _townshipScrollController.jumpToItem(_defaultTownshipIndex);
    // }
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

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  Future<void> _checkNRC() async {
    if (_nrcValueString != null) {
      if (widget.language == NrcLanguage.english) {
        if (MmNrc.checkPrefixValid(enNrcString: _nrcValueString!)) {
          Nrc nrc = MmNrc.splitNrc(_nrcValueString!);
          _stateDivision = nrc.stateCode;
          _township = nrc.townshipCode;
          _type = nrc.nrcType;
          _nrcNumber = nrc.nrcNo;
          _bindNrcNumber(_nrcNumber);
          setState(() {
            _defaultStateDivisionIndex = widget.selectedStateDivisionIndex;
            _defaultTownshipIndex = widget.selectedTownshipIndex;
            _defaultTypeIndex = widget.selectedTypeIndex;
          });
        }
      } else {
        if (MmNrc.checkPrefixValidMm(mmNrcString: _nrcValueString!)) {
          Nrc nrc = MmNrc.splitNrc(_nrcValueString!);
          _stateDivision = nrc.stateCode;
          _township = nrc.townshipCode;
          _type = nrc.nrcType;
          _nrcNumber = nrc.nrcNo;
          _bindNrcNumber(_nrcNumber);
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
        _defaultTownshipIndex = 21;
        _defaultTypeIndex = 0;
      });

      _stateDivision = widget.language == NrcLanguage.english
          ? defaultStateCode
          : defaultStateCodeMm;
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
        "Picker: _defaultStateDivisionIndex => $_defaultStateDivisionIndex , _defaultTownshipIndex => $_defaultTownshipIndex, _defaultTypeIndex => $_defaultTypeIndex");

    await Future.delayed(const Duration(milliseconds: 500));
    _updateNrc();
  }

  _onChanged(value) {
    _nrcNumber = value;
    _updateNrc();
  }

  _clearNrcValue() {
    _updateNrc(isClear: true);
    for (var element in _numberEditingControllerList) {
      element.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
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
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (var index = 0;
                index < _numberEditingControllerList.length;
                index++) ...[
              Container(
                margin: const EdgeInsets.only(top: 8),
                width: 45,
                height: 45,
                child: GestureDetector(
                  onTap: _onNumberTextFieldFocus,
                  child: AbsorbPointer(
                      child: UITextField(
                    focusColor: (_isShowKeyboard && index == _currentController)
                        ? Colors.deepPurple
                        : null,
                    controller: _numberEditingControllerList[index],
                  )),
                ),
              ),
              if (index != _numberEditingControllerList.length - 1) ...[
                const SizedBox(
                  width: 5,
                ),
              ]
            ],
          ],
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: GestureDetector(
              onTap: _clearNrcValue,
              child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Text(
                    _nrcClearLabel,
                    style: const TextStyle(
                        fontSize: 16,
                        color: Colors.deepPurple,
                        fontWeight: FontWeight.w600),
                  ))),
        )
      ],
    );
  }

  void _handleKeyPress(String key) {
    debugPrint("_currentController => $_currentController");
    if (key == "﹀") {
      Navigator.of(context).pop();
      return;
    }
    if (key == '⌫') {
      if (_currentController != 0) {
        setState(() {
          _numberEditingControllerList[_currentController - 1].clear();
          _currentController -= 1;
        });
      }
    } else {
      if (_currentController == 6) {
        return;
      }
      setState(() {
        _currentController += 1;
        _numberEditingControllerList[_currentController - 1].text = key;
      });
    }
    _onChanged(_numberEditingControllerList.map((e) => e.text).join(''));
  }

  void _showMyanmarKeyboard(BuildContext context) {
    showModalBottomSheet(
      elevation: 0,
      barrierColor: Colors.transparent,
      isDismissible: true,
      context: context,
      constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width,
          maxHeight: MediaQuery.of(context).size.height),
      builder: (context) {
        // return const Placeholder();
        return MyanmarNumberKeyboard(onKeyPressed: _handleKeyPress);
      },
    ).whenComplete(() {
      setState(() {
        _isShowKeyboard = false;
      });
    });
  }

  void _showEnglishKeyboard(BuildContext context) {
    showModalBottomSheet(
      elevation: 0,
      barrierColor: Colors.transparent,
      isDismissible: true,
      context: context,
      constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width,
          maxHeight: MediaQuery.of(context).size.height),
      builder: (context) {
        return EnglishNumberKeyboard(onKeyPressed: _handleKeyPress);
      },
    ).whenComplete(() {
      setState(() {
        _isShowKeyboard = false;
      });
    });
  }

  void _onNumberTextFieldFocus() {
    FocusScope.of(context).requestFocus(_focusNode);
    setState(() {
      _isShowKeyboard = true;
    });
    if (widget.language == NrcLanguage.english) {
      _showEnglishKeyboard(context);
    } else {
      _showMyanmarKeyboard(context);
    }
  }

  void _bindNrcNumber(String nrcNumber) {
    final numberList = nrcNumber.split('');
    for (var index = 0; index < numberList.length; index++) {
      _numberEditingControllerList[index].text = numberList[index];
      _currentController += 1;
    }
  }
}

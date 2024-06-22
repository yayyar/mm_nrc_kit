import 'package:flutter/material.dart';
import 'package:mm_nrc_kit/src/config/colors.dart';
import 'package:mm_nrc_kit/src/config/constants.dart';
import 'package:mm_nrc_kit/src/data/mm_nrc.dart';
import 'package:mm_nrc_kit/src/model/model.dart';

import 'nrc_picker.dart';

class NrcPopupMenu extends StatefulWidget {
  const NrcPopupMenu(
      {super.key,
      required this.onSelected,
      this.nrcPrefixString,
      this.pickerColor,
      this.pickerItemColor});
  final Function(String) onSelected;
  final String? nrcPrefixString;
  final Color? pickerColor;
  final Color? pickerItemColor;

  @override
  State<NrcPopupMenu> createState() => _NrcPopupMenuButtonState();
}

class _NrcPopupMenuButtonState extends State<NrcPopupMenu> {
  String nrcPrefixString = defaultNrcPrefixLabel;

  final GlobalKey _menuKey = GlobalKey();

  int stateDivisionIndex = 0;
  int townshipIndex = 0;
  int typeIndex = 0;

  List<StateDivision?> _stateDevisionList = [];
  List<Township> _townshipList = [];
  List<Types> _typeList = [];

  void _getTypeList() {
    MmNrc.types().then((value) {
      _typeList = value;
    });
  }

  void _getStateList() {
    MmNrc.states().then((value) {
      _stateDevisionList = value;
      MmNrc.getNrcTownshipListByStateId(stateId: defaultStateId).then((value) {
        _townshipList = value;
      });
    });
  }

  Future<void> _getTownshipListByCode(String code) async {
    _townshipList = await MmNrc.getNrcTownshipListByStateCode(stateCode: code);
  }

  void checkSelectedIndex() async {
    if (MmNrc.checkPrefixValid(enNrcString: nrcPrefixString)) {
      Nrc nrc = MmNrc.splitNrc(nrcPrefixString);

      await _getTownshipListByCode(nrc.stateCode);

      stateDivisionIndex = _stateDevisionList
          .indexWhere((element) => element!.number.en == nrc.stateCode);

      townshipIndex = _townshipList.indexWhere((element) =>
          element.short.en.toLowerCase() == nrc.townshipCode.toLowerCase());

      typeIndex =
          _typeList.indexWhere((element) => element.name.en == nrc.nrcType);

      debugPrint("$stateDivisionIndex / $townshipIndex / $typeIndex");
    }
    final dynamic popupMenuButtonState = _menuKey.currentState;
    popupMenuButtonState?.showButtonMenu();
  }

  @override
  void initState() {
    if (widget.nrcPrefixString != null &&
        MmNrc.checkPrefixValid(enNrcString: widget.nrcPrefixString ?? "")) {
      nrcPrefixString = widget.nrcPrefixString!;
    }
    _getStateList();
    _getTypeList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    return GestureDetector(
      onTap: checkSelectedIndex,
      child: PopupMenuButton(
        enabled: false,
        key: _menuKey,
        color: widget.pickerColor ?? lightTintColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        surfaceTintColor: widget.pickerColor ?? lightTintColor,
        position: PopupMenuPosition.under,
        onOpened: () {
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.focusedChild?.unfocus();
          }
        },
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width,
        ),
        itemBuilder: (BuildContext context) {
          return <PopupMenuEntry>[
            PopupMenuItem(
              enabled: false,
              child: SizedBox(
                height: 200,
                child: NrcPicker(
                    pickerItemColor: widget.pickerItemColor,
                    pickerColor: widget.pickerColor,
                    stateDevisionList: _stateDevisionList,
                    townshipList: _townshipList,
                    typeList: _typeList,
                    nrcPrefixString: nrcPrefixString,
                    selectedTypeIndex: typeIndex,
                    selectedTownshipIndex: townshipIndex,
                    selectedStateDivisionIndex: stateDivisionIndex,
                    onSelected: (value) {
                      setState(() {
                        nrcPrefixString = value;
                      });
                      widget.onSelected(value);
                    },
                    onSelectedIndex: (value) {
                      stateDivisionIndex = value[0];
                      townshipIndex = value[1];
                      typeIndex = value[2];
                    }),
              ),
            ),
          ];
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
              color: widget.pickerColor ?? lightTintColor,
              borderRadius: const BorderRadius.all(Radius.circular(8))),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                nrcPrefixString,
                textAlign: TextAlign.center,
                style: TextStyle(
                    letterSpacing: 2,
                    fontSize: 18,
                    color: widget.pickerItemColor ?? Colors.black),
              ),
              const SizedBox(
                width: 8,
              ),
              const Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.expand_less_rounded,
                    size: 18,
                  ),
                  Icon(
                    Icons.expand_more_rounded,
                    size: 18,
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

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

  Future<void> _getTownshipListByCode(String code) async {
    _townshipList = await MmNrc.getNrcTownshipListByStateCode(stateCode: code);
  }

  void checkSelectedIndex() async {
    if (_nrcValueString != null) {
      if (MmNrc.checkPrefixValid(enNrcString: _nrcValueString!)) {
        Nrc nrc = MmNrc.splitNrc(_nrcValueString!);

        await _getTownshipListByCode(nrc.stateCode);

        _stateDivisionIndex = _stateDevisionList
            .indexWhere((element) => element!.number.en == nrc.stateCode);

        _townshipIndex = _townshipList.indexWhere((element) =>
            element.short.en.toLowerCase() == nrc.townshipCode.toLowerCase());

        _typeIndex =
            _typeList.indexWhere((element) => element.name.en == nrc.nrcType);

        debugPrint("$_stateDivisionIndex / $_townshipIndex / $_typeIndex");
      }
    }
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
            nrcValueString: _nrcValueString ?? defaultNrcValueLabel,
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

    // return GestureDetector(
    //   onTap: checkSelectedIndex,
    //   child: PopupMenuButton(
    //     enabled: false,
    //     key: _menuKey,
    //     color: widget.pickerColor ?? lightTintColor,
    //     shape: RoundedRectangleBorder(
    //       borderRadius: BorderRadius.circular(10),
    //     ),
    //     surfaceTintColor: widget.pickerColor ?? lightTintColor,
    //     position: PopupMenuPosition.under,
    //     onOpened: () {
    //       if (!currentFocus.hasPrimaryFocus) {
    //         currentFocus.focusedChild?.unfocus();
    //       }
    //     },
    //     constraints: BoxConstraints(
    //       maxWidth: MediaQuery.of(context).size.width,
    //     ),
    //     itemBuilder: (BuildContext context) {
    //       return <PopupMenuEntry>[
    //         PopupMenuItem(
    //           enabled: false,
    //           child: SizedBox(
    //             height: 200,
    //             child: NrcPicker(
    //                 pickerItemColor: widget.pickerItemColor,
    //                 pickerColor: widget.pickerColor,
    //                 stateDevisionList: _stateDevisionList,
    //                 townshipList: _townshipList,
    //                 typeList: _typeList,
    //                 nrcValueString: nrcValueString,
    //                 selectedTypeIndex: typeIndex,
    //                 selectedTownshipIndex: townshipIndex,
    //                 selectedStateDivisionIndex: stateDivisionIndex,
    //                 onSelected: (value) {
    //                   setState(() {
    //                     nrcValueString = value;
    //                   });
    //                   widget.onSelected(value);
    //                 },
    //                 onSelectedIndex: (value) {
    //                   stateDivisionIndex = value[0];
    //                   townshipIndex = value[1];
    //                   typeIndex = value[2];
    //                 }),
    //           ),
    //         ),
    //       ];
    //     },
    //     child: Text(
    //       nrcValueString,
    //       textAlign: TextAlign.center,
    //       style: const TextStyle(
    //           letterSpacing: 2,
    //           fontSize: 18,
    //           fontWeight: FontWeight.w600,
    //           color: Colors.deepPurple),
    //     ),
    //   ),
    // );
  }
}

// Row(
//   mainAxisSize: MainAxisSize.min,
//   mainAxisAlignment: MainAxisAlignment.spaceAround,
//   children: [
//     Text(
//       nrcValueString,
//       textAlign: TextAlign.center,
//       style: TextStyle(
//           letterSpacing: 2,
//           fontSize: 18,
//           color: widget.pickerItemColor ?? Colors.black),
//     ),
//     const SizedBox(
//       width: 8,
//     ),
//     const Column(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         Icon(
//           Icons.expand_less_rounded,
//           size: 18,
//         ),
//         Icon(
//           Icons.expand_more_rounded,
//           size: 18,
//         )
//       ],
//     )
//   ],
// ),

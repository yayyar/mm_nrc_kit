import 'package:flutter/material.dart';
import 'package:mm_nrc_kit/src/config/colors.dart';
import 'package:mm_nrc_kit/src/config/constants.dart';
import 'package:mm_nrc_kit/src/data/mm_nrc.dart';
import 'package:mm_nrc_kit/src/views/nrc_expansion_tile.dart';

class NRCField extends StatefulWidget {
  /// Creates a Myanmar NRC Field.
  ///
  /// Used for the Myanmar NRC Picker.
  const NRCField(
      {super.key,
      required this.onCompleted,
      required this.onChanged,
      this.language = NrcLanguage.myanmar,
      this.nrcValue,
      this.backgroundColor,
      this.borderColor,
      this.borderRadius,
      this.contentPadding,
      this.pickerItemColor,
      this.borderWidth,
      this.leadingTitleColor,
      this.leadingTitleFontSize,
      this.trailingTitleFontSize});
  final Function(String?) onCompleted;
  final Function(String?) onChanged;
  final String? nrcValue;
  final Color? backgroundColor;
  final Color? borderColor;
  final double? borderRadius;
  final EdgeInsetsGeometry? contentPadding;
  final Color? pickerItemColor;
  final Color? leadingTitleColor;
  final double? borderWidth;
  final NrcLanguage language;
  final double? leadingTitleFontSize;
  final double? trailingTitleFontSize;

  @override
  State<NRCField> createState() => _MMNRCTextFieldState();
}

class _MMNRCTextFieldState extends State<NRCField> {
  String? _nrcValueString;
  String? nrcNumber = "";

  void _onChanged(value) {
    _nrcValueString = value;

    // on changed
    widget.onChanged(_nrcValueString);

    if (value != null) {
      nrcNumber = _nrcValueString!.split(")")[1];
    } else {
      nrcNumber = null;
    }
    // debugPrint("nrcNumber => $nrcNumber");
    // debugPrint("nrcNumberLength => ${nrcNumber?.length}");
    if (nrcNumber?.length == 6 || nrcNumber == null) {
      // on completed
      widget.onCompleted(_nrcValueString);
    }
  }

  @override
  void initState() {
    if (widget.nrcValue != null) {
      if (widget.language == NrcLanguage.english) {
        if (MmNrc.checkValid(enNrcString: widget.nrcValue!)) {
          _nrcValueString = widget.nrcValue!;
        }
      } else {
        if (MmNrc.checkValidMm(mmNrcString: widget.nrcValue!)) {
          _nrcValueString = widget.nrcValue!;
        }
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: widget.contentPadding ??
            const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: widget.backgroundColor ?? Colors.white,
            border: Border.all(
                color: widget.borderColor ?? borderColor,
                width: widget.borderWidth ?? 0.4),
            borderRadius:
                BorderRadius.all(Radius.circular(widget.borderRadius ?? 10))),
        child: NrcExpansionTile(
          leadingTitleFontSize: widget.leadingTitleFontSize,
          trailingTitleFontSize: widget.trailingTitleFontSize,
          backgroundColor: widget.backgroundColor,
          leadingTitleColor: widget.leadingTitleColor,
          language: widget.language,
          pickerItemColor: widget.pickerItemColor,
          nrcValueString: _nrcValueString,
          onChanged: _onChanged,
        ));
  }
}

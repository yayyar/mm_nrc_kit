import 'package:flutter/material.dart';
import 'package:mm_nrc_kit/src/config/colors.dart';
import 'package:mm_nrc_kit/src/config/constants.dart';
import 'package:mm_nrc_kit/src/data/mm_nrc.dart';
import 'package:mm_nrc_kit/src/model/model.dart';
import 'package:mm_nrc_kit/src/views/nrc_popup_menu.dart';

class NRCField extends StatefulWidget {
  /// Creates a Myanmar NRC Field.
  ///
  /// If [isExpand] is true, it must be full width.
  ///
  /// Typically used for the Myanmar NRC Picker.
  const NRCField(
      {super.key,
      required this.onCompleted,
      required this.onChanged,
      this.nrcValue,
      this.height,
      this.isExpand = false,
      this.backgroundColor,
      this.borderColor,
      this.borderRadius,
      this.contentPadding,
      this.pickerColor,
      this.pickerItemColor,
      this.borderWidth});
  final Function(String?) onCompleted;
  final Function(String?) onChanged;
  final String? nrcValue;
  final double? height;
  final bool isExpand;
  final Color? backgroundColor;
  final Color? borderColor;
  final double? borderRadius;
  final EdgeInsetsGeometry? contentPadding;
  final Color? pickerColor;
  final Color? pickerItemColor;
  final double? borderWidth;

  @override
  State<NRCField> createState() => _MMNRCTextFieldState();
}

class _MMNRCTextFieldState extends State<NRCField> {
  final TextEditingController nrcTextEditingController =
      TextEditingController();
  String nrcPrefixString = "";

  void _onCompleted() {
    if (MmNrc.checkPrefixValid(enNrcString: nrcPrefixString) &&
        nrcTextEditingController.text.length == 6) {
      widget.onCompleted("$nrcPrefixString${nrcTextEditingController.text}");
    }
  }

  void _onChnanged() {
    widget.onChanged("$nrcPrefixString${nrcTextEditingController.text}");
    _onCompleted();
  }

  @override
  void initState() {
    if (widget.nrcValue != null) {
      if (MmNrc.checkValid(enNrcString: widget.nrcValue!)) {
        Nrc nrc = MmNrc.splitNrc(widget.nrcValue!);
        nrcPrefixString =
            "${nrc.stateCode}/${nrc.townshipCode}(" "${nrc.nrcType})";
        nrcTextEditingController.text = nrc.nrcNo;
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          widget.contentPadding ?? const EdgeInsets.symmetric(horizontal: 8),
      height: widget.height ?? 50,
      width: widget.isExpand ? MediaQuery.of(context).size.width : null,
      decoration: BoxDecoration(
          color: widget.backgroundColor ?? Colors.white,
          border: Border.all(
              color: widget.borderColor ?? borderColor,
              width: widget.borderWidth ?? 0.4),
          borderRadius:
              BorderRadius.all(Radius.circular(widget.borderRadius ?? 10))),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          NrcPopupMenu(
              pickerItemColor: widget.pickerItemColor,
              pickerColor: widget.pickerColor,
              nrcPrefixString: nrcPrefixString,
              onSelected: (value) {
                nrcPrefixString = value;
                _onChnanged();
              }),
          const SizedBox(
            width: 10,
          ),
          SizedBox(
            width: 80,
            child: TextFormField(
              onChanged: (value) {
                _onChnanged();
              },
              controller: nrcTextEditingController,
              maxLength: 6,
              keyboardType: TextInputType.number,
              textAlignVertical: TextAlignVertical.center,
              style: TextStyle(
                  color: widget.pickerItemColor ?? Colors.black, fontSize: 20),
              validator: (value) {
                if (value?.length != 6 && nrcPrefixString.isEmpty) {
                  return errorText;
                } else {
                  return null;
                }
              },
              decoration: const InputDecoration(
                  hintText: defaultNrcNumberHint,
                  hintStyle: TextStyle(color: Colors.grey, letterSpacing: 3),
                  counterText: "",
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(bottom: 10)),
            ),
          )
        ],
      ),
    );
  }
}

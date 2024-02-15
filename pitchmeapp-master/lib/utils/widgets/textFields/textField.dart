import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pitch_me_app/utils/colors/colors.dart';

class CustomTextField extends StatefulWidget {
  CustomTextField(
      {Key? key,
      required this.controller,
      this.lableText,
      this.limit,
      this.border,
      this.fontSize,
      this.textAlign = TextAlign.start,
      this.hintText,
      this.required = false,
      this.obscure = false,
      this.onChange,
      this.inputAction = TextInputAction.done,
      this.keyboardType = TextInputType.text,
      // required this.validator,
      this.enabled = true,
      this.focusNode,
      this.maxLines = 1,
      this.validator,
      this.onFieldSubmit,
      this.inputFormatters = const [],
      this.nextFocusNode,
      required this.context})
      : super(key: key);

  final TextEditingController controller;
  final String? lableText;
  final String? hintText;
  final InputBorder? border;
  final List<TextInputFormatter>? inputFormatters;
  final TextAlign textAlign;
  final int? limit;
  double? fontSize = 14;
  final int maxLines;
  final bool enabled;
  final bool obscure;
  final TextInputType keyboardType;
  final bool required;
  final FormFieldValidator<String>? validator;
  final TextInputAction inputAction;
  final Function(String)? onChange;
  final Function()? onFieldSubmit;
  final BuildContext context;

  // final ValidatorCallback validator;
  final FocusNode? focusNode, nextFocusNode;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool hide;
  bool focus = false;

  @override
  void initState() {
    hide = widget.obscure;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // FocusNode fn = widget.focusNode ?? FocusNode();
    return FocusScope(
      onFocusChange: (a) {
        focus = !focus;
        setState(() {});
        print("Focus on done is ${a} and $focus");
      },
      child: Container(
        height: 55,
        padding: EdgeInsets.zero,
        child: Card(
          elevation: 4,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: TextFormField(
            onChanged: widget.onChange,
            enabled: widget.enabled,
            style: GoogleFonts.inter(
                textStyle: TextStyle(
              fontSize: widget.fontSize,
              color: DynamicColor.gredient1,
              fontWeight: FontWeight.normal,
            )),
            textInputAction: widget.inputAction,
            textAlign: widget.textAlign,
            obscureText: hide,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: widget.validator,
            focusNode:
                widget.focusNode == null ? FocusNode() : widget.focusNode,
            // maxLength: limit,
            // validator: validator,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(top: 2, left: 10, bottom: 0),
              fillColor: DynamicColor.white,
              filled: true,
              suffixIcon: widget.obscure
                  ? IconButton(
                      onPressed: () {
                        setState(() {
                          hide = !hide;
                        });
                      },
                      icon: Icon(
                        hide ? Icons.visibility_off : Icons.visibility,
                        color: DynamicColor.lightGrey,
                      ))
                  : null,
              counterText: '',
              prefixText: widget.hintText,
              focusColor: Colors.white,
              floatingLabelBehavior: FloatingLabelBehavior.never,
              // labelText: hintText,
              labelStyle: GoogleFonts.inter(
                  textStyle: TextStyle(
                fontSize: widget.fontSize,
                color: DynamicColor.lightGrey,
                fontWeight: FontWeight.normal,
              )),
              hintText: widget.lableText,
              hintStyle: GoogleFonts.inter(
                  textStyle: TextStyle(
                fontSize: widget.fontSize,
                color: DynamicColor.lightGrey,
                fontWeight: FontWeight.normal,
              )),

              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                borderSide: const BorderSide(color: DynamicColor.gredient2),
              ),
              focusedBorder: widget.border ??
                  OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: const BorderSide(color: DynamicColor.gredient2),
                  ),
              border: widget.border ??
                  OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: const BorderSide(color: DynamicColor.gredient2),
                  ),
            ),
            cursorColor: DynamicColor.gredient2,
            controller: widget.controller,
            maxLines: widget.maxLines,
            minLines: 1,
            readOnly: !widget.enabled,
            maxLength: widget.limit,
            keyboardType: widget.keyboardType,
            inputFormatters: widget.inputFormatters,
            // decoration: kInputDecorationAddForms.copyWith(
            //   labelText: hintText,
            //   counterText: "",
            // ),
            onFieldSubmitted: (value) {
              print("Field submitted");
              FocusScope.of(widget.context).requestFocus(widget.nextFocusNode);
              if (widget.inputAction == TextInputAction.done) {
                FocusScope.of(widget.context).unfocus();
              }
              widget.onFieldSubmit!();
              // widget.nextFocusNode != null
              //     ? widget.nextFocusNode!.requestFocus()
              //     : value;
            },
            // style: kTextStyleN600.copyWith(fontSize: 20, color: lightColorScheme.onSurface),
          ),
        ),
      ),
    );
  }
}

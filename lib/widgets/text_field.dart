import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:postly/config/size_config.dart';
import '../extensions/num.dart';

class POSTLYTextFormField extends StatefulWidget {
  /*
   * This is an abstractions of flutter textfiled but with 
   * an added advantage with the default style from design
   * 
   * 
   */
  final TextEditingController textEditingController;
  final String title;
  final String labelText;
  final Function onChange;
  final Function callBackOnFocus;
  final Function callBackOffFocus;
  final Function onEditingComplete;
  final TextInputType textInputType;
  final IconData suffixIcon;
  final IconData preffixIcon;
  final Function validator;
  final Function prefixOnClick;
  final Function suffixOnClick;
  final bool obscureText;
  final int maxLength;
  final bool isBoarder;
  final TextInputAction inputAction;
  final bool enabled;
  final int maxLines;

  const POSTLYTextFormField({
    Key key,
    this.textEditingController,
    this.title,
    this.labelText,
    this.textInputType,
    this.onChange,
    this.validator,
    this.obscureText = false,
    this.callBackOnFocus,
    this.callBackOffFocus,
    this.maxLength,
    this.preffixIcon,
    this.maxLines = 1,
    this.suffixIcon,
    this.prefixOnClick,
    this.suffixOnClick,
    this.onEditingComplete,
    this.isBoarder = true,
    this.inputAction,
    this.enabled,
  }) : super(key: key);

  @override
  _POSTLYTextFormFieldState createState() => _POSTLYTextFormFieldState();
}

class _POSTLYTextFormFieldState extends State<POSTLYTextFormField> {
  final _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    _focusNode.addListener(
      () {
        if (widget.callBackOnFocus != null) {
          if (_focusNode.hasFocus) {
            widget.callBackOnFocus();
          } else {
            widget.callBackOffFocus();
          }
        }
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _focusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 1.5.h,
        ),
        widget.title != null ? Text(widget.title) : SizedBox.shrink(),
        SizedBox(
          height: 1.h,
        ),
        TextFormField(
          focusNode: _focusNode,
          obscureText: widget.obscureText,
          textInputAction: widget.inputAction,
          enabled: widget.enabled ?? true,
          decoration: new InputDecoration(
            hintText: widget.labelText,
            hintStyle: TextStyle(
              fontWeight: FontWeight.w300,
            ),
            fillColor: Colors.white,
            suffixIcon: widget.suffixIcon != null
                ? InkWell(
                    onTap: widget.suffixOnClick,
                    child: Container(
                      margin: EdgeInsets.all(1),
                      child: Icon(
                        widget.suffixIcon,
                        color:
                            Theme.of(context).iconTheme.color.withOpacity(0.4),
                      ),
                    ),
                  )
                : null,
            prefixIcon: widget.preffixIcon != null
                ? InkWell(
                    onTap: widget.prefixOnClick,
                    child: Container(
                      margin: EdgeInsets.all(1),
                      child: Icon(
                        widget.preffixIcon,
                        color: Theme.of(context).iconTheme.color,
                      ),
                    ),
                  )
                : null,
            prefixStyle: TextStyle(color: Colors.black),
            contentPadding: new EdgeInsets.symmetric(
              vertical: 15.0,
              horizontal: 10.0,
            ),
            border: widget.isBoarder
                ? new OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                      const Radius.circular(8.0),
                    ),
                  )
                : InputBorder.none,
            focusedBorder: widget.isBoarder
                ? OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey,
                    ),
                    borderRadius: const BorderRadius.all(
                      const Radius.circular(8.0),
                    ),
                  )
                : InputBorder.none,
            enabledBorder: widget.isBoarder
                ? OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey.withOpacity(0.5),
                    ),
                    borderRadius: const BorderRadius.all(
                      const Radius.circular(8.0),
                    ),
                  )
                : InputBorder.none,
          ),
          validator: (val) => widget.validator(val),
          onChanged: widget.onChange,
          controller: widget.textEditingController,
          keyboardType: widget.textInputType,
          maxLength: widget.maxLength,
          onEditingComplete: widget.onEditingComplete,
          maxLines: widget.maxLines,
        ),
      ],
    );
  }
}

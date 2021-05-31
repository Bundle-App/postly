import 'package:Postly/configs/app_color.dart';
import 'package:flutter/material.dart';

class InputTextWidget extends FormField<String> {
  InputTextWidget({
    String initialValue,
    final Key key,
    final String hintText,
    final TextInputType keyboardType,
    final TextInputAction keyboardAction,
    final TextEditingController controller,
    final double height,
    final FormFieldValidator<String> validator,
    final ValueChanged<String> onChange,
    final Function onEditingComplete,
    final FocusNode focusNode,
    final bool obscureText = false,
    final Widget trailing,
    final Color color = Colors.white,
    final FormFieldSetter<String> onSaved,
    final bool isBorder = true,
    final bool disabled = false,
  }) : super(
            initialValue: initialValue ?? "",
            validator: validator,
            onSaved: onSaved,
            autovalidate: false,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            builder: (state) {
              return _InputTextState(
                initialValue: initialValue,
                state: state,
                inputController: controller,
                keyboardAction: keyboardAction,
                hintText: hintText,
                keyboardType: keyboardType,
                focusNode: focusNode,
                height: height,
                obscureText: obscureText,
                onChange: onChange,
                onEditingComplete: onEditingComplete,
                key: key,
                trailing: trailing,
                isBorder: isBorder,
                disabled: disabled,
              );
            });
}

class _InputTextState extends StatelessWidget {
  final String hintText;
  final String initialValue;
  final FormFieldState<String> state;
  final TextInputType keyboardType;
  final TextInputAction keyboardAction;
  final TextEditingController inputController;
  final double height;
  final FormFieldValidator<String> validator;
  final ValueChanged<String> onChange;
  final Function onEditingComplete;
  final FocusNode focusNode;
  final bool obscureText;
  final FormFieldSetter<String> onSaved;
  final Widget trailing;
  final Color color;
  final bool isBorder;
  final bool disabled;

  _InputTextState({
    Key key,
    @required this.hintText,
    @required this.keyboardType,
    @required this.keyboardAction,
    this.inputController,
    this.validator,
    this.initialValue,
    this.onChange,
    this.onSaved,
    this.focusNode,
    this.onEditingComplete,
    this.trailing,
    this.obscureText = false,
    this.height = 50,
    this.state,
    this.color,
    this.isBorder,
    this.disabled,
  }) : super();
  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: disabled,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: height,
            width: double.maxFinite,
            decoration: BoxDecoration(
              color: disabled ? Colors.grey.withOpacity(0.1) : this.color,
              border: Border.all(
                color: getBorderColor(),
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(8),
              ),
            ),
            child: TextFormField(
              initialValue: initialValue,
              // Notify the FormField State of Changes
              onChanged: (String value) {
               // if (this.onChange != null) {
                  state.didChange(value);
                  onChange(value);
              //  }
              },
              onEditingComplete: onEditingComplete,
              // controller: inputController,
              focusNode: focusNode,
              obscureText: obscureText,
              style: TextStyle(fontSize: 14),
              keyboardType: keyboardType,
              textInputAction: keyboardAction,
              decoration:
                  InputDecoration.collapsed(hintText: hintText).copyWith(
                hasFloatingPlaceholder: false,
                suffixIcon: trailing,
                contentPadding: EdgeInsets.symmetric(
                  vertical: 15,
                  horizontal: 10,
                ),
              ),
            ),
          ),
          // Show Form Field Error
          _showError(state),
        ],
      ),
    );
  }

  Color getBorderColor() {
    if (disabled) {
      return Colors.grey.withOpacity(0.4);
    } else {
      return isBorder ? AppColors.inputBorderColor : Colors.transparent;
    }
  }

  Widget _showError(FormFieldState formFieldState) {
    if (formFieldState.hasError)
      return Padding(
        padding: EdgeInsets.only(left: 8.0, top: 5),
        child: Text(
          formFieldState.errorText,
          style: TextStyle(
            color: AppColors.errorColor,
            fontWeight: FontWeight.w500,
            fontSize: 10,
          ),
        ),
      );
    return SizedBox();
  }
}

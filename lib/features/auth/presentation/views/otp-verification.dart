// ignore: file_names
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie/core/utils/styles/font-style.dart';

class OtpPage extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _OtpPageState createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  final List<TextEditingController> _controllers =
      List.generate(6, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());
  bool _wasBackspace = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(_focusNodes[0]);
    });

    for (var i = 0; i < 6; i++) {
      _controllers[i].addListener(() => _onOtpChange(i));
    }
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  void _onOtpChange(int index) {
    String currentText = _controllers[index].text;

    if (currentText.length > 1) {
      _controllers[index].text = currentText[1];
      _controllers[index].selection = TextSelection.fromPosition(
          TextPosition(offset: _controllers[index].text.length));
    }

    if (currentText.isNotEmpty) {
      _wasBackspace = false;
    }
  }

  // ignore: deprecated_member_use
  void _onKeyEvent(int index, RawKeyEvent event) {
    // ignore: deprecated_member_use
    if (event is RawKeyDownEvent) {
      if (event.logicalKey == LogicalKeyboardKey.backspace) {
        _wasBackspace = true;
        if (_controllers[index].text.isEmpty && index > 0) {
          FocusScope.of(context).requestFocus(_focusNodes[index - 1]);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'OTP Verification',
          style: AppTextStyle.textK14FontRegular,
        ),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 40.h),
        child: Column(
          children: [
            Text(
              'Enter 6 digit verification code sent to your phone number',
              style: AppTextStyle.textK22FontMedium.copyWith(fontSize: 20.sp),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 30.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(6, (index) {
                return _buildOtpField(index);
              }),
            ),
            SizedBox(
              height: 30.h,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOtpField(int index) {
    return SizedBox(
      width: 50.w,
      height: 50.h,
      // ignore: deprecated_member_use
      child: RawKeyboardListener(
        focusNode: FocusNode(),
        onKey: (event) => _onKeyEvent(index, event),
        child: TextField(
          controller: _controllers[index],
          focusNode: _focusNodes[index],
          keyboardType: TextInputType.number,
          textAlign: TextAlign.center,
          maxLength: 1,
          style: AppTextStyle.textK16WhiteHint,
          decoration: InputDecoration(
            counterText: '',
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(color: Colors.grey, width: 2.0.w),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(color: Colors.white, width: 2.0.w),
            ),
          ),
          onChanged: (value) {
            if (_wasBackspace) {
              if (value.isEmpty) {
                // Move focus back if field is empty after backspace
                if (index > 0) {
                  FocusScope.of(context).requestFocus(_focusNodes[index - 1]);
                }
              } else {
                // Stay in the same field if it still has text
                _controllers[index].text = value;
                _controllers[index].selection = TextSelection.fromPosition(
                    TextPosition(offset: _controllers[index].text.length));
              }
              _wasBackspace = false;
            } else {
              if (value.isNotEmpty && index < 5) {
                FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
              }
            }
          },
          onSubmitted: (value) {
            if (value.isEmpty && index > 0) {
              FocusScope.of(context).requestFocus(_focusNodes[index - 1]);
            }
          },
        ),
      ),
    );
  }
}

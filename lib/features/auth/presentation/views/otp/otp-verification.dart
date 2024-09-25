import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:movie/core/utils/colors/colors.dart';
import 'package:movie/core/utils/routing/routes.dart';
import 'package:movie/core/utils/styles/font-style.dart';
import 'package:movie/core/utils/widgets/button.dart';
import 'package:movie/features/auth/presentation/view-model/otp/otp-cubit.dart';
import 'package:movie/features/auth/presentation/view-model/otp/otp-states.dart';

class OtpPage extends StatefulWidget {
  @override
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
      _controllers[index].text = currentText[0];
      _controllers[index].selection = TextSelection.fromPosition(
          TextPosition(offset: _controllers[index].text.length));
    }

    if (currentText.isNotEmpty) {
      _wasBackspace = false;
    }
  }

  void _onKeyEvent(int index, RawKeyEvent event) {
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
    return BlocConsumer<OtpCubit, OtpStates>(
      listener: (context, state) {
        if (state is OtpLoginSuccessState) {
          Navigator.pushNamed(context,Routes.successfullyRegisteredPath);
        } else if (state is OtpOtpLoginFailedState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      builder: (context, state) => Scaffold(
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
              TextButton(
                  onPressed: () {},
                  child: Text(
                    'Resend Code',
                    style: GoogleFonts.poppins(
                        color: AppColors.buttonKColor,
                        fontSize: 13.sp,
                        fontWeight: FontWeight.normal),
                  )),
              const Spacer(),
              Align(
                alignment: AlignmentDirectional.bottomCenter,
                child: CustomButton(
                    buttonCircular: 16.r,
                    buttonColor: HexColor('EB2F3D'),
                    buttonHeight: 53.h,
                    buttonWeidth: double.infinity,
                    label: 'Submit',
                    labelColor: Colors.white,
                    ontap: () {
                      String otpCode = _controllers
                          .map((controller) => controller.text)
                          .join();
                      OtpCubit.get(context).loginWithOtp(otp: otpCode);
                    }),
              ),
            ],
          ),
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
                if (index > 0) {
                  FocusScope.of(context).requestFocus(_focusNodes[index - 1]);
                }
              } else {
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

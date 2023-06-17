import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:izam_task/consts/colors.dart';
import 'package:izam_task/consts/sizes.dart';
import 'package:izam_task/consts/strings.dart';
import 'package:izam_task/pages/presentation/controllers/login_controller.dart';
import 'package:izam_task/resources/assets_generated.dart';
import 'package:izam_task/widgets/custom_button.dart';
import 'package:izam_task/widgets/custom_button_container.dart';
import 'package:izam_task/widgets/custom_text.dart';
import 'package:izam_task/widgets/custom_text_form_field.dart';
import 'package:izam_task/widgets/text_styles.dart';

import '../../../../widgets/custom_text_field_container.dart';

class LoginView extends GetView<LoginController> {
  final GlobalKey<FormState> formKey = GlobalKey();

  LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF0F0F7),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: Sizes.s100,
                ),
                const Center(child: Image(image: AppAssets.daftraLogo)),
                SizedBox(
                  height: Sizes.s100,
                ),
                Center(
                  child: Container(
                    constraints:
                        const BoxConstraints(maxWidth:  Sizes.s374, maxHeight: Sizes.s400),
                    padding: const EdgeInsets.all(Sizes.s20),
                    decoration: BoxDecoration(
                      color: const Color(ColorCode.white),
                      borderRadius: BorderRadius.circular(Sizes.s20),
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromRGBO(0, 0, 0, 0.1),
                          offset: Offset(0, 10),
                          blurRadius: 7.5,
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          ConstantsStrings.welcomeLogin,
                          textAlign: TextAlign.start,
                          textStyle: TextStyles.textXLarge.copyWith(
                              fontSize: 28,
                              fontWeight: FontWeight.normal,
                              color: const Color(ColorCode.semiBlack)),
                        ),
                        const SizedBox(
                          height: Sizes.s20,
                        ),
                        CustomTextFieldContainer(
                          CustomTextFormField(
                            hint: ConstantsStrings.emailAddress,
                            inputType: TextInputType.emailAddress,
                            onSave: (value) {
                              controller.email = value!;
                            },
                            validator: (value) {
                              return value == null ||
                                      controller.validateEmail(value.trim())
                                  ? null
                                  : ConstantsStrings.invalidMail;
                            },
                          ),
                        ),
                        const SizedBox(height: Sizes.s20),
                        ObxValue<RxBool>((state) {
                          return CustomTextFormField(
                            hint: ConstantsStrings.password,
                            obscureText: true,
                            inputType: TextInputType.visiblePassword,
                            obscuringCharacter: "•",
                            onSave: (value) {
                              controller.password = value!;
                            },
                            validator: (value) {
                              return value == null ||
                                      controller.validatePassword(value)
                                  ? null
                                  : ConstantsStrings.invalidPassword;
                            },
                            isHiddenPassword: state.value,
                            onTapShowHidePassword: () =>
                                controller.changeIsHiddenPassword(),
                          );
                        }, controller.isHiddenPassword),
                        const SizedBox(height: Sizes.s20),
                        Align(
                          alignment: Alignment.centerRight,
                          child: InkWell(
                            onTap: (){},
                            child: CustomText(
                              ConstantsStrings.forgotPassword,
                              textStyle: TextStyles.textSmall.copyWith(
                                  color: const Color(ColorCode.semiBlack)),
                            ),
                          ),
                        ),
                        const SizedBox(height: Sizes.s20),
                        controller.obx((state) {
                          return CustomButtonContainer(
                            CustomButton(
                              Center(
                                child: CustomText(ConstantsStrings.login,
                                    textStyle: TextStyles.textMedium.copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 20.sp)),
                              ),
                              () {
                                if ((formKey.currentState?.validate() ??
                                    false)) {
                                  formKey.currentState?.save();
                                  controller.onLoginClicked();
                                }
                              },
                            ),
                            width: 334.w,
                            height: 50.h,
                          );
                        },
                            onLoading: const SpinKitCircle(
                                color: Color(ColorCode.primary))),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

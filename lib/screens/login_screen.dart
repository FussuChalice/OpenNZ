import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:opennz_ua/colors.dart';
import 'package:opennz_ua/network.dart';
import 'package:opennz_ua/screens.dart';
import 'package:opennz_ua/version.dart';
import 'package:opennz_ua/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final userLoginController = TextEditingController();
  final userPasswordController = TextEditingController();

  bool passwordIsHidden = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: ApplicationColors.backgroundGradient,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 54,
                right: 54,
              ),
              child: MediaQuery.of(context).viewInsets.bottom == 0
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Gap(112),
                        Text(
                          '${AppLocalizations.of(context)!.versionB} OpenNZ: $APPLICATION_VERSION',
                          style: TextStyle(
                            color: ApplicationColors.versionGrey,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            height: 8,
                          ),
                        ),
                        Text(
                          AppLocalizations.of(context)!.logInGreeting,
                          style: TextStyle(
                            color: ApplicationColors.black,
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                            height: 1,
                          ),
                        ),
                        const Gap(20),
                        Text(
                          AppLocalizations.of(context)!
                              .logInGreetingDescription,
                          style: TextStyle(
                            color: ApplicationColors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            height: 1,
                          ),
                        ),
                      ],
                    )
                  : const SizedBox(),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              color: ApplicationColors.greyWhite,
              child: Padding(
                padding: const EdgeInsets.all(38),
                child: Column(
                  children: [
                    CustomTextfield(
                      labelText: AppLocalizations.of(context)!.textfieldLogin,
                      controller: userLoginController,
                      keyboardType: TextInputType.emailAddress,
                      suffixIcon: IconButton(
                        onPressed: () => {userLoginController.clear()},
                        icon: const Icon(
                          Icons.cancel,
                        ),
                      ),
                      obscureText: false,
                      enableSuggestions: true,
                      autocorrect: false,
                    ),
                    const Gap(20),
                    CustomTextfield(
                      labelText:
                          AppLocalizations.of(context)!.textfieldPassword,
                      controller: userPasswordController,
                      keyboardType: TextInputType.emailAddress,
                      suffixIcon: IconButton(
                        onPressed: () => {
                          setState(() {
                            passwordIsHidden = !passwordIsHidden;
                          })
                        },
                        icon: Icon(
                          passwordIsHidden
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                      ),
                      obscureText: passwordIsHidden,
                      enableSuggestions: false,
                      autocorrect: false,
                    ),
                    const Gap(34),
                    CustomFilledButton(
                      label: AppLocalizations.of(context)!.logInButton,
                      width: MediaQuery.of(context).size.width,
                      onPressed: () async {
                        if (userLoginController.text.isEmpty ||
                            userPasswordController.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(AppLocalizations.of(context)!
                                  .errorTextfieldsIsEmpty),
                            ),
                          );
                        } else {
                          AuthByPasswordCredentialModel credentials =
                              AuthByPasswordCredentialModel(
                            password: userPasswordController.text,
                            username: userLoginController.text,
                          );

                          final data = await AuthService()
                              .authByLoginAndPassword(credentials);

                          data.fold(
                            (user) async {
                              var box = await Hive.openBox("auth_data");
                              box.put(
                                  "credentials",
                                  authByPasswordCredentialModelToJson(
                                      credentials));

                              if (context.mounted) {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const HomeScreen(),
                                  ),
                                );
                              }
                            },
                            (error) => {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(error.errorMessage ==
                                          "Введено невірний логін або пароль."
                                      ? AppLocalizations.of(context)!
                                          .errorAuthUserNotFinded
                                      : AppLocalizations.of(context)!
                                          .errorOccurred),
                                ),
                              )
                            },
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

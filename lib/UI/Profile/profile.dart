import 'package:flutter/material.dart';
import 'package:gdsc_app/Controller/app_controller.dart';
import 'package:gdsc_app/UI/Authentication/Login/login_page.dart';
import 'package:gdsc_app/UI/Authentication/user_logic.dart';
import 'package:gdsc_app/UI/Profile/Pages/Detail/personDetails.dart';
import 'package:gdsc_app/UI/Profile/Pages/FeedBack/UI/feedback.dart';
import 'package:gdsc_app/UI/Profile/Pages/Help/help.dart';
import 'package:gdsc_app/UI/Profile/Pages/Leads/UI/leads.dart';
import 'package:gdsc_app/Util/App_Constants.dart';
import 'package:gdsc_app/Util/dimensions.dart';
import 'package:get/get.dart';
import '../../Util/App_components.dart';

class Account extends StatefulWidget {
  const Account({Key? key}) : super(key: key);

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  final controller = Get.put(AppController());
  final password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
        backgroundColor:
            controller.isDark.value ? Colors.grey[900] : Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Stack(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Components.personalInformation(),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: Components.header_3(
                            Constants.APP_NAME,
                            controller.isDark.value
                                ? Colors.white
                                : Colors.black87),
                      ),
                      Components.showDividerLine(Dimensions.PADDING_SIZE_SMALL),
                      Components.cardButton(
                          Icons.verified_user_rounded,
                          Constants.details,
                          () => Get.to(() => const Persona())),
                      Components.showDividerLine(Dimensions.PADDING_SIZE_SMALL),
                      Components.cardButton(Icons.leaderboard, Constants.admins,
                          () => Components.confirmAdmin(password)),
                      Components.showDividerLine(Dimensions.PADDING_SIZE_SMALL),
                      Components.cardButton(
                          Icons.delivery_dining,
                          Constants.post,
                          () => Components.confirmAdminPost(password)),
                      Components.showDividerLine(Dimensions.PADDING_SIZE_SMALL),
                      Components.cardButton(
                          Icons.person,
                          Constants.leads,
                          () => Get.to(() => const Leads(),
                              duration: const Duration(milliseconds: 100))),
                      Components.showDividerLine(Dimensions.PADDING_SIZE_SMALL),
                      // Components.cardButton(Icons.info_outline_rounded,
                      //     "Send a Notification", () => null),
                      //Components.showDividerLine(Dimensions.PADDING_SIZE_SMALL),
                      Components.cardButton(
                          Icons.help_outline_sharp,
                          Constants.help,
                          () => Get.to(() => Contact(),
                              duration: const Duration(milliseconds: 1))),
                      Components.showDividerLine(Dimensions.PADDING_SIZE_SMALL),
                      Components.cardButton(Icons.feedback, "Feedback",
                          () => Components.sendFeedback(description)),
                      Components.showDividerLine(Dimensions.PADDING_SIZE_SMALL),
                      Components.showLogOutButton(Constants.logout, () async {
                        await Authentication.signOut();
                        Get.offAll(() => const Login());
                      }, context)
                    ],
                  ),
                ),
                Positioned(
                    top: 0,
                    right: 3,
                    child: Row(
                      children: [
                        Obx(() {
                          return Icon(
                            controller.isDark.value
                                ? Icons.brightness_3
                                : Icons.wb_sunny_rounded,
                            color: controller.isDark.value
                                ? Colors.white
                                : Colors.black87,
                            size: 20,
                          );
                        }),
                        Components.spacerWidth(
                            Dimensions.CONTAINER_SIZE_EXTRA_SMALL),
                        Switch(
                            trackColor: MaterialStateProperty.all(
                                controller.isDark.value
                                    ? Colors.white
                                    : Colors.black54),
                            thumbColor:
                                MaterialStateProperty.all(Colors.deepOrange),
                            value: controller.isDark.value,
                            onChanged: ((value) {
                              controller.isDark.value = value;
                              setState(() {});
                              controller.saveThemeStatus();
                            }))
                      ],
                    ))
              ],
            ),
          ),
        )));
  }
}

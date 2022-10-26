import 'package:expectations/api/api_requests.dart';
import 'package:expectations/controllers/app_controller.dart';
import 'package:expectations/controllers/home_controller.dart';
import 'package:expectations/controllers/live_controller.dart';
import 'package:expectations/model/live/all_live.dart';
import 'package:expectations/routes/routes.dart';
import 'package:expectations/shared/components/components.dart';
import 'package:expectations/shared/components/constants.dart';
import 'package:expectations/shared/style/colors.dart';
import 'package:expectations/ui/live/live_screen.dart';
import 'package:expectations/utils/app_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hex_color/flutter_hex_color.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class AllLiveScreen extends StatefulWidget {
  const AllLiveScreen({Key? key}) : super(key: key);

  @override
  State<AllLiveScreen> createState() => _AllLiveScreenState();
}

class _AllLiveScreenState extends State<AllLiveScreen> {

  AppController appController = Get.put(AppController());
  HomeController homeController = Get.put(HomeController());
  LiveController _liveController = Get.put(LiveController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          MainToolBar(title: 'all_live', isBack: true, route: Routes.home),
          Expanded(
            child: FutureBuilder(
              future: appController.fetchAllLive(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done)
                  return ListView.builder(
                      itemCount: appController.listLive.length,
                      itemBuilder: (context, index) => buildLiveItem(appController.listLive[index]));
                else if (snapshot.connectionState == ConnectionState.waiting)
                  return Center(child: CircularProgressIndicator());
                else
                  return Container();
              },
            ),
          )
        ],
      ),
    );
  }

  Widget buildLiveItem(LiveData live) => Card(
    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16)),
    child: InkWell(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            width: double.infinity,
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(
                            live.user!.image != null ? '${AppHelper.loadImagePath(live.user!.image!)}' : 'https://i.postimg.cc/B6GcTk8F/default-avatar2.png'),
                      ),
                    ),
                    SizedBox(width: 16),
                    Text('${live.user!.name}', style: TextStyle(fontFamily: Const.appFont,
                        fontSize: 16,
                        fontWeight: FontWeight.w600),),
                    Spacer(),
                    TextButton(
                        child: Text(
                          'join'.tr,
                          style: TextStyle(
                              fontFamily: Const.appFont,
                          fontSize: 16,
                          fontWeight: FontWeight.w600),),
                        onPressed: (){

                          AppHelper.saveAppData(key: Const.KEY_LIVE_ID, value: live.id);
                          AppHelper.saveLiveToken(key: Const.KEY_LIVE_TOKEN, token: live.liveToken!);
                          Const.LIVE_TOKEN = live.liveToken!;
                          homeController.joinLive(context, isBroadcaster: true, userType: Const.KEY_GUEST)
                              .then((value) {
                                _liveController.joinToBroadcast(liveId: live.id!);
                          });
                        })
                  ],
                ),
              ],
            ),
          ),
      onTap: () async {
        AppHelper.saveAppData(key: Const.KEY_LIVE_ID, value: live.id);
        AppHelper.saveLiveToken(key: Const.KEY_LIVE_TOKEN, token: live.liveToken!);
        Const.LIVE_TOKEN = live.liveToken!;
        await homeController.joinLive(context, isBroadcaster: false, userType: Const.KEY_VIEWER);
      })
  );
}
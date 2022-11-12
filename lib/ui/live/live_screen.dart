import 'package:expectations/controllers/live_controller.dart';
import 'package:expectations/model/live/comment/comments.dart';
import 'package:expectations/shared/components/constants.dart';
import 'package:expectations/shared/style/colors.dart';
import 'package:expectations/utils/app_helper.dart';
import 'package:flutter/material.dart';
import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:agora_rtc_engine/rtc_local_view.dart' as RtcLocalView;
import 'package:agora_rtc_engine/rtc_remote_view.dart' as RtcRemoteView;
import 'package:flutter_hex_color/flutter_hex_color.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rx_permissions/rx_permissions.dart';

class LiveScreen extends StatefulWidget {
  bool isBroadcaster = true;
  String userType = '';

  // Guest
  // broadcaster
  // viewer

  LiveScreen(
      {this.isBroadcaster = true, this.userType = Const.KEY_BROADCASTER});

  @override
  State<LiveScreen> createState() => _LiveScreenState();
}

class _LiveScreenState extends State<LiveScreen> {
  LiveController _liveController = Get.put(LiveController());
  var _commentController = TextEditingController();

  final _users = <int>[];
  late RtcEngine _engine;
  bool muted = false;

  // bool isBroadcaster = true;

  @override
  void initState() {
    requestMultiplePermissions();
    super.initState();
    initiliazedAgora();
    print('isBroadcaster: ${widget.userType}');
    if (widget.userType == Const.KEY_BROADCASTER) {
      // _liveController.createNewLive();
    } else if (widget.userType == Const.KEY_VIEWER)
      _liveController.watchBroadcast(
          liveId: AppHelper.getAppData(key: Const.KEY_LIVE_ID));

    _liveController.checkIsLike(liveId: AppHelper.getLiveId());

    print('LIVE_ID: ${AppHelper.getAppData(key: Const.KEY_LIVE_ID)}');
    // print('getAppData LIVE: ${AppHelper.getLiveToken(key: Const.KEY_LIVE_TOKEN)}');
  }

  void requestMultiplePermissions() async {
    if (await Permission.camera.isDenied ||
        await Permission.microphone.isDenied) {
      Map<Permission, PermissionStatus> statuses = await [
        Permission.camera,
        Permission.microphone,
      ].request();
      print("CAMERA permission: ${statuses[Permission.camera]}, "
          "MIC permission: ${statuses[Permission.microphone]}");
    }
  }

  @override
  void dispose() {
    _engine.destroy();
    _onCallEnd(context);
    super.dispose();
  }

  Future<void> initiliazedAgora() async {
    await _initAgoraRtcEngin();
    _engine.setEventHandler(
        RtcEngineEventHandler(joinChannelSuccess: (channel, uid, elapsed) {
      setState(() {
        print('joinChannelSuccess: $channel $uid');
      });
    }, leaveChannel: (stats) {
      setState(() {
        print('leaveChannel:');
        _users.clear();
      });
    }, userJoined: (uid, elapsed) {
      setState(() {
        print('userJoined: $uid');
        _users.add(uid);
      });
    }, userOffline: (uid, elapsed) {
      setState(() {
        print('userOffline: $uid');
        _users.remove(uid);
      });
    }));

    // print('joinChannel: ${AppHelper.getLiveToken(key: Const.KEY_LIVE_TOKEN)}');
    // print('joinChannel: ${AppHelper.getChannelName(key: Const.KEY_CHANNEL_NAME)}');
    print('joinChannel: ${Const.LIVE_TOKEN}');
    print('joinChannel: ${AppHelper.getLiveToken(key: Const.KEY_LIVE_TOKEN)}');

    await _engine.joinChannel(AppHelper.getLiveToken(key: Const.KEY_LIVE_TOKEN), 'ahmed', '', 0);
  }

  Future<void> _initAgoraRtcEngin() async {
    _engine =
        await RtcEngine.createWithContext(RtcEngineContext(Const.LIVE_APP_ID));
    await _engine.enableVideo();

    await _engine.setChannelProfile(ChannelProfile.LiveBroadcasting);
    if (widget.userType == Const.KEY_BROADCASTER ||
        widget.userType == Const.KEY_GUEST)
      await _engine.setClientRole(ClientRole.Broadcaster);
    else if (widget.userType == Const.KEY_VIEWER)
      await _engine.setClientRole(ClientRole.Audience);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Container(
              // 383838
              margin: EdgeInsetsDirectional.only(top: 20),
              padding: const EdgeInsets.symmetric(vertical: 28),
              color: HexColor('2C2C2C'),
              child: Row(
                children: [
                  Container(
                    margin: EdgeInsetsDirectional.only(start: 16, top: 16),
                    padding:
                        EdgeInsetsDirectional.only(top: 2, bottom: 2, end: 30),
                    alignment: Alignment.topRight,
                    decoration: BoxDecoration(
                        color: HexColor('383838'),
                        borderRadius: BorderRadius.circular(50)),
                    child: Row(
                      children: [
                        CircleAvatar(
                            backgroundImage:
                                NetworkImage('${AppHelper.getDefaultImage()}')),
                        SizedBox(width: 10),
                        Column(
                          children: [
                            Text(
                              '${AppHelper.getUserName()}',
                              style: TextStyle(color: Colors.white),
                            ),
                            SizedBox(height: 2),
                            FutureBuilder(
                              future: _liveController.getUsers(
                                  liveId: AppHelper.getLiveId()),
                              builder: (context, snapshot) => Text(
                                '${_liveController.listUsersOnline.length} Online',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 10),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  Container(
                    alignment: Alignment.topLeft,
                    margin: EdgeInsetsDirectional.only(top: 10, start: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        widget.userType == Const.KEY_VIEWER
                            ? Container()
                            : IconButton(
                                icon: Icon(
                                  Icons.switch_camera,
                                  color: Colors.white,
                                  size: 20.0,
                                ),
                                onPressed: _onSwitchCamera),
                        widget.userType == Const.KEY_VIEWER
                            ? Container()
                            : IconButton(
                                icon: Icon(
                                  muted ? Icons.mic_off : Icons.mic,
                                  color:
                                      muted ? Colors.redAccent : Colors.white,
                                  size: 24.0,
                                ),
                                color: muted ? Colors.white : Colors.redAccent,
                                onPressed: _onToggleMute),
                        IconButton(
                          icon: Icon(Icons.close, color: Colors.white),
                          onPressed: () => _onCallEnd(context),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            _broadcastView(),
            Expanded(child: _toolbar()),
          ],
        ),
      ),
    );
  }

  Widget _toolbar() {
    return widget.userType == Const.KEY_BROADCASTER ||
            widget.userType == Const.KEY_GUEST
        ? Column(
            children: [
              Expanded(
                child: Container(
                  color: HexColor('2C2C2C'),
                  alignment: Alignment.bottomCenter,
                  width: double.infinity,
                  height: 100,
                  // color: Colors.amber,
                  child: Column(
                    children: [
                      Expanded(
                        child: FutureBuilder(
                          future: _liveController.getLiveComments(liveId: 10),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.done)
                              return ListView.builder(
                                  itemCount:
                                      _liveController.listComments.length,
                                  itemBuilder: (context, index) =>
                                      buildCommentsItem(
                                          _liveController.listComments[index]));
                            else
                              return Container();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )
        : Column(
            children: [
              Expanded(
                child: Container(
                  color: HexColor('2C2C2C'),
                  alignment: Alignment.bottomCenter,
                  width: double.infinity,
                  height: 100,
                  // color: Colors.amber,
                  child: Column(
                    children: [
                      Expanded(
                        child: FutureBuilder(
                          future: _liveController.getLiveComments(liveId: 10),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.done)
                              return ListView.builder(
                                  itemCount:
                                      _liveController.listComments.length,
                                  itemBuilder: (context, index) =>
                                      buildCommentsItem(
                                          _liveController.listComments[index]));
                            else
                              return Container();
                          },
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(16),
                        child: Row(
                          children: [
                            InkWell(
                              child: SvgPicture.asset(
                                  'assets/icons/share_live.svg'),
                              onTap: () {},
                            ),
                            IconButton(
                                padding: EdgeInsets.zero,
                                icon: Icon(Icons.send,
                                    color: HexColor(AppColors.defualtColor),
                                    size: 30,
                                    textDirection: TextDirection.ltr),
                                onPressed: () {
                                  _liveController.createComment(
                                      liveId: AppHelper.getLiveId(),
                                      comment: _commentController.text);
                                  _commentController.text = "";
                                }),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              width: 220,
                              height: 40,
                              decoration: BoxDecoration(
                                  color: HexColor('2C2C2C'),
                                  borderRadius: BorderRadius.circular(20)),
                              child: Center(
                                child: TextFormField(
                                  controller: _commentController,
                                  style: TextStyle(color: Colors.white),
                                  decoration: InputDecoration.collapsed(
                                      hintText: 'write comment',
                                      hintStyle:
                                          TextStyle(color: Colors.white)),
                                ),
                              ),
                            ),
                            Spacer(),
                            Obx(() => IconButton(
                                icon: Icon(
                                    size: 32,
                                    _liveController.isLike == true
                                        ? Icons.favorite_rounded
                                        : Icons.favorite_border_rounded,
                                    color: HexColor(AppColors.defualtColor)),
                                onPressed: () {
                                  if (_liveController.isLike == true)
                                    _liveController.deleteLike(
                                        liveId: AppHelper.getLiveId());
                                  else
                                    _liveController.makeLike(
                                        liveId: AppHelper.getLiveId());
                                })),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
  }

  // Helper function to get list of native views
  List<Widget> _getRenderViews() {
    final List<StatefulWidget> list = [];
    if (widget.userType == Const.KEY_BROADCASTER ||
        widget.userType == Const.KEY_GUEST)
      list.add(RtcLocalView.SurfaceView());
    _users.forEach((uid) =>
        list.add(RtcRemoteView.SurfaceView(uid: uid, channelId: 'ahmed')));
    return list;
  }

  // Video view row wrapper
  Widget _expandedVideoView(List<Widget> views) {
    final wrapperViews =
        views.map((view) => Expanded(child: Container(child: view))).toList();
    return Expanded(
      child: Row(
        children: wrapperViews,
      ),
    );
  }

  /// Video layout wrapper
  Widget _broadcastView() {
    final views = _getRenderViews();
    switch (views.length) {
      case 1:
        return Container(
            height: 350,
            child: Row(
              children: <Widget>[
                _expandedVideoView([views[0]])
              ],
            ));
      case 2:
        return Container(
            height: 350,
            child: Row(
              children: <Widget>[
                _expandedVideoView([views[0]]),
                _expandedVideoView([views[1]])
              ],
            ));
      case 3:
        return Container(
            height: 350,
            child: Row(
              children: <Widget>[
                _expandedVideoView(views.sublist(0, 2)),
                _expandedVideoView(views.sublist(2, 3))
              ],
            ));
      case 4:
        return Container(
            height: 350,
            child: Row(
              children: <Widget>[
                _expandedVideoView(views.sublist(0, 2)),
                _expandedVideoView(views.sublist(2, 4))
              ],
            ));
      default:
    }
    return Container();
  }

  Widget _oldBroadcastView() {
    final views = _getRenderViews();
    switch (views.length) {
      case 1:
        return Container(
            child: Column(
          children: <Widget>[
            _expandedVideoView([views[0]])
          ],
        ));
      case 2:
        return Container(
            child: Column(
          children: <Widget>[
            _expandedVideoView([views[0]]),
            _expandedVideoView([views[1]])
          ],
        ));
      case 3:
        return Container(
            child: Column(
          children: <Widget>[
            _expandedVideoView(views.sublist(0, 2)),
            _expandedVideoView(views.sublist(2, 3))
          ],
        ));
      case 4:
        return Container(
            child: Column(
          children: <Widget>[
            _expandedVideoView(views.sublist(0, 2)),
            _expandedVideoView(views.sublist(2, 4))
          ],
        ));
      default:
    }
    return Container();
  }

  void _onCallEnd(context) {
    // print("LIVEID: ${_liveController.liveId}");
    print("_onCallEnd LIVEID: ${AppHelper.getLiveId()}");
    if (widget.userType == Const.KEY_BROADCASTER)
      _liveController.closeLive(context, liveId: AppHelper.getAppData(key: Const.KEY_LIVE_ID));
    else if (widget.userType == Const.KEY_GUEST) {
      _liveController.exitFromBroadcast(context, liveId: AppHelper.getAppData(key: Const.KEY_LIVE_ID));
    } else {
      Navigator.pop(context);
    }
  }

  void _onToggleMute() {
    setState(() => muted = !muted);
    _engine.muteLocalAudioStream(muted);
  }

  void _onSwitchCamera() {
    _engine.switchCamera();
  }

  buildCommentsItem(LiveCommentData comments) => Container(
        margin: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Row(
          children: [
            Container(
              width: 32,
              height: 32,
              child: CircleAvatar(
                backgroundImage: NetworkImage(comments.user!.image != null
                    ? '${AppHelper.loadImagePath(AppHelper.formateTeamImage(comments.user!.image!))}'
                    : 'https://i.postimg.cc/B6GcTk8F/default-avatar2.png'),
              ),
            ),
            Container(
                margin: EdgeInsets.all(8),
                child: Text(
                  '${comments.comment}',
                  style: TextStyle(color: Colors.white),
                )),
          ],
        ),
      );

}

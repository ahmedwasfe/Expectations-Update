import 'package:expectations/api/api_requests.dart';
import 'package:expectations/controllers/favorite_controller.dart';
import 'package:expectations/model/favorite.dart';
import 'package:expectations/shared/components/components.dart';
import 'package:expectations/shared/components/constants.dart';
import 'package:expectations/shared/style/colors.dart';
import 'package:expectations/utils/app_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hex_color/flutter_hex_color.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';


class FavoritePage extends StatelessWidget {

  final FavoriteController _controller = Get.put(FavoriteController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          MainToolBar(title: 'Favorites', isBack: false, isProfile: false),
          Expanded(
            child: FutureBuilder(
              future: _controller.fetchFavorites(),
              builder: (context, snapshot){
                if(snapshot.connectionState == ConnectionState.done){
                  if(_controller.listFavorites.isNotEmpty){
                    return ListView.builder(
                        physics: BouncingScrollPhysics(),
                        itemCount: _controller.listFavorites.length,
                        itemBuilder: (context, index) =>
                            buildFavoritesItem(favorite: _controller.listFavorites[index]));
                  }else{
                    return ListView.builder(
                        physics: BouncingScrollPhysics(),
                        itemCount: 20,
                        itemBuilder: (context, index) => buildFavoritesItem());
                  }

                }else if(snapshot.connectionState == ConnectionState.waiting){
                  return CustomProgress();
                }else {
                  return Container();
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildFavoritesItem({FavoriteData? favorite}) => Container(
        width: double.infinity,
        height: 150,
        margin: EdgeInsets.symmetric(horizontal: 4, vertical: 8),
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            // side: BorderSide(color: Colors.black),
            borderRadius: BorderRadius.all(Radius.circular(14)),
          ),
          child: Stack(
            alignment: Alignment.topLeft,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8, left: 8),
                child: InkWell(
                  child: SvgPicture.asset('assets/icons/addedd_fav_red.svg'),
                  onTap: () =>  _controller.removeFromFavorite(favorite!.id!),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30, left: 8, right: 8),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      Column(
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            margin: EdgeInsets.symmetric(horizontal: 16),
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(
                                        favorite != null ? '${Const.baseImagesUrl}${AppHelper.getTeamHomeImage(favorite.match!)}' : '${Const.logoDefaultImage}'))),
                          ),
                          Text(
                            favorite != null ? '${favorite.match!.teamHome!.name!}' : 'Ttawaq3',
                            style: TextStyle(
                                color: HexColor(AppColors.blackColor),
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                fontFamily: Const.appFont),
                          ),
                        ],
                      ),
                      // SizedBox(width: 16),
                      favorite != null
                          ? Container(
                              width: 30,
                              height: 30,
                              margin: EdgeInsets.symmetric(horizontal: 8),
                              alignment: Alignment.center,
                              child: Text(
                                '${favorite.match!.result1}',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    color: HexColor(AppColors.defualtColor),
                                  ),
                                  borderRadius: BorderRadius.circular(50)),
                            )
                          : Container(
                              width: 30,
                              height: 30,
                              margin: EdgeInsets.symmetric(horizontal: 8),
                              alignment: Alignment.center,
                              child: Text(
                                '0',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    color: HexColor(AppColors.whiteColor),
                                  ),
                                  borderRadius: BorderRadius.circular(50)),
                            ),
                      // SizedBox(width: 16),
                      Container(
                        padding: EdgeInsets.all(6),
                        margin: EdgeInsets.symmetric(horizontal: 14),
                        height: double.infinity,
                        alignment: Alignment.center,
                        child: Column(
                          children: [
                            Container(
                              child: Text('not started'.tr,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: HexColor(AppColors.subTextColor),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: Const.appFont)),
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: HexColor(AppColors.greyColor2)),
                                  borderRadius: BorderRadius.circular(20)),
                            ),
                            Text(
                               favorite != null ? '${AppHelper.formatMatchTime(favorite.match!)}' : '10:00 PM',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: HexColor(AppColors.defualtColor),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: Const.appFont)),
                            Text(
                                favorite != null ? '${AppHelper.formatMatchDate(favorite.match!)}' : '14-05-2022',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: HexColor(AppColors.subTextColor),
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: Const.appFont)),
                          ],
                        ),
                      ),
                      // SizedBox(width: 16),
                      favorite != null
                          ? Container(
                              width: 30,
                              height: 30,
                              margin: EdgeInsets.symmetric(horizontal: 8),
                              alignment: Alignment.center,
                              child: Text(
                                '${favorite.match!.result2}',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    color: HexColor(AppColors.defualtColor),
                                  ),
                                  borderRadius: BorderRadius.circular(50)),
                            )
                          : Container(
                              width: 30,
                              height: 30,
                              margin: EdgeInsets.symmetric(horizontal: 8),
                              alignment: Alignment.center,
                              child: Text(
                                '0',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    color: HexColor(AppColors.whiteColor),
                                  ),
                                  borderRadius: BorderRadius.circular(50)),
                            ),
                      // SizedBox(width: 16),
                      Column(
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            margin: EdgeInsets.only(right: 16, left: 28),
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(
                                       favorite != null ? '${Const.baseImagesUrl}${AppHelper.getTeamAwayImage(favorite.match!)}' : '${Const.logoDefaultImage}'))),
                          ),
                          Text(
                            favorite != null ? '${favorite.match!.teamAway!.name!}' : 'Tawaq3',
                            style: TextStyle(
                                color: HexColor(AppColors.blackColor),
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                fontFamily: Const.appFont),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}

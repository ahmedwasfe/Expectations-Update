import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

class PayWallWidget extends StatefulWidget {
  final String title;
  final String description;
  final List<Package> packages;
  final ValueChanged<Package> onCLickPackage;

   PayWallWidget(
      {required this.title,
      required this.description,
      required this.packages,
      required this.onCLickPackage});

  @override
  State<PayWallWidget> createState() => _PayWallWidgetState();
}

class _PayWallWidgetState extends State<PayWallWidget> {
  @override
  Widget build(BuildContext context) => Container(
    constraints: BoxConstraints(
      maxHeight: MediaQuery.of(context).size.height * 0.75),
    child: SingleChildScrollView(
      padding: EdgeInsets.all(16.r),
      child: Column(
        children: [
          Text(widget.title, style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold)),
          SizedBox(height: 16.h),
          Text(widget.description,
              textAlign: TextAlign.center,
              style: TextStyle(
              fontSize: 18.sp)),
          SizedBox(height: 16.h),
          buildPackages(widget.packages),
        ],
      ),
    ),
  );

  Widget buildPackages(List<Package> packages) => ListView.builder(
    shrinkWrap: true,
      primary: false,
      itemCount: packages.length,
      itemBuilder: (context, index) => buildPackage(context, packages[index]));

  Widget buildPackage(BuildContext context, Package package) {
    final product = package.storeProduct;
    return Card(
      color: Theme.of(context).accentColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r)),
      child: Theme(
        data: ThemeData.light(),
        child: ListTile(
          contentPadding: EdgeInsets.all(8.r),
          title: Text(product.title, style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold)),
          subtitle: Text(product.description),
          trailing: Text(product.priceString, style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold)),
          onTap: () => widget.onCLickPackage(package),
        ),
      ),
    );
  }
}

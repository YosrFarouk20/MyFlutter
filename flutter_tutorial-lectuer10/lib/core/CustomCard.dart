import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_shop_app/app/core/Helper/AppConstant/AppColorConstant.dart';
import 'package:my_shop_app/app/core/Helper/AppConstant/AppTextStyleConstant.dart';

class CustomCard extends StatelessWidget {
  final String? txtStatus, txtName, txtAddress, imageUrl;
  final VoidCallback onTap, favorite;

  CustomCard({
    Key? key,
    required this.onTap,
    this.imageUrl,
    this.txtAddress,
    this.txtName,
    this.txtStatus,
    required this.favorite,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            boxShadow: [
              BoxShadow(
                offset: const Offset(2, 2),
                color: AppColor.primaryColorShadow,
                blurRadius: 5.0,
              ),
            ]),
        height: 200,
        child: Stack(
          children: [
            Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(7),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12.0),
                  child: Image.network(
                    imageUrl ?? "https://via.placeholder.com/250",
                    height: 250,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(Icons.image_not_supported,
                          size: 50, color: Colors.grey);
                    },
                  ),
                )),
            Positioned(
              top: 10,
              left: 1,
              right: 1,
              child: Container(
                margin: const EdgeInsets.only(left: 5),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20)),
                  gradient: AppColor.primaryColorGradientLTrance,
                ),
                child: Center(
                  child: Text(
                    txtStatus ?? "No Status",
                    style: AppTextStyle.h3,
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 45,
              right: 1,
              left: 1,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 30,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: AppColor.primaryColorGradientL),
                padding: const EdgeInsets.all(5),
                child: Text(
                  txtName ?? "No Name",
                  style: AppTextStyle.h3PCD,
                ),
              ),
            ),
            Positioned(
              bottom: 10,
              right: 50,
              left: 1,
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: AppColor.primaryColorGradientLTrance),
                padding: const EdgeInsets.all(10),
                child: Text(
                  txtAddress ?? "No Address",
                  style: AppTextStyle.h5,
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            Positioned(
              bottom: 5,
              right: 10,
              child: IconButton(
                  icon: Icon(CupertinoIcons.heart,
                      color: AppColor.primaryColor),
                  onPressed: favorite),
            )
          ],
        ),
      ),
    );
  }
}

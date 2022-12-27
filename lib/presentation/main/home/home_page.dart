import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_udemy_mvvm/app/di.dart';
import 'package:flutter_application_udemy_mvvm/domain/model/model.dart';
import 'package:flutter_application_udemy_mvvm/presentation/common/state_render/state_render_implementer.dart';
import 'package:flutter_application_udemy_mvvm/presentation/main/home/home_viewmodel.dart';
import 'package:flutter_application_udemy_mvvm/presentation/resources/color_manager.dart';
import 'package:flutter_application_udemy_mvvm/presentation/resources/strings_manager.dart';
import 'package:flutter_application_udemy_mvvm/presentation/resources/value_manager.dart';

import '../../resources/routes_manager.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeViewModel _homeViewModel = instance<HomeViewModel>();
  @override
  void initState() {
    _bind();
    super.initState();
  }

  _bind() {
    _homeViewModel.start();
  }

  @override
  void dispose() {
    _homeViewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: StreamBuilder<FlowState>(
          stream: _homeViewModel.outputState,
          builder: (context, snapshot) {
            return snapshot.data?.getScreenWidget(context, _getContentWidgets(),
                    () {
                  _homeViewModel.start();
                }) ??
                Container();
          },
        ),
      ),
    );
  }

  Widget _getContentWidgets() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _getBannersCarousel(),
        _getSection(AppStrings.services),
        _getServices(),
        _getSection(AppStrings.stores),
        _getStores(),
      ],
    );
  }

  Widget _getSection(String title) {
    return Padding(
      padding: EdgeInsets.only(
        top: AppPadding.p12,
        left: AppPadding.p12,
        right: AppPadding.p12,
        bottom: AppPadding.p8,
      ),
      child: Text(
        title,
        style: Theme.of(context).textTheme.headline3,
      ),
    );
  }

  Widget _getBannersCarousel() {
    return StreamBuilder<List<BannerAd>>(
      stream: _homeViewModel.outputBanners,
      builder: (context, snapshot) {
        return _getBanner(snapshot.data);
      },
    );
  }

  Widget _getBanner(List<BannerAd>? banners) {
    if (banners != null) {
      return CarouselSlider(
          items: banners
              .map((bannerItem) => SizedBox(
                    width: double.infinity,
                    child: Card(
                      elevation: AppSize.s1_5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppSize.s12),
                        side: BorderSide(
                          color: ColorManager.white,
                          width: AppSize.s1_5,
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(AppSize.s12),
                        child: Image.network(
                          bannerItem.image,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ))
              .toList(),
          options: CarouselOptions(
            height: AppSize.s190,
            autoPlay: true,
            enableInfiniteScroll: true,
            enlargeCenterPage: true,
          ));
    } else {
      return Container();
    }
  }

  Widget _getServices() {
    return StreamBuilder<List<Service>>(
      stream: _homeViewModel.outputServices,
      builder: (context, snapshot) {
        return _getService(snapshot.data);
      },
    );
  }

  Widget _getService(List<Service>? services) {
    if (services != null) {
      return Padding(
        padding: EdgeInsets.only(
          left: AppPadding.p12,
          right: AppPadding.p12,
        ),
        child: Container(
          height: AppSize.s140,
          margin: EdgeInsets.symmetric(vertical: AppMargin.m12),
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: services
                .map((service) => Card(
                      elevation: AppSize.s4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppSize.s12),
                        side: BorderSide(
                          color: ColorManager.white,
                          width: AppSize.s1_5,
                        ),
                      ),
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(AppSize.s12),
                            child: Image.network(
                              service.image,
                              fit: BoxFit.cover,
                              width: AppSize.s130,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: AppPadding.p8),
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                service.title,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          )
                        ],
                      ),
                    ))
                .toList(),
          ),
        ),
      );
    } else {
      return Container();
    }
  }

  Widget _getStores() {
    return StreamBuilder<List<Store>>(
      stream: _homeViewModel.outputStores,
      builder: (context, snapshot) {
        return _getStoreWidget(snapshot.data);
      },
    );
  }

  Widget _getStoreWidget(List<Store>? stores) {
    if (stores != null) {
      return Padding(
        padding: EdgeInsets.only(
          left: AppPadding.p12,
          right: AppPadding.p12,
        ),
        child: Flex(
          direction: Axis.vertical,
          children: [
            GridView.count(
              crossAxisSpacing: AppSize.s8,
              mainAxisSpacing: AppSize.s8,
              physics: ScrollPhysics(),
              shrinkWrap: true,
              crossAxisCount: 2,
              children: List.generate(stores.length, (index) {
                return InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed(Routes.storeDetailRoute);
                  },
                  child: Card(
                    elevation: AppSize.s4,
                    child: Image.network(
                      stores[index].image,
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              }),
            )
          ],
        ),
      );
    } else {
      return Container();
    }
  }
}

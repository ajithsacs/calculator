import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:unity_ads_plugin/unity_ads_plugin.dart';

class AdController extends GetxController {
  RxBool isRewardedAdReady = false.obs;

  @override
  void onInit() {
    super.onInit();
    _initializeUnityAds();
  }

  void _initializeUnityAds() {
    UnityAds.init(
      gameId: '5717371', // Replace with your Unity Game ID
      testMode: true,
      onComplete: () {
        print('Unity Ads Initialization Complete');
        _loadRewardedAd();
      },
      onFailed: (error, message) {
        print('Unity Ads Initialization Failed: $error $message');
      },
    );
  }

  void _loadRewardedAd() {
    UnityAds.load(
      placementId: AdManager.rewardedVideoAdPlacementId,
      onComplete: (placementId) {
        isRewardedAdReady.value = true;
        print('Rewarded Ad Loaded: $placementId');
      },
      onFailed: (placementId, error, message) {
        print('Failed to Load Rewarded Ad: $placementId, $error $message');
      },
    );
  }

  void showRewardedVideoAd() {
    isRewardedAdReady.value = false;
    UnityAds.showVideoAd(
      placementId: 'Rewarded_Android',
      onComplete: (placementId) {
        print('Rewarded Ad Completed: $placementId');
        _loadRewardedAd();
      },
      onFailed: (placementId, error, message) {
        print('Failed to Show Rewarded Ad: $placementId, $error $message');
        _loadRewardedAd();
      },
    );
  }
}

class AdManager {
  static String get gameId {
    if (defaultTargetPlatform == TargetPlatform.android) {
      return '5717371';
    }
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      return '5717370';
    }
    return '5717371';
  }

  static String get bannerAdPlacementId {
    return 'Banner_Android';
  }

  static String get interstitialVideoAdPlacementId {
    return 'Interstitial_Android';
  }

  static String get rewardedVideoAdPlacementId {
    return 'Rewarded_Android';
  }
}

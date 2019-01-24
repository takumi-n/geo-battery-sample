//
//  AppDelegate.swift
//  geo-battery-sample
//
//  Created by Takumi Nishimori on 2019/01/22.
//  Copyright © 2019 Takumi Nishimori. All rights reserved.
//

import UIKit
import CoreLocation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var locationManager: CLLocationManager!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        // 位置情報取得の設定
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.allowsBackgroundLocationUpdates = true
        locationManager.distanceFilter = 100
         locationManager.desiredAccuracy = kCLLocationAccuracyBest

        let status = CLLocationManager.authorizationStatus()

        if status != .authorizedAlways {
            // バックグラウンドでも取得するため位置情報の取得を「常に許可」することを要求する
            locationManager.requestAlwaysAuthorization()
        }

        locationManager.startUpdatingLocation()

        // 通常はdistanceFilterの値（このコードでは100m）移動しないと位置情報が更新されない
        // デバッグ用に10秒経過しても取得するように設定している
        // 電池消費が激しくなるので一般的にやらないほうが良い
        locationManager.allowDeferredLocationUpdates(untilTraveled: 100, timeout: 10)

        // バッテリー残量取得の設定
        UIDevice.current.isBatteryMonitoringEnabled = true
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
    }

    func applicationWillTerminate(_ application: UIApplication) {
    }
}

extension AppDelegate: CLLocationManagerDelegate {

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // 位置情報更新時に呼び出されるデリゲートメソッド
        guard let lastLocation = locations.last else {
            return
        }

        let eventDate = lastLocation.timestamp
        if abs(eventDate.timeIntervalSinceNow) < 15.0 {
            // 位置情報を取得
            guard let location = manager.location else {
                return
            }

            let updateCount = UserDefaults.standard.integer(forKey: "update_count")
            UserDefaults.standard.set(updateCount + 1, forKey: "update_count")

            UserDefaults.standard.set("\(location.coordinate.latitude)", forKey: "latitude")
            UserDefaults.standard.set("\(location.coordinate.longitude)", forKey: "longitude")

            // 位置情報取得のタイミングでバッテリー残量も取得

            let batteryLevel = UIDevice.current.batteryLevel

            UserDefaults.standard.set(batteryLevel, forKey: "battery")
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}

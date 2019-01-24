//
//  ViewController.swift
//  geo-battery-sample
//
//  Created by Takumi Nishimori on 2019/01/22.
//  Copyright © 2019 Takumi Nishimori. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {

    @IBOutlet weak var updateCountLabel: UILabel!
    @IBOutlet weak var latitudeLabel: UILabel!
    @IBOutlet weak var longitudeLabel: UILabel!
    @IBOutlet weak var batteryStatusLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        // 最新の取得情報を表示する
        let updateCount = UserDefaults.standard.integer(forKey: "update_count")
        updateCountLabel.text = "\(updateCount)"

        let lastLatitude = UserDefaults.standard.string(forKey: "latitude") ?? "None"
        latitudeLabel.text = "\(lastLatitude)"

        let lastLongitude = UserDefaults.standard.string(forKey: "longitude") ?? "None"
        longitudeLabel.text = "\(lastLongitude)"

        let batteryStatus = UserDefaults.standard.float(forKey: "battery")
        batteryStatusLabel.text = "\(batteryStatus * 100)%"
    }

    @IBAction func refreshButtonDidTap(_ sender: Any) {
        // 表示しているデータを最新の状態へ更新する
        let updateCount = UserDefaults.standard.integer(forKey: "update_count")
        updateCountLabel.text = "\(updateCount)"

        let lastLatitude = UserDefaults.standard.string(forKey: "latitude") ?? "None"
        latitudeLabel.text = "\(lastLatitude)"

        let lastLongitude = UserDefaults.standard.string(forKey: "longitude") ?? "None"
        longitudeLabel.text = "\(lastLongitude)"

        let batteryStatus = UserDefaults.standard.float(forKey: "battery")
        batteryStatusLabel.text = "\(batteryStatus * 100)%"
    }
}

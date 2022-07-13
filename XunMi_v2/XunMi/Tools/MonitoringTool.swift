//
//  MonitoringTool.swift
//  XunMi
//
//  Created by 残云cyun on 2022/7/6.
//

import Foundation
import CoreLocation

class RegionMonitoringTool: NSObject, CLLocationManagerDelegate {
    // MARK: --------- Properties ----------
    // 位置管理对象
    lazy var locationManager: CLLocationManager = {
        let manager = CLLocationManager()
        manager.delegate = self
        return manager
    }()
    
    // 回传闭包
    var completion: ((Bool) -> Void)?
    
    
    // MARK: --------- Methods ----------
    // 判断位置服务是否可用
    func locationServiceAvaiable() -> Bool {
        return CLLocationManager.locationServicesEnabled()
    }
    
    // 申请位置获取授权
    func requestAuthorization()  {
        locationManager.requestWhenInUseAuthorization()
    }
    
    // 判断区域监测是否可用
    func regionAvaiable() -> Bool {
        return CLLocationManager.isMonitoringAvailable(for: CLRegion.self)
    }
    
    // 开启区域监测
    func startMonitoring(region: CLRegion, completion: @escaping (Bool) -> Void) {
        self.completion = completion
        locationManager.startMonitoring(for: region)
    }
    
    
    // MARK: --------- CLLocationManagerDelegate ----------
    // 设备进入监测区域
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        if let completion = completion {
            completion(true)
        }
    }
    
    // 设备离开监测区域
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        if let completion = completion {
            completion(false)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, monitoringDidFailFor region: CLRegion?, withError error: Error) {
        print("错误=\(error.localizedDescription)")
    }
}

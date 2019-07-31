//
//  NRLoggerOptions.swift
//  NRLogger
//
//  Created by Moises Hernández on 7/30/19.
//

import Foundation

@objc public class NRLoggerOptions: NSObject {
    private var appBuild: String = Bundle.main.buildNumber ?? ""
    private var appName: String = Bundle.main.bundleIdentifier ?? ""
    private var appVersion: String = Bundle.main.versionNumber ?? ""
    private var deviceID: String = UIDevice.current.identifierForVendor?.uuidString ??  ""
    private var deviceManufacturer: String = "Apple"
    private var deviceModel: String = UIDevice.modelName
    private var osName: String = UIDevice.current.systemName
    private var osVersion: String = UIDevice.current.systemVersion
    private var sdkBuild: String
    
    var dictionary: [String: Any] {
        return [
            "appBuild": appBuild,
            "appName": appName,
            "appVersion": appVersion,
            "deviceID": deviceID,
            "deviceManufacturer": deviceManufacturer,
            "deviceModel": deviceModel,
            "osName": osName,
            "osVersion": osVersion,
        ]
    }
    
    public init(sdkBuild: String) {
        self.sdkBuild = sdkBuild
    }
}

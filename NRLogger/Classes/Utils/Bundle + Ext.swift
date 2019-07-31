//
//  Bundle + Ext.swift
//  NRLogger
//
//  Created by Moises Hernández on 7/30/19.
//

extension Bundle {
    
    var srPagoReleaseMode: Bool {
        var isReleaseMode: Bool?
        
        let srPagoDictionary = infoDictionary?["sr_pago"] as? NSDictionary
        isReleaseMode = srPagoDictionary?["sr_pago_release_mode"] as? Bool
        
        assert(isReleaseMode != nil, "Enviroment metadata not found")
        return isReleaseMode ?? false
    }
    
    var versionNumber: String? {
        return infoDictionary?["CFBundleShortVersionString"] as? String
    }
    
    var buildNumber: String? {
        return infoDictionary?["CFBundleVersion"] as? String
    }
    
    var bundleIdentifier: String? {
        return infoDictionary?["CFBundleIdentifier"] as? String
    }
    
}

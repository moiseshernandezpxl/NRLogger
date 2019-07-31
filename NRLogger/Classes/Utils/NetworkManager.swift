//
//  OfflineManager.swift
//  NRLogger
//
//  Created by Moises Hernández on 7/30/19.
//

import Foundation

class NetworkManager {
    
    public static var shared = NetworkManager()
    
    private init() {
    }
    
    public func startObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(reachabilityChange(_:)), name: .flagsChanged, object: nil)
    }
    
    @objc func reachabilityChange(_ sender: Notification) {
        guard let reachability = sender.object as? Reachability else { return }
        if reachability.isReachable {
            while let body = DataStore.sharedInstance.getFirstPendingBody() {
                ApiClient().send(body: body)
            }
        }
    }
}

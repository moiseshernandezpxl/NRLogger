//
//  NRLogger.swift
//  NRLogger
//
//  Created by Moises Hernández on 7/29/19.
//

import Foundation

@objc public class NRLogger: NSObject {
    
    public static var insertKey: String = ""
    
    var options: NRLoggerOptions!
    var stackTrace = ""
    
    var dictionary: [String: Any] {
        var json: [String: Any] = [
            "timestamp": Date().timeIntervalSince1970,
            "connectionType": Network.reachability.status.name,
            "stackTrace": stackTrace
        ]
        json.merge(options.dictionary) { (current, _) -> Any in current }
        return json
    }
    
    @objc public init(options: NRLoggerOptions) {
        assert(!NRLogger.insertKey.isEmpty, "NRLogger is not configured")
        self.options = options
    }
    
    @objc public class func configure(insertKey: String) {
        assert(!insertKey.isEmpty, "Insert key not valid")
        NRLogger.insertKey = insertKey
        NRLogger.configureNetworkReachability()
        NetworkManager.shared.startObserver()
    }
    
    @objc public func addToStackTrace(string: String) {
        if stackTrace.isEmpty {
            stackTrace = string
        } else {
            stackTrace = "\(stackTrace)\n -> \(string)"
        }
    }
    
    @objc public func logLoginEvent(userEmail: String) {
        var json = dictionary
        json.updateValue("Login\(!NRLogger.isReleaseMode ? "Sandbox" : "")", forKey: "eventType")
        json.updateValue(userEmail, forKey: "user")
        ApiClient().send(body: json)
    }
    
    @objc public func logLoginEvent(productToken: String) {
        var json = dictionary
        json.updateValue("Login\(!NRLogger.isReleaseMode ? "Sandbox" : "")", forKey: "eventType")
        json.updateValue(productToken, forKey: "productToken")
        ApiClient().send(body: json)
    }
    
    @objc public func logTransactionEvent(amount: CGFloat, cardType: CardType, commision: CGFloat, currency: Currency, latitude: CGFloat, longitude: CGFloat, makePaymentFailReason: String, msi: Int, readerBatteryPercentage: Int, readerFirmware: String, readerHardware: String, readerIsCharging: Bool, readerType: ReaderType, readerAppOsName: String? = nil, readerOsVersion: String? = nil, reference: String, status: String, tip: CGFloat, total: CGFloat, transactionTime: String, user: String) {
        
        var json = dictionary
            .merging([
                "eventType": "Transactions\(!NRLogger.isReleaseMode ? "Sandbox" : "")",
                "amount": amount,
                "cardType": cardType.name,
                "commision": commision,
                "currency": currency.name,
                "latitude": latitude,
                "longitude": longitude,
                "makePaymentFailReason": makePaymentFailReason,
                "msi": msi,
                "readerType": readerType.name,
                "readerBatteryPercentage": readerBatteryPercentage,
                "readerFirmware": readerFirmware,
                "readerHardware": readerHardware,
                "readerIsCharging": readerIsCharging,
                "reference": reference,
                "status": status,
                "tip": tip,
                "total": total,
                "transactionTime": transactionTime,
                "user": user
            ]) { (current, _) -> Any in current }
        
        if readerType == ReaderType.PAX {
            assert(readerAppOsName != nil, "readerAppOsName can't be nil if readerType equals PAX")
            assert(readerOsVersion != nil, "readerOsVersion can't be nil if readerType equals PAX")
            json.updateValue(readerAppOsName!, forKey: "readerAppOsName")
            json.updateValue(readerOsVersion!, forKey: "readerOsVersion")
        }
    
        ApiClient().send(body: json)
    }
}

extension NRLogger {
    
    private class func configureNetworkReachability() {
        do {
            try Network.reachability = Reachability(hostname: "www.google.com")
        } catch {
            switch error as? Network.Error {
            case let .failedToCreateWith(hostname)?:
                print("Network error:\nFailed to create reachability object With host named:", hostname)
            case let .failedToInitializeWith(address)?:
                print("Network error:\nFailed to initialize reachability object With address:", address)
            case .failedToSetCallout?:
                print("Network error:\nFailed to set callout")
            case .failedToSetDispatchQueue?:
                print("Network error:\nFailed to set DispatchQueue")
            case .none:
                print(error)
            }
        }
    }
    
    private class var isReleaseMode: Bool {
        return Bundle.main.srPagoReleaseMode
    }
}

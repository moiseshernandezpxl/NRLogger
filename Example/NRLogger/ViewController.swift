//
//  ViewController.swift
//  NRLogger
//
//  Created by moiseshernandezpxl on 07/31/2019.
//  Copyright (c) 2019 moiseshernandezpxl. All rights reserved.
//

import UIKit
import NRLogger

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        logTransaction()
    }
    
    func logTransaction() {
        let options = NRLoggerOptions(sdkBuild: "11.201")
        let transactionLogger = NRLogger(options: options)
        transactionLogger.addToStackTrace(string: "Added produt to cart")
        transactionLogger.addToStackTrace(string: "Pay Tapped")
        transactionLogger.addToStackTrace(string: "CreditCard Selected")
        transactionLogger.addToStackTrace(string: "10% Tip Tapped")
        transactionLogger.addToStackTrace(string: "Pin typed")
        transactionLogger.addToStackTrace(string: "Finish transaction tapped")
        transactionLogger.logTransactionEvent(amount: 1543.02, cardType: .AmericanExpress, commision: 10.23, currency: .MXN, latitude: 103.0042, longitude: 20.040, makePaymentFailReason: "none", msi: 0, readerBatteryPercentage: 87, readerFirmware: "10.20.1", readerHardware: "A192a", readerIsCharging: false, readerType: .PAX, readerAppOsName: "TEST", readerOsVersion: "103.40", reference: "coca", status: "SUCCESS", tip: 10.0, total: 12305.00, transactionTime: "1 minuto", user: "moises.hernandez@pixzelle.mx")
    }
    
    func logLogin() {
        let options = NRLoggerOptions(sdkBuild: "10.00")
        let loginLogger = NRLogger(options: options)
        loginLogger.addToStackTrace(string: "Email typed")
        loginLogger.addToStackTrace(string: "Password typed")
        loginLogger.addToStackTrace(string: "Login tapped")
        loginLogger.logLoginEvent(userEmail: "moises.hernandez@pixzelle.mx")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

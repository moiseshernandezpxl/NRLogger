//
//  NRLogger + Types.swift
//  NRLogger
//
//  Created by Moises Hernández on 7/30/19.
//

extension NRLogger {
    
    @objc public enum ReaderType: Int {
        
        case QPOSBluetooth
        case QPOSAudio
        case BBPOSBluetooth
        case BBPOSAudio
        case PAX
        
        var name: String {
            switch self {
            case .QPOSBluetooth:
                return "QPOS_BLUETOOTH_READER"
            case .QPOSAudio:
                return "QPOS_AUDIO_READER"
            case .BBPOSBluetooth:
                return "BBPOS_BLUETOOTH_READER"
            case .BBPOSAudio:
                return "BBPOS_AUDIO_READER"
            case .PAX:
                return "PAX"
            }
        }
    }
    
    @objc public enum CardType: Int {
        case MasterCard
        case Visa
        case AmericanExpress
        
        var name: String {
            switch self {
            case .MasterCard:
                return "MAST"
            case .Visa:
                return "VISA"
            case .AmericanExpress:
                return "AMEX"
            }
        }
    }
    
    @objc public enum Currency: Int {
        case MXN
        case USD
        
        var name: String {
            switch self {
            case .MXN:
                return "MXN"
            case .USD:
                return "USD"
            }
        }
    }
}

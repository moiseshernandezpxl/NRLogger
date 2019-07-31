//
//  DataStore.swift
//  NRLogger
//
//  Created by Moises Hernández on 7/30/19.
//

import Foundation

class DataStore {
    
    static let sharedInstance = DataStore()
    
    private init() {
        loadData()
    }
    
    private var pendingBodys: [[String: Any]] = []
    
    var filePath: String {
        //1 - manager lets you examine contents of a files and folders in your app; creates a directory to where we are saving it
        let manager = FileManager.default
        //2 - this returns an array of urls from our documentDirectory and we take the first path
        let url = manager.urls(for: .documentDirectory, in: .userDomainMask).first!
        print("this is the url path in the documentDirectory \(url)")
        //3 - creates a new path component and creates a new file called "Data" which is where we will store our Data array.
        return url.appendingPathComponent("Data").path
    }
    
    private func saveData() {
        NSKeyedArchiver.archiveRootObject(self.pendingBodys, toFile: filePath)
    }
    
    public func add(item: [String: Any]) {
        self.pendingBodys.append(item)
        self.saveData()
    }
    
    private func loadData() {
        if let ourData = NSKeyedUnarchiver.unarchiveObject(withFile: filePath) as? [[String: Any]] {
            self.pendingBodys = ourData
        }
    }
    
    public func getFirstPendingBody() -> [String: Any]? {
        if self.pendingBodys.isEmpty { return nil }
        let item = self.pendingBodys.removeFirst()
        saveData()
        return item
    }
}

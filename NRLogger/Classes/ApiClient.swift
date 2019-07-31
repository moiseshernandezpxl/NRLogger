//
//  ApiClient.swift
//  NRLogger
//
//  Created by Moises Hernández on 7/30/19.
//

import Foundation

class ApiClient {

    public func send(body: [String: Any]) {
        
        let session = URLSession.shared
        
        let url = URL(string: "https://insights-collector.newrelic.com/v1/accounts/1377870/events")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue(NRLogger.insertKey, forHTTPHeaderField: "X-Insert-Key")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let jsonData = try! JSONSerialization.data(withJSONObject: body, options: [])
        
        let task = session.uploadTask(with: request, from: jsonData) { (data, response, error) in
            if let data = data, let dataString = String(data: data, encoding: .utf8) {
                print(dataString)
            }
            if let httpResponse = response as? HTTPURLResponse {
                print(httpResponse.statusCode)
            }
            if let error = error {
                print(error.localizedDescription)
                DataStore.sharedInstance.add(item: body)
            }
        }
        
        task.resume()
    }
    
}

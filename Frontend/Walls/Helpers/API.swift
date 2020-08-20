//
//  API.swift
//  Walls
//
//  Created by Nour Yehia on 8/19/20.
//  Copyright © 2020 Nour Yehia. All rights reserved.
//

import Foundation

func api(endpoint: String, method: String, body: [String: Any]? = nil) -> Any {
    var response: Any? = nil
    var req = URLRequest(url: URL(string: "http://localhost:5000/\(endpoint)")!)
    
    req.addValue("application/json", forHTTPHeaderField: "Content-Type")
    req.httpMethod = method
    
    if let b = body {
        req.httpBody = try? JSONSerialization.data(withJSONObject: b, options: [])
    }
    
    let semaphore = DispatchSemaphore(value: 0)
    
    let task = URLSession.shared.dataTask(with: req) { (data, res, error) in
        if let e = error {
            response = ["error:": e]
            
        } else if let d = data {
            do {
                response = try JSONSerialization.jsonObject(with: d, options: []) as! [String: Any]
            } catch {
                response = try! JSONSerialization.jsonObject(with: d, options: [])
                           as! [Dictionary<String, Any>]
            }

        } else {
            response = [["error:": "Data could not be fetched."]]
        }
        
        semaphore.signal()
    }
    
    task.resume()
    _ = semaphore.wait(timeout: .distantFuture)
    
    return response!
}

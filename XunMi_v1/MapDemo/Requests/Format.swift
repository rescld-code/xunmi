//
//  Format.swift
//  MapDemo
//
//  Created by 残云cyun on 2022/7/6.
//

import Foundation

class Format {
    
    static func jsonFormat(request: URLRequest, completion:@escaping ([String: Any]) -> Void) {
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print(error)
                return
            }
            
            guard let data = data else {
                print("None")
                return
            }
            
            guard let jsonDict = try? JSONSerialization.jsonObject(with: data) as? [String: Any] else {
                return
            }
            
            DispatchQueue.main.async {
                completion(jsonDict)
            }

        }.resume()
    }
}

//
//  Pills.swift
//  MapDemo
//
//  Created by 残云cyun on 2022/7/6.
//

import Foundation

class Pills {
    static func putPills(latitude: Double, longitude: Double, text: String, completion:@escaping ([String: Any]) -> Void) {
        let url = URL(string: "\(ConstantModel.url)/pills")
        
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        let poststring = "latitude=\(latitude)&longitude=\(longitude)&text=\(text)"
        request.httpBody = poststring.data(using: String.Encoding.utf8)
        Format.jsonFormat(request: request) { result in
            completion(result)
        }
    }
}

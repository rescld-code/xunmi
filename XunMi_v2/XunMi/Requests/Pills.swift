//
//  Pills.swift
//  XunMi
//
//  Created by 残云cyun on 2022/7/11.
//

import UIKit
import SwiftUI

class Pills {
    static func PutPills(pills: PillsAttribute, completion:@escaping ([String: Any]) -> Void) {
        @AppStorage("uid") var uid: Int = 0
        let url = URL(string: "\(Constant.url)/pills")
        
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        let poststring = "uid=\(uid)&theme=\(pills.theme.rawValue)&latitude=\(pills.latitude)&longitude=\(pills.longitude)&privacy=\(pills.privacy)&text=\(pills.text)"
        request.httpBody = poststring.data(using: String.Encoding.utf8)
        Format.jsonFormat(request: request) { result in
            completion(result)
        }
    }
    
    static func GetAllPills(completion:@escaping ([String: Any]) -> Void) {
        let url = URL(string: "\(Constant.url)/pills?id=-1")
        
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        
        Format.jsonFormat(request: request) { result in
            completion(result)
        }
    }
    
    static func GetPills(id: Int, completion:@escaping ([String: Any]) -> Void) {
        let url = URL(string: "\(Constant.url)/pills?id=\(id)")
        
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        
        Format.jsonFormat(request: request) { result in
            completion(result)
        }
    }
    
}

//
//  UserAttribute.swift
//  XunMi
//
//  Created by 残云cyun on 2022/7/12.
//

import Foundation

class UserAttribute {
    static func ChangeUsername(uid: Int, username: String, completion:@escaping ([String: Any]) -> Void) {
        let url = URL(string: "\(Constant.url)/username")
        
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        let poststring = "uid=\(uid)&username=\(username)"
        request.httpBody = poststring.data(using: String.Encoding.utf8)
        Format.jsonFormat(request: request) { result in
            completion(result)
        }
    }
    
    static func ChangeTelphone(uid: Int, telphone: String, completion:@escaping ([String: Any]) -> Void) {
        let url = URL(string: "\(Constant.url)/telphone")
        
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        let poststring = "uid=\(uid)&telphone=\(telphone)"
        request.httpBody = poststring.data(using: String.Encoding.utf8)
        Format.jsonFormat(request: request) { result in
            completion(result)
        }
    }
    
    static func ChangePassword(uid: Int, password: String, newPassword: String, completion:@escaping ([String: Any]) -> Void) {
        let url = URL(string: "\(Constant.url)/password")
        
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        let poststring = "uid=\(uid)&password=\(password)&newPassword=\(newPassword)"
        request.httpBody = poststring.data(using: String.Encoding.utf8)
        Format.jsonFormat(request: request) { result in
            completion(result)
        }
    }
}

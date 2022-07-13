//
//  Sign.swift
//  XunMi
//
//  Created by 残云cyun on 2022/7/7.
//

import Foundation
import SwiftUI

class Sign {
    static func signUp(username: String, password: String, telphone: String, completion:@escaping ([String: Any]) -> Void) {
        let url = URL(string: "\(Constant.url)/signup")
        
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        let poststring = "username=\(username)&password=\(password)&telphone=\(telphone)"
        request.httpBody = poststring.data(using: String.Encoding.utf8)
        Format.jsonFormat(request: request) { result in
            completion(result)
        }
    }
    
    static func forget(telphone: String, password: String, completion:@escaping ([String: Any]) -> Void) {
        let url = URL(string: "\(Constant.url)/forget")
        
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        let poststring = "password=\(password)&telphone=\(telphone)"
        request.httpBody = poststring.data(using: String.Encoding.utf8)
        Format.jsonFormat(request: request) { result in
            completion(result)
        }
    }
    
    static func signIn(username: String, password: String, completion:@escaping ([String: Any]) -> Void) {
        let url = URL(string: "\(Constant.url)/signin")
        
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        let poststring = "username=\(username)&password=\(password)"
        request.httpBody = poststring.data(using: String.Encoding.utf8)
        Format.jsonFormat(request: request) { result in
            completion(result)
        }
    }
    
    static func sms(tel: String, captcha: String, completion:@escaping ([String: Any]) -> Void) {
        let url = URL(string: "\(Constant.url)/sms?tel=\(tel)&captcha=\(captcha)")
        
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        Format.jsonFormat(request: request) { result in
            completion(result)
        }
    }
}

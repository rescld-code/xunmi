//
//  Sign.swift
//  MapDemo
//
//  Created by 残云cyun on 2022/7/5.
//

import Foundation
import SwiftUI

class Sign {
    static func signUp(username: String, password: String, completion:@escaping ([String: Any]) -> Void) {
        let url = URL(string: "\(ConstantModel.url)/signup")
        
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        let poststring = "username=\(username)&password=\(password)"
        request.httpBody = poststring.data(using: String.Encoding.utf8)
        Format.jsonFormat(request: request) { result in
            completion(result)
        }
    }
    
    static func signIn(username: String, password: String, completion:@escaping ([String: Any]) -> Void) {
        let url = URL(string: "\(ConstantModel.url)/login")
        
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        let poststring = "username=\(username)&password=\(password)"
        request.httpBody = poststring.data(using: String.Encoding.utf8)
        Format.jsonFormat(request: request) { result in
            completion(result)
        }
    }
}

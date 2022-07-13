//
//  Logs.swift
//  XunMi
//
//  Created by 残云cyun on 2022/7/11.
//

import UIKit
import SwiftUI

class Logs {
    static func login(completion:@escaping ([String: Any]) -> Void) {
        @AppStorage("uid") var uid: Int = 0
        
        let url = URL(string: "\(Constant.url)/logs?uid=\(uid)")
        
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        Format.jsonFormat(request: request) { result in
            completion(result)
        }
    }
}

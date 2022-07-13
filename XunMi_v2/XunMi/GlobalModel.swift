//
//  Constant.swift
//  XunMi
//
//  Created by 残云cyun on 2022/7/7.
//

import UIKit

class Constant {
    static var url = "https://api.rescld.cn"
}

class User: ObservableObject {
    @Published var uid: Int = -1
    @Published var username: String = "Username"
}

enum PillsTheme: String, CaseIterable, Identifiable {
    case Blue = "Blue"
    case Yellow = "Yellow"
    case Red = "Red"
    case Green = "Green"
    var id: Self { self }
}

struct PillsAttribute {
    var id: Int64 = 0
    var uid: Int64 = 0
    var theme: PillsTheme = .Blue
    var latitude: Double = 0.0
    var longitude: Double = 0.0
    var text: String = ""
    var privacy: Bool = false
    var createdAt: String = ""
    var updatedAt: String = ""
    var deletedAt: String = ""
}

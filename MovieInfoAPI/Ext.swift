//
//  Ext.swift
//  MovieInfoAPI
//
//  Created by 황재현 on 2023/04/21.
//

import Foundation
import UIKit

extension UIViewController {
    /// 어제날짜 Date 타입 String으로 변환
    func convertYesterDayToString() -> String {
        let yesterDay = Date(timeIntervalSinceNow: -86400)
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_kr")
        formatter.dateFormat = "YYYYMMdd"
        print("yesterDay = \(formatter.string(from: yesterDay))")
        
        return formatter.string(from: yesterDay)
    }
}

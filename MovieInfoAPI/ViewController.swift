//
//  ViewController.swift
//  MovieInfoAPI
//
//  Created by 황재현 on 2023/04/20.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    
    let dayButton: UIButton = {
        var button = UIButton()
        button.backgroundColor = .red
        button.addTarget(self, action: #selector(getDayInfo), for: .touchUpInside)
        button.setTitle("일별 박스오피스", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(dayButton)
        
        NSLayoutConstraint.activate([
            self.dayButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.dayButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        ])
    }
    
    
    /// 정보 가져옴
    @objc func getDayInfo() {
        print("getInfo() called")
        // MARK: - 파라미터 필수값
        // (key: f5eef3421c602c6cb7ea224104795888, targetDt: 어제날짜)
        
        // 기본 URL
        let urlString = "http://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList"
        
        // 파라미터
        let parameter: Parameters = ["key": "f5eef3421c602c6cb7ea224104795888", "targetDt": convertYesterDayToString()]
        
        // 서버통신
        AF.request(urlString,
                   method: .get,
                   parameters: parameter,
                   encoding: URLEncoding.default,
                   headers: ["Content-Type": "application/json", "Accept": "application/json"])
            .validate(statusCode: 200..<300)
            .responseJSON { response in
                print("response = \(response)")
                
                guard let data = response.data else {
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    let json = try decoder.decode(BoxOffice.self, from: data)
                    print("json = \(json)")
                } catch {
                    print("error = \(error)")
                }
            }
    }
}

//
//  ViewController.swift
//  MovieInfoAPI
//
//  Created by 황재현 on 2023/04/20.
//

import UIKit
import Alamofire
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    
    let tableView: UITableView = {
        var tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    
    let dataSource = Observable.of((1...30).map(String.init))
    let bag = DisposeBag()
    
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
        
//        self.view.addSubview(dayButton)
//
//        NSLayoutConstraint.activate([
//            self.dayButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
//            self.dayButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
//        ])
        
        testRx()
    }
    
    func testRx() {
        print("testRx() called")
        self.view.addSubview(tableView)
        
        tableView.backgroundColor = .red
        
        self.tableView.register(TestTableViewCell.self, forCellReuseIdentifier: "TestTableViewCell")
        
        NSLayoutConstraint.activate([
            self.tableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
        
//        dataSource.bind(to: tableView.rx.items(cellIdentifier: "TestTableViewCell", cellType: TestTableViewCell.self)) { (index, element, cell) in
//            cell.textLabel?.text = element
//        }.disposed(by: bag)
        
        dataSource.bind(to: tableView.rx.items) { (tableView, index, element) -> UITableViewCell in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "TestTableViewCell") else {
                print("cell nil")
                return UITableViewCell()
            }
            print("element = \(element)")
            cell.textLabel?.text = element

            return cell
        }.disposed(by: bag)
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

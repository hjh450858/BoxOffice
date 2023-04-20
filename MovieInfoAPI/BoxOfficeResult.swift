//
//  MovieInfoType.swift
//  MovieInfoAPI
//
//  Created by 황재현 on 2023/04/20.
//

import Foundation


struct BoxOffice: Codable {
    var boxOfficeResult: BoxOfficeResult
}


/// 서버에서 내려준 일별 박스오피스 타입
struct BoxOfficeResult: Codable {
    /// 박스오피스 종류
    var boxOfficeType: String
    /// 박스오피스 조회 일자
    var showRange: String
    /// 일별 박스오피스 리스트
    var dailyBoxOfficeList: [DailyBoxOfficeList]
    
    enum CodingKeys: String, CodingKey {
        case boxOfficeType = "boxofficeType"
        case showRange = "showRange"
        case dailyBoxOfficeList = "dailyBoxOfficeList"
    }
}


struct BoxOfficeModel: Codable {
    var boxOfficeType: String
    var showRange: String
    var dailyBoxOfficeList: [DailyBoxOfficeList]
    
    init(data: BoxOfficeResult) {
        self.boxOfficeType = data.boxOfficeType
        self.showRange = data.showRange
        self.dailyBoxOfficeList = data.dailyBoxOfficeList
    }
}


/// 서버에서 내려준 일별 박스오피스 리스트
struct DailyBoxOfficeList: Codable {
    /// 순번
    var rnum: String
    /// 해당일자의 박스오피스 순위
    var rank: String
    /// 전일대비 순위의 증감분
    var rankInten: String
    /// 랭킹에 신규진입여부 (OLD: 기존, NEW: 신규)
    var rankOldAndNew: String
    /// 영화의 대표코드
    var movieCd: String
    /// 영화명(국문)
    var movieNm: String
    /// 영화의 개봉일
    var openDt: String
    /// 해당일의 매출액
    var salesAmt: String
    /// 해당일자 상영작의 매출총액 대비 해당 영화의 매출비율
    var salesShare: String
    /// 전일 대비 매출액 증감분
    var salesInten: String
    /// 전일 대비 매출액 증감 비율
    var salesChange: String
    /// 누적매출액
    var salesAcc: String
    /// 해당일의 관객수
    var audiCnt: String
    /// 전일 디배 관객수 증감분
    var audiInten: String
    /// 전일 대비 관객수 증감 비율
    var audiChange: String
    /// 누적관객수
    var audiAcc: String
    /// 해당일자에 상영한 스크린 수
    var scrnCnt: String
    /// 해당일자에 상영된 횟수
    var showCnt: String
    
//    enum CodingKeys: String, CodingKey {
//        case rnum
//        case rank
//        case rankInten
//        case rankOldAndNew
//        case movieCd
//        case movieNm
//        case openDt
//        case salesAmt
//        case salesShare
//        case salesInten
//        case salesChange
//        case salesAcc
//        case audiCnt
//        case audiInten
//        case audiChange
//        case audiAcc
//        case scrnCnt
//        case showCnt
//    }
}

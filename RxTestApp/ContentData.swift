//
//  ContentData.swift
//  RxTestApp
//
//  Created by HINOMORI HIROYA on 2018/06/21.
//  Copyright © 2018年 HINOMORI HIROYA. All rights reserved.
//

import Foundation

struct ContentData: Codable {
    let title: String
    var ncode: String
    var userid: Int
    var writer: String
    var story: String
    var bigGenre: Int
    var genre: Int
    var original: String
    var keyword: String
    var firstUpdate: Date
    var lastUpdate: Date
    var novelType: Int
    var end: Bool
    let length: Int
    let timeRequired: Int
    let stop: Bool
    let isR15: Bool
    let isBL: Bool
    let isGL: Bool
    let isBrutal: Bool
    let isRebirth: Bool
    let isTransfer: Bool
    let totalPoint: Int
    let bookmarkCount: Int
    let reviewCount: Int
    let point: Int
    let raterAmount: Int
    let imagecutCount: Int
    let conversationRate: Int
    let updateAt: Date
    
    private enum CodingKeys: String, CodingKey {
        case title
        case ncode
        case userid
        case writer
        case story
        case biggenre
        case genre
        case original = "gensaku"
        case keyword
        case firstupdate = "general_firstup"
        case lastupdate = "general_lastup"
        case noveltype = "novel_type"
        case end
        case length
        case timerequired = "time"
        case stop = "isstop"
        case r15 = "isr15"
        case bl = "isbl"
        case gl = "isgl"
        case brutal = "iszankoku"
        case rebirth = "istensei"
        case transfer = "istenni"
        case totalpoint = "global_point"
        case bookmarkcount = "fav_novel_cnt"
        case reviewcount = "review_cnt"
        case point = "all_point"
        case rateramount = "all_hyoka_cnt"
        case imagecutcount = "sasie_cnt"
        case conversationrate = "kaiwaritu"
        case updateat = "novelupdated_at"
    }
    
    init(from decoder: Decoder) throws {
        let keys = try decoder.container(keyedBy: CodingKeys.self)
        title = ContentData.convert(keys: keys, stringKey: .title)
        ncode = ContentData.convert(keys: keys, stringKey: .ncode)
        userid = ContentData.convert(keys: keys, intKey: .userid)
        writer = ContentData.convert(keys: keys, stringKey: .writer)
        story = ContentData.convert(keys: keys, stringKey: .story)
        bigGenre = ContentData.convert(keys: keys, intKey: .biggenre)
        genre = ContentData.convert(keys: keys, intKey: .genre)
        original = ContentData.convert(keys: keys, stringKey: .original)
        keyword = ContentData.convert(keys: keys, stringKey: .keyword)
        firstUpdate = ContentData.convert(keys: keys, dateKey: .firstupdate)
        lastUpdate = ContentData.convert(keys: keys, dateKey: .lastupdate)
        novelType = ContentData.convert(keys: keys, intKey: .noveltype)
        end = ContentData.convert(keys: keys, boolKey: .end)
        length = ContentData.convert(keys: keys, intKey: .length)
        timeRequired = ContentData.convert(keys: keys, intKey: .timerequired)
        stop = ContentData.convert(keys: keys, boolKey: .stop)
        isR15 = ContentData.convert(keys: keys, boolKey: .r15)
        isBL = ContentData.convert(keys: keys, boolKey: .bl)
        isGL = ContentData.convert(keys: keys, boolKey: .gl)
        isBrutal = ContentData.convert(keys: keys, boolKey: .brutal)
        isRebirth = ContentData.convert(keys: keys, boolKey: .rebirth)
        isTransfer = ContentData.convert(keys: keys, boolKey: .transfer)
        totalPoint = ContentData.convert(keys: keys, intKey: .totalpoint)
        bookmarkCount = ContentData.convert(keys: keys, intKey: .bookmarkcount)
        reviewCount = ContentData.convert(keys: keys, intKey: .reviewcount)
        point = ContentData.convert(keys: keys, intKey: .point)
        raterAmount = ContentData.convert(keys: keys, intKey: .rateramount)
        imagecutCount = ContentData.convert(keys: keys, intKey: .imagecutcount)
        conversationRate = ContentData.convert(keys: keys, intKey: .conversationrate)
        updateAt = ContentData.convert(keys: keys, dateKey: .updateat)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(title, forKey: .title)
    }
    
    private static func convert(keys: KeyedDecodingContainer<CodingKeys>, stringKey: KeyedDecodingContainer<CodingKeys>.Key) -> String {
        if let str = try? keys.decode(String.self, forKey: stringKey) {
            return str.rxapp.decodeHTMLEntities()
        }
        return ""
    }
    
    private static func convert(keys: KeyedDecodingContainer<CodingKeys>, intKey: KeyedDecodingContainer<CodingKeys>.Key) -> Int {
        if let num = try? keys.decode(Int.self, forKey: intKey) {
            return num
        }
        return 0
    }
    
    private static func convert(keys: KeyedDecodingContainer<CodingKeys>, boolKey: KeyedDecodingContainer<CodingKeys>.Key) -> Bool {
        if let flag = try? keys.decode(Int.self, forKey: boolKey) {
            return flag == 0 ? false : true
        }
        return false
    }
    
    private static func convert(keys: KeyedDecodingContainer<CodingKeys>, dateKey: KeyedDecodingContainer<CodingKeys>.Key) -> Date {
        if let str = try? keys.decode(String.self, forKey: dateKey) {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            formatter.locale = Locale(identifier: "ja_JP")
            if let date = formatter.date(from: str) {
                return date
            }
        }
        return Date.distantPast
    }
    
}

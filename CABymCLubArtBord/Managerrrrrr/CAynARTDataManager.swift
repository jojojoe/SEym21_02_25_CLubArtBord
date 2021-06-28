//
//  CAynARTDataManager.swift
//  CABymCLubArtBord
//
//  Created by JOJO on 2021/6/23.
//

import UIKit


class CAynARTDataManager {
    var borderList: [NEymEditToolItem] = []
    var bgColorList: [NEymEditToolItem] = []
    var stickerItemList: [NEymEditToolItem] = []
     
    
    
    static let `default` = CAynARTDataManager()
    
    init() {
        loadData()
    }
    
    func loadData() {
        borderList = loadJson([NEymEditToolItem].self, name: "border") ?? []
        bgColorList = loadJson([NEymEditToolItem].self, name: "bgColor") ?? []
        stickerItemList = loadJson([NEymEditToolItem].self, name: "sticker") ?? []
        
    }
    
    
}


extension CAynARTDataManager {
    func loadJson<T: Codable>(_:T.Type, name: String, type: String = "json") -> T? {
        if let path = Bundle.main.path(forResource: name, ofType: type) {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path))
                return try! JSONDecoder().decode(T.self, from: data)
            } catch let error as NSError {
                debugPrint(error)
            }
        }
        return nil
    }
    
    func loadJson<T: Codable>(_:T.Type, path:String) -> T? {
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path))
            do {
                return try PropertyListDecoder().decode(T.self, from: data)
            } catch let error as NSError {
                print(error)
            }
        } catch let error as NSError {
            print(error)
        }
        return nil
    }
    
    func loadPlist<T: Codable>(_:T.Type, name:String, type:String = "plist") -> T? {
        if let path = Bundle.main.path(forResource: name, ofType: type) {
            return loadJson(T.self, path: path)
        }
        return nil
    }
    
}



struct NEymEditToolItem: Codable, Hashable {
    static func == (lhs: NEymEditToolItem, rhs: NEymEditToolItem) -> Bool {
        return lhs.thumbName == rhs.thumbName
    }
    var thumbName: String = ""
    var bigName: String = ""
    var isPro: Bool = false
     
}

class GCPaintItem: Codable {
    let previewImageName : String
    let StrokeType : String
    let gradualColorOne : String
    let gradualColorTwo : String
    let isDashLine : Bool
    
    
}

//
//
//struct ShapeItem: Codable, Identifiable, Hashable {
//    static func == (lhs: ShapeItem, rhs: ShapeItem) -> Bool {
//        return lhs.id == rhs.id
//    }
//    var id: Int = 0
//    var thumbName: String = ""
//    var bigName: String = ""
//    var isPro: Bool = false
//
//}
//
//struct StickerItem: Codable, Identifiable, Hashable {
//    static func == (lhs: StickerItem, rhs: StickerItem) -> Bool {
//        return lhs.id == rhs.id
//    }
//    var id: Int = 0
//    var thumbName: String = ""
//    var bigName: String = ""
//    var isPro: Bool = false
//
//}
//
//struct BackgroundItem: Codable, Identifiable, Hashable {
//    static func == (lhs: BackgroundItem, rhs: BackgroundItem) -> Bool {
//        return lhs.id == rhs.id
//    }
//    var id: Int = 0
//    var thumbName: String = ""
//    var bigName: String = ""
//    var isPro: Bool = false
//
//}
//
//

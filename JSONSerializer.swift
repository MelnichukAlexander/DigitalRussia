//
//  JSONSerializer.swift
//  DigitalAdviser
//
//  Created by Александр on 28.07.2019.
//  Copyright © 2019 Alexander Melnichuk. All rights reserved.
//

import Foundation
import RealmSwift


class JSONSerializer {
    func serialize(input sourceName: String) {
        //  let urlString = "https://efbgroup.ru/airports_data.json"
        // guard let url = URL(string: urlString) else { return }
        
        var file: String = ""
        if word == "1" {
             file = "https://efbgroup.ru/database.json"
        }
        if word == "2" {
            file = "https://efbgroup.ru/database2.json"
        }
        if word == "3" {
            file = "https://efbgroup.ru/database3.json"
        }
        print(word)
        let url = URL(string: "https://efbgroup.ru/database2.json")
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if error != nil {
                print(error)
                return
            }
            let jsonDecoder = JSONDecoder()
            do {
                let data = try Data(contentsOf: url!)
                let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                guard json is [AnyObject] else {
                    assert(false, "failed to parse")
                    return
                }
                do {
                    let Airports = try jsonDecoder.decode([Airport].self, from: data)
                    
                    let realm = try! Realm()
                    
                    try! realm.write {     // стираем БД перед повторной загрузкой
                        realm.deleteAll()
                    }
                    
                    for Airport in Airports { //вносим данные в БД
                        try! realm.write {
                            realm.add(Airport)
                        }
                    }
                } catch {
                    print("failed to convert data")
                }
            } catch let error {
                print(error)
            }
            }.resume()
        
    }
    
}

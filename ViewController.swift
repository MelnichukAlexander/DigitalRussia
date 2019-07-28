//
//  ViewController.swift
//  DigitalAdviser
//
//  Created by Александр on 27.07.2019.
//  Copyright © 2019 Alexander Melnichuk. All rights reserved.
//

import UIKit
import Foundation
import RealmSwift

var word: String = ""

var tag: String = ""

let arrRelevant = Airport()



class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var requestTextView: UITextView!
    @IBOutlet weak var tagsTextView: UITextView!
    
    @IBOutlet weak var labeltest: UILabel!
    
    @IBOutlet weak var tavleView: UITableView!
    
    @IBOutlet weak var helpButton: UIButton!
    
    @IBOutlet weak var nameLabel: UITextField!
    @IBOutlet weak var sirnameLabel: UITextField!
    @IBOutlet weak var fathernameLabel: UITextField!
    @IBOutlet weak var phoneLabel: UITextField!
    @IBOutlet weak var addressLabel: UITextField!
    
    
    
    
 /*   public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellIdentificator", for: indexPath)
        cell.textLabel?.text = data[indexPath.row]
        return cell
    } */
    

    let uirealm2 = try! Realm()
    
    lazy var subjects = uirealm2.objects(Airport.self)
   
    lazy var elementscount = subjects.count
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subjects.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellIdentificator", for: indexPath)
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.text = subjects[indexPath.row].info
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        print(subjects[indexPath.row].tagmark)
    }
    
    
    
    // Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
    // Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)
    
    
    
    
    @IBAction func baseupdateButton(_ sender: UIButton) {
        let serializer = JSONSerializer()
        serializer.serialize(input: "Airports")
        
        print (Realm.Configuration.defaultConfiguration.fileURL) //вывод в консоль адреса папки с базой данных
        
        let dbalert = UIAlertController(title: "Справка", message: "База знаний обновлена", preferredStyle: .alert)
        let okbutton = UIAlertAction(title: "ОК", style: .cancel, handler: nil)
        dbalert.addAction(okbutton)
        self.present(dbalert, animated: true, completion: nil)
    
    }
    
    
    
    @IBAction func sendtosystemButton(_ sender: UIButton) {
        let rwlist = UIAlertController(title: "Подтвердите действие", message:nil, preferredStyle: .actionSheet)
        
            var rwname: String = "Подтверждаю"
            var rwItem = UIAlertAction(title: rwname, style: .default, handler: {action in
                let dbalert = UIAlertController(title: "Справка", message: "Заявка отправлена в систему учета и обработки", preferredStyle: .alert)
                let okbutton = UIAlertAction(title: "ОК", style: .cancel, handler: nil)
                dbalert.addAction(okbutton)
                self.present(dbalert, animated: true, completion: nil)
            })
            rwlist.addAction(rwItem)
       
        if let ppc = rwlist.popoverPresentationController {
            ppc.sourceView = sender
            ppc.sourceRect = sender.bounds
        }
        
        present(rwlist, animated: true, completion: nil)
    }
        
    
        
    
    
    
    @IBAction func firsttagButton(_ sender: UIButton) {
        tag = tag + "#гриб"
        tagsTextView.text = tag
    }
    
    @IBAction func secondtagButton(_ sender: UIButton) {
        tag = tag + "#животные"
        tagsTextView.text = tag
    }
    
    @IBAction func thirdtagButton(_ sender: UIButton) {
        tag = tag + "#лестницы"
        tagsTextView.text = tag
    }
    
    @IBAction func fourthtagButton(_ sender: UIButton) {
        tag = tag + "#надписи"
        tagsTextView.text = tag
    }
    
    @IBAction func fifthtagButton(_ sender: UIButton) {
        tag = tag + "#ремонтный"
        tagsTextView.text = tag
    }
    
    
    @IBAction func clearButton(_ sender: UIButton) {
        requestTextView.text = ""
        tagsTextView.text = ""
        nameLabel.text = ""
        sirnameLabel.text = ""
        fathernameLabel.text = ""
        phoneLabel.text = ""
        addressLabel.text = ""
        helpButton.isHidden = true
        
    }
    
    
    
    
    @IBAction func maketagsButton(_ sender: UIButton) {
        word = "2"
        
        var text: String = requestTextView.text
        var textArr = text.components(separatedBy: " ")
        
        
        
       
        for i in 0 ..< textArr.count {
            if textArr[i] == "грибок" || textArr[i] == "плесень" || textArr[i] == "гриб" { tag = tag + "#гриб" }
            if textArr[i] == "кошка" || textArr[i] == "собака" || textArr[i] == "животные" { tag = "#животные" }
            if textArr[i] == "продух" { tag = tag + "#продух " }
            if textArr[i] == "ступень" || textArr[i] == "лестница" || textArr[i] == "животные" { tag = tag + "#лестиницы " }
            if textArr[i] == "разрисовал" || textArr[i] == "облил" || textArr[i] == "надпись" { tag = tag + "#надписи" }
            if textArr[i] == "ремонт" || textArr[i] == "ремонтный" || textArr[i] == "работа" || textArr[i] == "шпаклевка" || textArr[i] == "краска" || textArr[i] == "плитка" { tag = tag + "#ремонтные" }
            if textArr[i] == "батарея" || textArr[i] == "труба" || textArr[i] == "отопление" { tag = tag + "#труб отопления" }
            if textArr[i] == "стояк" { tag = tag + "#стояк" }
        }
        
        tagsTextView.text = tag
        
        var arrTag = tag.components(separatedBy: "#")
       
        let uirealm = try! Realm()
        var subjects = uirealm.objects(Airport.self)
        var elementscount = subjects.count
        
        var dedicrw = Airport()
        
        var z :Int = 0
        for i in 0 ..< subjects.count {
            for j in 0 ..< arrTag.count {
                if arrTag[j] == subjects[i].tagmark {
                    arrRelevant.id = subjects[i].id
                    arrRelevant.reqtype = subjects[i].reqtype
                    arrRelevant.clarify = subjects[i].clarify
                    arrRelevant.tagmark = subjects[i].tagmark
                    arrRelevant.info = subjects[i].info
                    z = z + 1
                }
                
            }
        }
        
        if z > 0 {
            helpButton.isHidden = false
            helpButton.setTitle("Найдено результатов в базе знаний: \(Int(z))", for: .normal)
        } else {
            let dbalert = UIAlertController(title: "Справка", message: "Подходящей инфомации в базе знаний не найдено", preferredStyle: .alert)
            let okbutton = UIAlertAction(title: "ОК", style: .cancel, handler: nil)
            dbalert.addAction(okbutton)
            self.present(dbalert, animated: true, completion: nil)
        }
        
        
        print(arrRelevant)
        
       
        
   
        //subjects[1].info = "dfsfsdf"
        //tavleView.reloadData()
        
        
        
        /*
        let tagger = NSLinguisticTagger(tagSchemes: [.language, .tokenType, .lexicalClass, .lemma, .nameType], options: 0)
        let options: NSLinguisticTagger.Options = [.omitPunctuation, .omitWhitespace, .joinNames]
        
        
        
        func tokenizeText(for text: String) {
            tagger.string = text
            
            let range = NSRange(location: 0, length: text.utf16.count)
            
            tagger.enumerateTags(in: range, unit: .word, scheme: .tokenType, options: options) { (tag, tokenRange, stop) in
                let word = (text as NSString).substring(with: tokenRange)
               print(word)
            }
        }
        
        func lemmatization(for text: String) {
            tagger.string = text
            
            let range = NSRange(location: 0, length: text.utf16.count)
            
            tagger.enumerateTags(in: range, unit: .word, scheme: .lemma, options: options) { (tag, tokenType, stop) in
                if let lemma = tag?.rawValue {
                    print(lemma)
                   
                }
            }
        } */
        
        
        //  lemmatization(for: text)
        //  tokenizeText(for: text)
        
        /*      if let searchTerm = searchBar.text, let taggedSearchTerm = nlpManager.lemmatizeSingleWord(text: searchTerm).last {
         let taggedText = nlpManager.lemmatize(text: textView.text)
         let matches = taggedText.filter { $0.tag == taggedSearchTerm.tag }
         highlightMatches(taggedTokens: matches)
         } */
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
     
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


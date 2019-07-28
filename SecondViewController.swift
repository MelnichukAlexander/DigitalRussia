//
//  SecondViewController.swift
//  DigitalAdviser
//
//  Created by Александр on 28.07.2019.
//  Copyright © 2019 Alexander Melnichuk. All rights reserved.
//

import UIKit
import Foundation
import RealmSwift


class SecondViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
   
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func backTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBOutlet weak var problemtypeLabel: UILabel!
    
    @IBOutlet weak var additionalquestionsLabel: UILabel!
    
    
    var new = arrRelevant.info
    
    
    let uirealm2 = try! Realm()
    
    lazy var subjects = uirealm2.objects(Airport.self)
    
    lazy var elementscount = subjects.count
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subjects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellIdentificator", for: indexPath)
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.text = subjects[indexPath.row].info
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //tableView.deselectRow(at: indexPath, animated: true)
       problemtypeLabel.text = subjects[indexPath.row].reqtype
        additionalquestionsLabel.text = subjects[indexPath.row].clarify
        
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
    
    

 
   
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

     
        
        
        
        
    }
    
}

//
//  CopyTableViewController.swift
//  tool2
//
//  Created by 斧田洋人 on 2018/05/24.
//  Copyright © 2018年 斧田洋人. All rights reserved.
//

import UIKit
import RealmSwift

class CopyTableViewController: UITableViewController, CellDelegate {
    
    var copydata: CopyData!
    let realm = try! Realm()
    var copydataArray: Results<CopyData>!
    
    let sortProperties = [
        SortDescriptor(keyPath: "tag", ascending: false),
        SortDescriptor(keyPath: "text", ascending: true) ]
    

    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "CopyTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "copyTableViewCell")
        copydataArray = realm.objects(CopyData.self).sorted(by: sortProperties)
        print(copydataArray)
        
        let folderPath = realm.configuration.fileURL?.deletingLastPathComponent().path
        print(folderPath)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return copydataArray.count
    }
    
    @IBAction func add(_ sender: Any) {
        copydata = CopyData()
        let alert = UIAlertController(title: "テキストの追加", message: "テキスト", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "追加", style: .default, handler: {
            (action: UIAlertAction) -> Void in
            let textField = alert.textFields![0]
            if textField.text != "" {
                try! self.realm.write {
                    self.copydata.text = textField.text!
                    self.copydata.tag = 0
                    self.realm.add(self.copydata)
                }
                self.updateData()
                
            }
        })
        let cancellAction = UIAlertAction(title: "cancel", style: .cancel, handler: nil)
        alert.addTextField(configurationHandler: nil)
        alert.addAction(okAction)
        alert.addAction(cancellAction)
        present(alert, animated: false, completion: nil)
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         copydataArray = realm.objects(CopyData.self).sorted(by: sortProperties)
        let cell = tableView.dequeueReusableCell(withIdentifier: "copyTableViewCell", for: indexPath) as! CopyTableViewCell
        cell.copyLabel.text = copydataArray[indexPath.row].text
        cell.delegate = self
        // Configure the cell...

        return cell
    }
    
    func copy(_ cell: CopyTableViewCell) {
        let board = UIPasteboard.general
        board.setValue(copydataArray[(tableView.indexPath(for: cell)?.row)!].text, forPasteboardType: "public.text")
        board.string = copydataArray[(tableView.indexPath(for: cell)?.row)!].text
        let alert = UIAlertController(title: "完了", message: "コピーしました", preferredStyle: .alert)
        present(alert, animated: false, completion: {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                    alert.dismiss(animated: true, completion: nil)
                })
        })
    }
    
    func clip(_ cell: CopyTableViewCell) {
        print(cell.copyLabel.text)
        try! realm.write {
            copydataArray[(tableView.indexPath(for: cell)?.row)!].tag = 1
        }
        updateData()
    }
    
    func updateData(){
        copydataArray.sorted {(A,B) -> Bool in
            if A.tag <= B.tag {
                return true
            }else{
            return false
            }
        }
        tableView.reloadData()
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

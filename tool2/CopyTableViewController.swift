//
//  CopyTableViewController.swift
//  tool2
//
//  Created by 斧田洋人 on 2018/05/24.
//  Copyright © 2018年 斧田洋人. All rights reserved.
//

import UIKit

class CopyTableViewController: UITableViewController, CellDelegate {
    
    var texts: [String] = []
    var alldata = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "CopyTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "copyTableViewCell")
        if let data = alldata.object(forKey: "texts") {
            texts = alldata.object(forKey: "texts") as! [String]
        }
            
        

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
        return texts.count
    }
    
    @IBAction func add(_ sender: Any) {
        let alert = UIAlertController(title: "テキストの追加", message: "テキスト", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "追加", style: .default, handler: {
            (action: UIAlertAction) -> Void in
            let textField = alert.textFields![0]
            if textField.text != "" {
                self.texts.append(textField.text!)
                self.tableView.reloadData()
                print(self.texts)
                self.alldata.set(self.texts, forKey: "texts")
                
            }
        })
        let cancellAction = UIAlertAction(title: "cancel", style: .cancel, handler: nil)
        alert.addTextField(configurationHandler: nil)
        alert.addAction(okAction)
        alert.addAction(cancellAction)
        present(alert, animated: false, completion: nil)
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "copyTableViewCell", for: indexPath) as! CopyTableViewCell
        cell.copyLabel.text = texts[indexPath.row]
        cell.delegate = self
        // Configure the cell...

        return cell
    }
    
    
    
    func copy(_ cell: CopyTableViewCell) {
        print("a")
        let board = UIPasteboard.general
        board.setValue(texts[(tableView.indexPath(for: cell)?.row)!], forPasteboardType: "public.text")
        board.string = texts[(tableView.indexPath(for: cell)?.row)!]
        let alert = UIAlertController(title: "完了", message: "コピーしました", preferredStyle: .alert)
        present(alert, animated: false, completion: {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                    alert.dismiss(animated: true, completion: nil)
                })
        })
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

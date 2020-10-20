//
//  ViewController.swift
//  noteApp
//
//  Created by Aman Jaiswal on 19/10/20.
//

import UIKit

//MARK: - Protocols.
protocol DataDelegate {
    func updateArray(newArray: String)
}

//MARK: - ViewController.
class ViewController: UIViewController {
    
    var notesArray = [Note]()
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! addNoteViewController
        
        if segue.identifier == "updateNoteSegue" {
            vc.note = notesArray[noteTableView.indexPathForSelectedRow!.row]
            vc.update = true
        }
    }
    
    //Creating IBOutlets.
    @IBOutlet weak var noteTableView: UITableView!
    
    //    MARK: - LifeCycle.
    
    override func viewWillAppear(_ animated: Bool) {
        //        Updates the notes array.
        APIFunctions.functions.fetchNote()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        APIFunctions.functions.fetchNote()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        APIFunctions.functions.delegate = self
        APIFunctions.functions.fetchNote()
        //        print(notesArray)
        
        noteTableView.delegate = self
        noteTableView.dataSource = self
    }
}

//MARK: - Extensions.

//Extension for UITableViewDelegate, UITableViewDataSource.

extension ViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! customPrototypeTableViewCell
        
        cell.title.text = notesArray[indexPath.row].title
        cell.note.text = notesArray[indexPath.row].note
        cell.date.text = notesArray[indexPath.row].date
        return cell
    }
}

//Extension for DataDelegate.
extension ViewController: DataDelegate {
    func updateArray(newArray: String) {
        do{
            notesArray = try JSONDecoder().decode([Note].self, from: newArray.data(using: .utf8)!)
            print(notesArray)
        } catch{
            
            print("Unable to fetch data from the API.")
        }
        self.noteTableView.reloadData()
    }
}

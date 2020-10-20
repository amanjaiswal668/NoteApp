//
//  helpers.swift
//  noteApp
//
//  Created by Aman Jaiswal on 19/10/20.
//

import UIKit
import Alamofire

//MARK: - Creating structure for the data to be fetched from the API.

struct Note: Decodable {
    
    var title: String
    var date: String
    var _id: String
    var note: String
}

//MARK: - Creating class for fetching Data from the API.

class APIFunctions {
    
    var delegate: DataDelegate?
    static let functions = APIFunctions()
    
    //    Function for fetching Note.
    func fetchNote() {
        AF.request("http://Add custom address here/fetch").response{ response in
            
            print(response.data!)
            let data = String(data: response.data!, encoding: .utf8)
            self.delegate?.updateArray(newArray: data!)
        }
    }
    
    //    Function for adding Note.
    func addNote(date: String, title: String, note: String) {
        AF.request("http://Add custom address here/create", method: .post, encoding: URLEncoding.httpBody, headers: ["title": title, "date": date, "note": note]).responseJSON { response in
            
            print(response)
        }
    }
    
    //    Function for updating Note.
    func updateNote(date: String, title: String, note: String, id: String){
        
        AF.request("http://Add custom address here/update", method: .post, encoding: URLEncoding.httpBody, headers: ["title": title, "date": date, "note": note, "id": id]).responseJSON{ response in
            
            print(response)
        }
        
    }
    
    //    Function for deleting Note.
    func deleteNote(id: String){
        
        AF.request("http://Add custom address here/delete", method: .post, encoding: URLEncoding.httpBody, headers: [ "id": id]).responseJSON{ response in
            
            print(response)
        }
    }
}

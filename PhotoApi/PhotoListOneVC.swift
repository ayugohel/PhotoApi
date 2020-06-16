//
//  ViewController.swift
//  GasBuddy PhotoApp
//
//  Created by Ayushi on 2020-06-12.
//  Copyright © 2020 Ayushi. All rights reserved.
//

import UIKit

// First API Screen

// MARK: - Class UITableViewCell -------

class TblPhotoCell: UITableViewCell {
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var photo: UIImageView!
    
}

class PhotoListOneVC: UIViewController  {
    
    // MARK: - Outlets -------
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableviewPhotos: UITableView!
    
    
    // MARK: - Variables -------
    
    var arrPhotos : [[String : Any]] = [[:]]
    var arrTEMP : [[String : Any]] = [[:]]
    
    let apiTYPE = ApiType.apiFirst
    
    // MARK: - Functios -------
    
    fileprivate func setupView() {
        
        self.navigationController?.navigationBar.barTintColor = .white
        self.apiPIXABAY()
        
    }
    
    
    // MARK: - API Functions -------
    
    /** API Function for PixaBay Photos  */

    private func apiPIXABAY() {
        
        let url = "https://pixabay.com/api/?key="+API_KEY+"&image_type=photo&per_page=100"
        
        var request = URLRequest(url: URL(string: url )!)

        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
            print(response ?? "")
            
            if error == nil && data != nil {
                
                do {
                    
                    let json = try JSONSerialization.jsonObject(with: data!) as! [String: Any]
                    print(json)
                    
                    self.arrPhotos = json["hits"] as! [[String:Any]]
                    self.arrTEMP = self.arrPhotos
                    
                    DispatchQueue.main.async {
                        self.tableviewPhotos.reloadData()
                    }
                    
                } catch {
                    print("error")
                }
            }
        })
        task.resume()
    }
    
    
    // MARK: - Actions -------
    
    
    
    
    
    // MARK: - View life cycle Method -------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.setupView()
    }
    
}

extension PhotoListOneVC: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    
        if searchText.isEmpty {
            self.arrPhotos = arrTEMP
        } else {
            self.arrPhotos = self.arrTEMP.filter{ ($0["tags"] as! String).lowercased().range(of: searchBar.text!.lowercased()) != nil }
        }
        
        self.tableviewPhotos.reloadData()
        
    }
}


// MARK: - UICollectionViewDataSource protocol -------

extension PhotoListOneVC: UITableViewDataSource, UITableViewDelegate {
    
    // tell the collection view how many cells to make
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrPhotos.count
    }
    
    // make a cell for each cell index path
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TblPhotoCell") as! TblPhotoCell
        
        cell.photo.layer.cornerRadius = 10
        
        if let url = self.arrPhotos[indexPath.row]["previewURL"] as? String {
            cell.photo.sd_setImage(with: URL(string: url), placeholderImage: UIImage(named: "placeholder.jpg"))
        }
        
        if let tags = self.arrPhotos[indexPath.row]["tags"] as? String {
            cell.lblName.text = tags
        }
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = StoryBoard.instantiateViewController(identifier: "PhotoDetailVC") as! PhotoDetailVC
        vc.dictDetail = self.arrPhotos[indexPath.row]
        vc.apiTYPE = self.apiTYPE
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

//
//  PhotoListVC.swift
//  GasBuddy PhotoApp
//
//  Created by Ayushi on 2020-06-12.
//  Copyright © 2020 Ayushi. All rights reserved.
//

import UIKit
//import SDWebImage

class PhotoListTwoVC: UIViewController {
    
    
    // MARK: - Outlets -------
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collPhotos: UICollectionView!
    
    // MARK: - Variables -------
    
    var arrPhotos : [[String : Any]] = [[:]]
    
    let apiTYPE = ApiType.apiSecond

    
    // MARK: - Functios -------

    
    fileprivate func setupView() {
        
        self.navigationController?.navigationBar.barTintColor = .white
        self.apiImgur()
        
    }
    
    
    // MARK: - API Functions -------
    
    private func apiImgur() {
        
        
//        "https://api.imgur.com/3/gallery/hot/viral"
        
        let url = "https://api.unsplash.com/photos/?client_id="+unsplashAccessKey
            
//            "https://api.unsplash.com/search/photos/?client_id="+unsplashAccessKey+"&order_by=latest&query=yellow&color=orange"
//
        
        
//        let params = ["color" : "orange", "order_by" : "latest" ] as [String:Any]
        var request = URLRequest(url: URL(string: url )!)
        
        request.httpMethod = "GET"
//        request.setValue("Client-ID \(imgurClientId)", forHTTPHeaderField: "Authorization")
//        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//        request.httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
            print(response ?? "")
            
            if error == nil && data != nil {
                
                do {
                    
                    if let json = try JSONSerialization.jsonObject(with: data!) as? [[String : Any]] {
                        print(json)
                        
                        self.arrPhotos = json
                                            
                        DispatchQueue.main.async {
                            self.collPhotos.reloadData()
                        }
                        
                    } else { return }
                    
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


// MARK: - Class UICollectionViewCell -------

class collPhotoCell: UICollectionViewCell {
    @IBOutlet weak var photo: UIImageView!
}

// MARK: - UICollectionViewDataSource protocol -------

extension PhotoListTwoVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    // tell the collection view how many cells to make
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.arrPhotos.count
    }
    
    // make a cell for each cell index path
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // get a reference to our storyboard cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collPhotoCell", for: indexPath as IndexPath) as! collPhotoCell
        
        cell.photo.layer.cornerRadius = 7
        
        if let arrURL = self.arrPhotos[indexPath.row]["urls"] as? [String:Any] {
            if let url = arrURL["small"] as? String {
                cell.photo.sd_setImage(with: URL(string: url), placeholderImage: UIImage(named: "placeholder.jpg"))
            }
        }

        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = StoryBoard.instantiateViewController(identifier: "PhotoDetailVC") as! PhotoDetailVC
        vc.dictDetail = self.arrPhotos[indexPath.row]
        vc.apiTYPE = self.apiTYPE
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collPhotos.frame.width / 4 , height: 100)
    }
    
}

//
//  PhotoDetailVC.swift
//  GasBuddy PhotoApp
//
//  Created by Ayushi on 2020-06-12.
//  Copyright © 2020 Ayushi. All rights reserved.
//

import UIKit

class PhotoDetailVC: UIViewController {
    
    // MARK: - Outlets -------

    @IBOutlet weak var photo: UIImageView!
    
    @IBOutlet weak var lblPhotographer: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblLocation: UILabel!
    @IBOutlet weak var lblLikes: UILabel!
    @IBOutlet weak var lblFilter: UILabel!

    @IBOutlet weak var lblOne: UILabel!
    @IBOutlet weak var lblTwo: UILabel!
    @IBOutlet weak var lblThree: UILabel!
    @IBOutlet weak var lblFour: UILabel!
    @IBOutlet weak var lblFive: UILabel!

    
    
    // MARK: - Variables -------
    
    
    var dictDetail : [String : Any] = [:]

    var apiTYPE = ApiType.apiFirst

    
    // MARK: - Functios -------
    
    
    private func setupView() {
        
        switch apiTYPE {
            
        case .apiFirst:
            self.setUpPixaBayApiData()
            break
            
        default:
            self.apiUnsplashPhotoDetail()
            break
        }

        self.photo.layer.cornerRadius = 10

    }
    
    /**  Setup PixaBay API data  */
    private func setUpPixaBayApiData() {
        
        if let user = self.dictDetail["user"] as? String {
            self.lblPhotographer.text = user
        }
        
        self.lblTwo.text = "Tags"
        if let tags = self.dictDetail["tags"] as? String {
            self.lblDate.text = tags
        }
        
        self.lblThree.text = "Views"
        if let views = self.dictDetail["views"] {
            self.lblLocation.text = String(describing: views)
        }
        
        if let likes = self.dictDetail["likes"] {
            self.lblLikes.text = String(describing: likes)
        }
        
        self.lblFive.text = "Downloads"
        if let downloads = self.dictDetail["downloads"] {
            self.lblFilter.text = String(describing: downloads)
        }
        
        if let url = self.dictDetail["largeImageURL"] as? String {
            photo.sd_setImage(with: URL(string: url), placeholderImage: UIImage(named: "placeholder.jpg"))
        }
        
    }
    
    /**  Setup Unsplash  API data    */
    
    func setUPPhotoData() {
        
        if let userData = self.dictDetail["user"] as? [String:Any] {
        if let user = userData["name"] as? String {
                self.lblPhotographer.text = user
            }
        }
        
        self.lblTwo.text = "Description"
        
        if let desc = self.dictDetail["description"] as? String {
            self.lblDate.text = desc
        } else {
            self.lblDate.text = "Not Specified"
        }
                                
        if let location = self.dictDetail["user"] as? [String:Any] {
            if let city = location["location"] as? String {
                self.lblLocation.text = city
            } else {
                self.lblDate.text = "Not Specified"
            }
        }
        
        if let likes = self.dictDetail["likes"] {
            self.lblLikes.text = String(describing: likes)
        }
        
        self.lblFive.text = "Downloads"
        if let downloads = self.dictDetail["downloads"] {
            self.lblFilter.text = String(describing: downloads)
        }
        
        if let arrURL = self.dictDetail["urls"] as? [String:Any] {
            if let url = arrURL["regular"] as? String {
                self.photo.sd_setImage(with: URL(string: url), placeholderImage: UIImage(named: "placeholder.jpg"))
            }
        }
    }

    /**  Photo Detail Unsplash  API    */

    private func apiUnsplashPhotoDetail() {
        
        var ID : String = ""
        
        if let id = self.dictDetail["id"] as? String {
            ID = id
        }

        let url = "https://api.unsplash.com/photos/"+ID+"?client_id="+unsplashAccessKey

        var request = URLRequest(url: URL(string: url )!)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let session = URLSession.shared

        let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
            print(response ?? "")

            if error == nil && data != nil {

                do {

                    if let json = try JSONSerialization.jsonObject(with: data!) as? [String : Any] {
                        print(json)

                        self.dictDetail = json
                        
                        DispatchQueue.main.async {
                            self.setUPPhotoData()
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
    
    @IBAction func btnBackTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
    // MARK: - View life cycle Method -------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.setupView()
    }
    
}


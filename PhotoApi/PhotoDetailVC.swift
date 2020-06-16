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
            
            self.lblOne.text = "Photographer"
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
        
            
            self.lblFive.text = "Downloads"
            if let downloads = self.dictDetail["downloads"] as? String {
                self.lblFilter.text = String(describing: downloads)
            }
            
            if let url = self.dictDetail["largeImageURL"] as? String {
                photo.sd_setImage(with: URL(string: url), placeholderImage: UIImage(named: "placeholder.jpg"))
            }
            
            break
            
        default:
            
            self.lblOne.text = "Photographer"
            if let userData = self.dictDetail["user"] as? [String:Any] {
                if let user = userData["username"] as? String {
                    self.lblPhotographer.text = user
                }
            }
            
            self.lblTwo.text = "TagLine"
            if let userData = self.dictDetail["sponsorship"] as? [String:Any] {
                if let user = userData["tagline"] as? String {
                    self.lblDate.text = user
                }
            } else {
                self.lblDate.text = "Not Specified"
            }
            
//            self.lblThree.text = "Views"
//            if let views = self.dictDetail["views"] {
//                self.lblLocation.text = String(describing: views)
//            }
            
//            self.lblFive.text = "Downloads"
//            if let downloads = self.dictDetail["downloads"] as? String {
//                self.lblFilter.text = String(describing: downloads)
//            }
            
            
            if let arrURL = self.dictDetail["urls"] as? [String:Any] {
                if let url = arrURL["full"] as? String {
                    self.photo.sd_setImage(with: URL(string: url), placeholderImage: UIImage(named: "placeholder.jpg"))
                }
            }
            
            break
        }

        self.photo.layer.cornerRadius = 10
        
        self.lblFour.text = "Likes"
        if let likes = self.dictDetail["likes"] {
            self.lblLikes.text = String(describing: likes)
        }
  
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


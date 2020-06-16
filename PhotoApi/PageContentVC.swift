//
//  PageContentVC.swift
//  GasBuddy PhotoApp
//
//  Created by Ayushi on 2020-06-13.
//  Copyright © 2020 Ayushi. All rights reserved.
//

import UIKit
@_exported import SDWebImage

// Main Home Screen

// MARK: - Class UICollectionViewCell -------

class ItemCell: UICollectionViewCell {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var imgSaprator: UIImageView!

}

class PageContentVC: UIViewController {
    
    // MARK: - Outlets -------

    @IBOutlet weak var collItems: UICollectionView!
    @IBOutlet weak var viewContent: UIView!
    

    // MARK: - Variables -------

    var line : CALayer?
    var arrTitle : [ApiType] = ApiType.allCases
    var selectedIndex : Int = 0
    var identifiers : [UIViewController] = []
    private var pageViewController: UIPageViewController?
    
    lazy var firstView : PhotoListOneVC = {
        return StoryBoard.instantiateViewController(identifier: "PhotoListOneVC") as! PhotoListOneVC
    }()
    
    lazy var secondView : PhotoListTwoVC = {
        return StoryBoard.instantiateViewController(identifier: "PhotoListTwoVC") as! PhotoListTwoVC
    }()
    

    // MARK: - Functios -------

    private func setUPView() {
        
        self.identifiers = [firstView, secondView]
        
        self.navigationController?.navigationBar.barTintColor = .white

        self.pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)

        self.pageViewController?.dataSource = self
        self.pageViewController?.delegate = self

        addChild(pageViewController!)
        self.viewContent.addSubview(pageViewController!.view)

        DispatchQueue.main.async {
            self.pageViewController!.view.frame = self.viewContent.bounds
            self.pageViewController!.didMove(toParent: self)
        }

        self.pageViewController?.setViewControllers([identifiers[selectedIndex]], direction: .forward, animated: true, completion: nil)
        
    }

    private func reloadCollectionView(_ index : Int) {
        print("INDEX :" , index)
        self.selectedIndex = index
        self.collItems.reloadData()
    }
    
    
    // MARK: - Actions -------

    
    
    

    // MARK: - View life cycle Method -------

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        self.setUPView()
        
    }


}

// MARK: - UIPageViewControllerDataSource, UIPageViewControllerDelegate  protocol -------

extension PageContentVC: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        
        guard completed, let viewControllerIndex = identifiers.firstIndex(of: pageViewController.viewControllers!.first!) else {
                return
        }
        
        print(viewControllerIndex)
        self.reloadCollectionView(viewControllerIndex)

    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let viewControllerIndex = identifiers.firstIndex(of: viewController) else { return nil }
        
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0 else { return nil }
        
        guard identifiers.count > previousIndex else { return nil }
        
        return identifiers[previousIndex]

    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {

        guard let viewControllerIndex = identifiers.firstIndex(of: viewController) else { return nil }
        
        let nextIndex = viewControllerIndex + 1
        let orderedViewControllersCount = identifiers.count
        
        guard orderedViewControllersCount != nextIndex else { return nil }
        
        guard orderedViewControllersCount > nextIndex else { return nil }
        
        return identifiers[nextIndex]

    }

}

// MARK: - UICollectionViewDataSource protocol -------

extension PageContentVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    // tell the collection view how many cells to make
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrTitle.count
    }
    
    // make a cell for each cell index path
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemCell", for: indexPath as IndexPath) as! ItemCell
        
        cell.lblTitle.text = arrTitle[indexPath.row].rawValue
        
        cell.lblTitle.textColor = selectedIndex == indexPath.row ? UIColor("#F05341") : .gray
        cell.imgSaprator.backgroundColor = selectedIndex == indexPath.row ? UIColor("#F05341") : .clear

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        self.pageViewController?.setViewControllers([identifiers[indexPath.item]], direction: selectedIndex < indexPath.row ? .forward : .reverse, animated: true, completion: nil)
        
        self.reloadCollectionView(indexPath.row)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collItems.frame.width / 2 , height: collItems.frame.height)
    }
}






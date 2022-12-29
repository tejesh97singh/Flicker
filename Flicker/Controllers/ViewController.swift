//
//  ViewController.swift
//  Flickr
//
//  Created by Himanshu Lahoti on 12/06/22.
//

import UIKit
import SDWebImage

class ViewController: UIViewController {
    
    @IBOutlet weak var searchbar: UISearchBar!
    @IBOutlet weak var FlickerLabel: UILabel!
    @IBOutlet weak var displayCollection: UICollectionView!
    private var noOfCols : Float = 3.0
    private var service = GetImageList()
    var searchedPhotos = [Photo]()
    
    @IBOutlet weak var messageLabel: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        FlickerLabel.lineBreakMode = .byWordWrapping
        searchbar.delegate = self
        service.delegate = self
        messageLabel.isHidden=false
        searchbar.showsCancelButton = false
    }
    
    
    @IBAction func searchClicked(_ sender: Any) {
       // print("search clicked")
        guard let text = searchbar.text, text.count > 1 else {
            return
        }
        messageLabel.isHidden =  true
        searchedPhotos.removeAll()
        
        service.getImage(imageName: searchbar.text!)
    }
    
  
}

extension ViewController: PhotoList{
    func didGetImages(imageUrl: [Photo]){
        searchedPhotos.append(contentsOf: imageUrl)
        DispatchQueue.main.async {
            self.displayCollection.reloadData()
        }
    }
}

extension ViewController : UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(searchedPhotos.count)
        return searchedPhotos.count
       
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = displayCollection.dequeueReusableCell(withReuseIdentifier: "FlickerCell", for: indexPath) as! FlickerCollectionViewCell
        let ShowFetchedImage = searchedPhotos[indexPath.row].imageURL
        cell.imageView.sd_setImage(with:URL(string: ShowFetchedImage))
       return cell
        
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = collectionView.frame.width
        if (size > 500) {
            return CGSize(width: (collectionView.bounds.width)/CGFloat(noOfCols+2), height: (collectionView.bounds.width)/CGFloat(noOfCols+2))
        }
        return CGSize(width: (collectionView.bounds.width)/CGFloat(noOfCols+1), height: (collectionView.bounds.width)/CGFloat(noOfCols+1))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

extension ViewController: UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchedPhotos.removeAll()
        //displayCollection.isHidden = true
       searchbar.endEditing(true)
        searchbar.text = nil
        displayCollection.reloadData()
        messageLabel.isHidden = false
        searchbar.showsCancelButton =  false
    }
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
        
    }
    
}




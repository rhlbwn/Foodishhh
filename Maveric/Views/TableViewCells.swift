//
//  TableViewCells.swift
//  Maveric
//
//  Created by Rahul Bawane on 11/05/21.
//

import UIKit

//MARK: Image CollectionViewCell
class ImageViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!

    override func awakeFromNib() {
        self.imageView.contentMode = .scaleAspectFit
    }
}

//MARK: Images Collection TableViewCell
class ImagesCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    //MARK: IBOutlets
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    //MARK: Properties
    let images = ["1", "2", "3", "4"]
    var timer = Timer()
    var counter = 0
    
    //MARK: View LifeCycle
    override func awakeFromNib() {
        collectionView.delegate = self
        collectionView.dataSource = self
        pageControl.numberOfPages = images.count
        pageControl.currentPage = 0
        DispatchQueue.main.async {
            self.timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(self.changeImage), userInfo: nil, repeats: true)
        }
    }
    
    //MARK: Custom functions
    @objc func changeImage() {
        if counter < images.count {
            let indexPath = IndexPath.init(item: counter, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            counter += 1
        } else {
            counter = 0
            let indexPath = IndexPath.init(item: counter, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: false)
            counter = 1
        }
    }
    
    //MARK: Delegate & DataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageViewCell", for: indexPath) as! ImageViewCell
        cell.imageView.image = UIImage(named: images[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        self.pageControl.currentPage = indexPath.item
    }
    
    //MARK: FlowLayout Delegate
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
}

//MARK: Data TableViewCell
class DataCell: UITableViewCell {
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var itemLabel: UILabel!

    override func awakeFromNib() {
        
    }
}

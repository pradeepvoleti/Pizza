//
//  ViewController.swift
//  Pizza
//
//  Created by Ram Voleti on 20/01/21.
//

import UIKit
import SDWebImage

class ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    let viewModel: ViewModel = ViewModel()
    let indicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        indicator.center = view.center
        view.addSubview(indicator)
        setupBinding()
        viewModel.populate()
    }

    func setupBinding() {
        viewModel.showLoader.bind { [weak self] show in
            if show {
                self?.indicator.startAnimating()
            } else {
                self?.indicator.stopAnimating()
            }
        }
        
        viewModel.showError.bind { [weak self] error in
            let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
            self?.present(alert, animated: true, completion: nil)
        }
        
        viewModel.reload.bind { [weak self] _ in
            self?.collectionView.reloadData()
        }
    }
}

extension ViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1//viewModel.noOfSections
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "bannerCell", for: indexPath) as? BannerCollectionViewCell else { return BannerCollectionViewCell()}
            let urlString = viewModel.bannerInfo(at: indexPath.item)
            let url = URL(string: urlString)
            cell.image.sd_setImage(with: url, completed: nil)
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "mainCell", for: indexPath) as? PizzaCollectionViewCell else { return PizzaCollectionViewCell()}
            
            return cell
        }
    }
}

extension ViewController: UICollectionViewDelegate {
    
}

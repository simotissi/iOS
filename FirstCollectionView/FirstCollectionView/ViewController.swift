//
//  ViewController.swift
//  FirstCollectionView
//
//  Created by Simone Tissi on 23/03/2020.
//  Copyright © 2020 Simone Tissi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  enum Section {
    case main
  }
  @IBOutlet weak var collectionView: UICollectionView!
  // Define a datasource (dataSource) that speifies Section as the type that maps to the sections in the data and Int as the item type
  var dataSource: UICollectionViewDiffableDataSource<Section, Int>!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    collectionView.collectionViewLayout = configureLayout()
    configureDataSource()
  }

  func configureLayout() -> UICollectionViewCompositionalLayout{
    let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.2), heightDimension: .fractionalHeight(1.0))
    let item = NSCollectionLayoutItem(layoutSize: itemSize)
    item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
    
    let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(0.2))
    let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
    
    let section = NSCollectionLayoutSection(group: group)
    return UICollectionViewCompositionalLayout(section: section)
  }
  
  func configureDataSource(){
    dataSource = UICollectionViewDiffableDataSource<Section, Int> (collectionView: self.collectionView) {
      (collectionView, indexPath, number) -> UICollectionViewCell? in
      
      guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NumberCell.reuseId, for: indexPath) as? NumberCell else{
        fatalError("Cannot create new cell")
      }
      
      cell.label.text = number.description
      
      return cell
    }
  
    var initialSnapshot = NSDiffableDataSourceSnapshot<Section, Int>()
    initialSnapshot.appendSections([.main])
    initialSnapshot.appendItems(Array(1...100), toSection: .main)
    
    dataSource.apply(initialSnapshot, animatingDifferences: false)
  }

}


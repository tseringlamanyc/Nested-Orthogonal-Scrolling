//
//  ViewController.swift
//  Nested-Orthogonal-Scrolling
//
//  Created by Tsering Lama on 11/24/20.
//

import UIKit

class ViewController: UIViewController {
    
    enum SectionKind: Int, CaseIterable {
        case first
        case second
        case third
        
        // computed property :- will return the # of items to vertically stack
        var intCount: Int {
            switch self {  // SectionKind
            case .first:
                return 2
            default:
                return 1
            }
        }
    }
    
    private var collectionView: UICollectionView!
    
    typealias DataSource = UICollectionViewDiffableDataSource<SectionKind, Int>
    private var dataSource: DataSource!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func createLayout() -> UICollectionViewLayout {
        // item -> group -> section -> layout
        
        // given section
        // section provider (closer) :- gets called for each section
        
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            
            // item
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            // group
            let innerGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.50), heightDimension: .fractionalHeight(1.0))
            let innerGroup = NSCollectionLayoutGroup.vertical(layoutSize: innerGroupSize, subitem: item, count: 2)
            
            // section
        }
        return layout
    }


}


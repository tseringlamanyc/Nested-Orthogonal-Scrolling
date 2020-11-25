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
        var itemCount: Int {
            switch self {  // SectionKind
            case .first:
                return 2
            default:
                return 1
            }
        }
        
        // nested group height
        var nestedGroupHeight: NSCollectionLayoutDimension {
            switch self {
            case .first:
                return .fractionalWidth(1.0)  // same width and same height
            default:
                return .fractionalWidth(0.5)
            }
        }
    }
    
    private var collectionView: UICollectionView!
    
    typealias DataSource = UICollectionViewDiffableDataSource<SectionKind, Int>
    private var dataSource: DataSource!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        configureDataSource()
    }
    
    private func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
        collectionView.backgroundColor = .systemBackground
        collectionView.register(LabelCell.self, forCellWithReuseIdentifier: LabelCell.reuseIdentifier)
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(collectionView)
    }
    
    private func createLayout() -> UICollectionViewLayout {
        // item -> group -> section -> layout
        
        // given section
        // section provider (closer) :- gets called for each section
        
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            
            // figure out what section we are dealing with
            guard let sectionKind = SectionKind(rawValue: sectionIndex) else {
                fatalError()
            }
            
            // item
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            // group
            let innerGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.50), heightDimension: .fractionalHeight(1.0))
            let innerGroup = NSCollectionLayoutGroup.vertical(layoutSize: innerGroupSize, subitem: item, count: sectionKind.itemCount) // 1,2
            
            let nestedGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: sectionKind.nestedGroupHeight)
            let nestedGroup = NSCollectionLayoutGroup.horizontal(layoutSize: nestedGroupSize, subitems: [innerGroup])
            
            // section
            let section = NSCollectionLayoutSection(group: nestedGroup)
            
            return section
        }
        return layout
    }

    private func configureDataSource() {
        dataSource = DataSource(collectionView: collectionView, cellProvider: { (collectionView, indexPath, item) -> UICollectionViewCell? in
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LabelCell.reuseIdentifier, for: indexPath) as? LabelCell else {
                fatalError()
            }
            
            cell.textLabel.text = "\(item)"
            cell.backgroundColor = .systemRed
            cell.layer.cornerRadius = 10
            return cell
        })
        
        // initial snapshot
        var snapshot = NSDiffableDataSourceSnapshot<SectionKind, Int>()
        
        snapshot.appendSections([.first, .second, .third])
        
        // populate 3 sections
        snapshot.appendItems(Array(1...20), toSection: .first)
        snapshot.appendItems(Array(21...40), toSection: .second)
        snapshot.appendItems(Array(41...60), toSection: .third)
        
        dataSource.apply(snapshot, animatingDifferences: false)
    }

}


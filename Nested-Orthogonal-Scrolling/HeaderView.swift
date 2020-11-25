//
//  HeaderView.swift
//  Nested-Orthogonal-Scrolling
//
//  Created by Tsering Lama on 11/24/20.
//

import UIKit

class HeaderView: UICollectionReusableView {
    
    static let reuseIdentifier = "headerView"
      
      public lazy var textLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        return label
      }()
      
      override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
      }
      
      required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
      }
      
      private func commonInit() {
        setupLabelConstraints()
      }
      
      private func setupLabelConstraints() {
        addSubview(textLabel)
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
          textLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
          textLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
          textLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
          textLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8)
        ])
      }
        
}

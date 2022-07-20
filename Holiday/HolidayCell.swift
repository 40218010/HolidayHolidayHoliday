//
//  HolidayCell.swift
//  Holiday
//
//  Created by 林大屍 on 2022/5/31.
//

import UIKit
import SnapKit

class HolidayCell: UITableViewCell {
    
    static let identifier = "holidayCell"
    
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Title"
//        label.backgroundColor = .blue
        return label
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Description"
        label.textColor = .gray
//        label.backgroundColor = .cyan
        return label
    }()
    
    let rightButton: UIButton = {
        let button = UIButton()
        let config1 = UIImage.SymbolConfiguration(hierarchicalColor: .systemMint)
//        let config2 = UIImage.SymbolConfiguration(pointSize: 50, weight: .semibold, scale: .small)
        let image = UIImage(systemName: "airplane.circle", withConfiguration: config1)
//        let image = UIImage(systemName: "airplane.circle")
        button.setBackgroundImage(UIImage.systemImage(name: "airplane.circle"), for: .normal)
        button.contentHorizontalAlignment = .trailing
        return button
    }()
    
    
    
//    lazy var textTwoLabel: UILabel = {
//        let label = UILabel()
//        label.text = Array(repeating: "RRRR.", count: 100).joined(separator: ", ")
//        label.numberOfLines = 0
//        label.textColor = .gray
//        label.backgroundColor = .magenta
//        return label
//    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
//        contentView.backgroundColor = .orange
        
        setUpView()

        
    }
    
    func setUpView() {
        
        let mainVStack = UIStackView(arrangedSubviews: [titleLabel, descriptionLabel])
        mainVStack.axis = .vertical
        contentView.addSubview(mainVStack)
        
        let hStack = UIStackView(arrangedSubviews: [mainVStack, rightButton])
        contentView.addSubview(hStack)
        rightButton.snp.makeConstraints { make in
            make.width.height.equalTo(60)
        }
        
        hStack.snp.makeConstraints { make in
            
//same result
            
//3
//            make.top.equalTo(8)
//            make.bottom.equalTo(-8)
//            make.leading.equalTo(16)
//            make.trailing.equalTo(-16)
            
            make.top.equalTo(8)
            make.leading.equalTo(16)
//            make.center.equalToSuperview()
            make.centerX.centerY.equalToSuperview()
            
//1
//            make.edges.equalTo(UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16))
        }
        

        
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}

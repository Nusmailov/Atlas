//
//  CardTableViewCell.swift
//  Delivery
//
//  Created by Nurzhigit Smailov on 8/26/19.
//  Copyright © 2019 Nurzhigit Smailov. All rights reserved.
//

import UIKit

class CardTableViewCell: UITableViewCell {
    lazy var mainView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.layer.borderColor = #colorLiteral(red: 0.9490196078, green: 0.9568627451, blue: 0.968627451, alpha: 1)
        view.backgroundColor = #colorLiteral(red: 0.9490196078, green: 0.9568627451, blue: 0.968627451, alpha: 1)
        view.layer.borderWidth = 1
        return view
    }()
    lazy var cardImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.image = #imageLiteral(resourceName: "Visa1")
        return view
    }()
    lazy var cardNumberLabel: UILabel = {
        let label = UILabel()
        label.font = .getMullerBoldFont(on: 20)
        label.textColor = #colorLiteral(red: 0.3176470588, green: 0.3607843137, blue: 0.4352941176, alpha: 1)
        label.text = "•••• •••• •••• 2228"
        label.textAlignment = .center
        return label
    }()
    lazy var trashButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "Trash"), for: .normal)
        button.addTarget(self, action: #selector(deleteCard), for: .touchUpInside)
        button.imageView?.contentMode = .scaleAspectFit
        return button
    }()
    
    var card: CloudCard! {
        didSet {
            if card.cardType == "Visa" {
                cardImageView.image = #imageLiteral(resourceName: "Visa1")
            } else {
                cardImageView.image = #imageLiteral(resourceName: "mastercard")
            }
            cardNumberLabel.text = "•••• •••• •••• \(card.cardLastFour)"
        }
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selectionStyle != .none {
            if isSelected {
                mainView.backgroundColor = #colorLiteral(red: 0.1647058824, green: 0.5960784314, blue: 1, alpha: 1)
                cardNumberLabel.textColor = .white
                contentView.backgroundColor = .white
                trashButton.isHidden = false
//                trashButton.setImage(UIImage(named: MediaType.checked), for: .normal)
                if card.cardType == "Visa" {
//                    cardImageView.image = UIImage(named: MediaType.visaWhite)
                }
                trashButton.removeTarget(self, action: nil, for: .allEvents)
            } else {
                mainView.backgroundColor = #colorLiteral(red: 0.9490196078, green: 0.9568627451, blue: 0.968627451, alpha: 1)
                cardNumberLabel.textColor = #colorLiteral(red: 0.3176470588, green: 0.3607843137, blue: 0.4352941176, alpha: 1)
                trashButton.isHidden = true
                if card.cardType == "Visa" {
//                    cardImageView.image = UIImage(named: MediaType.visaCard)
                }
                trashButton.addTarget(self, action: #selector(deleteCard), for: .touchUpInside)
            }
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setCard(card: CloudCard) {
        self.card = card
    }
    // MARK: - Setupviews
    func setupViews() {
        
        backgroundColor = .white
        selectionStyle = .none
        addSubview(mainView)
        mainView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(4)
            make.left.equalTo(16)
            make.right.equalTo(-16)
            make.bottom.equalToSuperview()
        }
        mainView.addSubview(cardImageView)
        mainView.addSubview(cardNumberLabel)
        mainView.addSubview(trashButton)
        
        cardImageView.snp.makeConstraints { (make) in
            make.top.left.equalToSuperview().offset(16)
            make.bottom.equalToSuperview().offset(-16)
            make.width.equalTo(50)
        }
        trashButton.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(16)
            make.right.bottom.equalToSuperview().offset(-16)
            make.width.height.equalTo(25)
        }
        cardNumberLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(16)
            make.bottom.equalToSuperview().offset(-16)
            make.left.equalTo(cardImageView.snp.right).offset(8)
            make.right.equalTo(trashButton.snp.left).offset(-8)
        }
    }
    
    @objc func deleteCard(){
    }
}

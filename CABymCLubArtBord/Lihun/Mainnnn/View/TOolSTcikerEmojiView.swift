//
//  TOolSTcikerEmojiView.swift
//  CABymCLubArtBord
//
//  Created by JOJO on 2021/6/24.
//

import UIKit

class TOolSTcikerEmojiView: UIView {
    var showEmojiClickBlock:((_ isShow: Bool)->Void)?
    var stickerClickBlock:((NEymEditToolItem)->Void)?
    var collection_emoji: UICollectionView!
    let emojiSwitch = UISwitch()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupview() {
        backgroundColor = .clear
        //
        let emojiKaiGuanBgView = UIImageView(image: UIImage(named: "showemoji_background"))
        addSubview(emojiKaiGuanBgView)
        emojiKaiGuanBgView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(15)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(354)
            $0.height.equalTo(72)
        }
        //
        let emojiKaiguanLabel = UILabel()
        emojiKaiguanLabel.font = UIFont(name: "Poppins-Bold", size: 18)
        emojiKaiguanLabel.text = "Show Emoji"
        emojiKaiguanLabel.textColor = UIColor(hexString: "#292929")
        addSubview(emojiKaiguanLabel)
        emojiKaiguanLabel.snp.makeConstraints {
            $0.centerY.equalTo(emojiKaiGuanBgView).offset(-1)
            $0.left.equalTo(45)
            $0.width.height.greaterThanOrEqualTo(1)
        }
        //
        
        emojiSwitch.isOn = true
        emojiSwitch.tintColor = UIColor.init(hexString: "#8155FF")
        emojiSwitch.onTintColor = UIColor.init(hexString: "#8155FF")
        emojiSwitch.addTarget(self, action: #selector(emojiButtonClick(sender:)), for: .valueChanged)
        addSubview(emojiSwitch)
        emojiSwitch.snp.makeConstraints {
            $0.centerY.equalTo(emojiKaiguanLabel)
            $0.right.equalTo(-48)
        }
        //
        
        let layout_emoji = UICollectionViewFlowLayout()
        layout_emoji.scrollDirection = .horizontal
        collection_emoji = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: layout_emoji)
        collection_emoji.showsVerticalScrollIndicator = false
        collection_emoji.showsHorizontalScrollIndicator = false
        collection_emoji.backgroundColor = .clear
        collection_emoji.delegate = self
        collection_emoji.dataSource = self
        addSubview(collection_emoji)
        collection_emoji.snp.makeConstraints {
            $0.top.equalTo(emojiKaiGuanBgView.snp.bottom).offset(24)
            $0.centerX.equalToSuperview()
            $0.left.equalToSuperview()
            $0.height.equalTo(154)
        }
        collection_emoji.register(cellWithClass: TOolStickerCell.self)
        //
        
    }
    
    @objc func emojiButtonClick(sender: UISwitch) {
        showEmojiClickBlock?(sender.isOn)
    }

    func updateSwitchStatus(isOn: Bool) {
        emojiSwitch.isOn = isOn
    }
}


extension TOolSTcikerEmojiView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // color
        let cell = collectionView.dequeueReusableCell(withClass: TOolStickerCell.self, for: indexPath)
        let item = CAynARTDataManager.default.stickerItemList[indexPath.item]
        cell.stickerImgV.backgroundColor = .white
        cell.stickerImgV.image = UIImage(named: item.thumbName)
        cell.vipImgV.isHidden = !item.isPro
        //
        cell.contentView.layer.cornerRadius = 18
        cell.contentView.layer.masksToBounds = true
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return CAynARTDataManager.default.stickerItemList.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
}

extension TOolSTcikerEmojiView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
         
        return CGSize(width: 72, height: 72)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
         
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
}

extension TOolSTcikerEmojiView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = CAynARTDataManager.default.stickerItemList[indexPath.item]
        stickerClickBlock?(item)
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
    }
}



class TOolStickerCell: UICollectionViewCell {
    let stickerImgV = UIImageView()
    
    let vipImgV = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        
        contentView.backgroundColor = .white
        //
        
        contentView.addSubview(stickerImgV)
        stickerImgV.contentMode = .scaleAspectFit
        stickerImgV.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.left.top.equalToSuperview().offset(10)
        }
        //
        contentView.addSubview(vipImgV)
        vipImgV.contentMode = .scaleAspectFit
        vipImgV.snp.makeConstraints {
            $0.top.left.equalToSuperview()
            $0.width.equalTo(37)
            $0.height.equalTo(18)
        }
        vipImgV.image = UIImage(named: "ic_vip")
        
    }
    
    
    
}

//
//  TOolBGcolorAndBorderView.swift
//  CABymCLubArtBord
//
//  Created by JOJO on 2021/6/24.
//

import UIKit

class TOolBGcolorAndBorderView: UIView {

    let bordderWidthSlider = UISlider()
    let cornerSlider = UISlider()
    var bordderWidthStrengthBlock: ((CGFloat)->Void)?
    var cornerStrengthBlock: ((CGFloat)->Void)?
    var bgColorClickBlock: ((NEymEditToolItem)->Void)?
    var bgBorderClickBlock: ((NEymEditToolItem)->Void)?
    
    var collection_color: UICollectionView!
    var collection_border: UICollectionView!
    
    var userPhotoImg: UIImage?
    
    
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
        bordderWidthSlider.isContinuous = true
        bordderWidthSlider.setThumbImage(UIImage(named: "slider_select"), for: .normal)
        bordderWidthSlider.setMinimumTrackImage(UIImage(named: "slider_purple"), for: .normal)
        bordderWidthSlider.setMaximumTrackImage(UIImage(named: "slider_white"), for: .normal)
        addSubview(bordderWidthSlider)
        bordderWidthSlider.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.width.equalTo(354)
            $0.height.greaterThanOrEqualTo(50)
            $0.top.equalTo(3)
        }
        
        bordderWidthSlider.minimumValue = -0.3
        bordderWidthSlider.maximumValue = 1
        bordderWidthSlider.addTarget(self, action: #selector(bordderWidthSliderChange(sender:)), for: .valueChanged)

        //
        cornerSlider.isContinuous = true
        cornerSlider.setThumbImage(UIImage(named: "slider_select"), for: .normal)
        cornerSlider.setMinimumTrackImage(UIImage(named: "slider_purple"), for: .normal)
        cornerSlider.setMaximumTrackImage(UIImage(named: "slider_white"), for: .normal)
        addSubview(cornerSlider)
        cornerSlider.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.width.equalTo(354)
            $0.height.greaterThanOrEqualTo(50)
            $0.top.equalTo(bordderWidthSlider.snp.bottom).offset(5)
        }
        cornerSlider.minimumValue = -0.3
        cornerSlider.maximumValue = 1
        cornerSlider.addTarget(self, action: #selector(cornerSliderChange(sender:)), for: .valueChanged)
        //
        let borderLabel = UILabel()
        borderLabel.font = UIFont(name: "Poppins-Bold", size: 14)
        borderLabel.textColor = .white
        borderLabel.text = "Border"
        addSubview(borderLabel)
        borderLabel.snp.makeConstraints {
            $0.centerY.equalTo(bordderWidthSlider).offset(0)
            $0.left.equalTo(bordderWidthSlider).offset(20)
            $0.width.height.greaterThanOrEqualTo(1)
        }
        //
        let cornerLabel = UILabel()
        cornerLabel.font = UIFont(name: "Poppins-Bold", size: 14)
        cornerLabel.textColor = .white
        cornerLabel.text = "Corner"
        addSubview(cornerLabel)
        cornerLabel.snp.makeConstraints {
            $0.centerY.equalTo(cornerSlider).offset(-0)
            $0.left.equalTo(cornerSlider).offset(20)
            $0.width.height.greaterThanOrEqualTo(1)
        }
        //
        

        let layout_color = UICollectionViewFlowLayout()
        layout_color.scrollDirection = .horizontal
        collection_color = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: layout_color)
        collection_color.showsVerticalScrollIndicator = false
        collection_color.showsHorizontalScrollIndicator = false
        collection_color.backgroundColor = .clear
        collection_color.delegate = self
        collection_color.dataSource = self
        addSubview(collection_color)
        collection_color.snp.makeConstraints {
            $0.top.equalTo(cornerSlider.snp.bottom).offset(8)
            $0.centerX.equalToSuperview()
            $0.left.equalToSuperview()
            $0.height.equalTo(85)
        }
        collection_color.register(cellWithClass: TOolBGcolorCell.self)
        //
        
        
        let layout_border = UICollectionViewFlowLayout()
        layout_border.scrollDirection = .horizontal
        collection_border = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: layout_border)
        collection_border.showsVerticalScrollIndicator = false
        collection_border.showsHorizontalScrollIndicator = false
        collection_border.backgroundColor = .clear
        collection_border.delegate = self
        collection_border.dataSource = self
        addSubview(collection_border)
        collection_border.snp.makeConstraints {
            $0.top.equalTo(collection_color.snp.bottom).offset(0)
            $0.centerX.equalToSuperview()
            $0.left.equalToSuperview()
            $0.height.equalTo(80)
        }
        collection_border.register(cellWithClass: TOolBGBorderCell.self)
    }
    
    func updateContentStatus(photo: UIImage) {
        userPhotoImg = photo
        collection_color.reloadData()
        collection_border.reloadData()
    }
    
    @objc func bordderWidthSliderChange(sender: UISlider) {
        if CGFloat(sender.value) <= 0 {
            bordderWidthSlider.value = 0
        }
        
        bordderWidthStrengthBlock?(CGFloat(sender.value)/2)
    }
    @objc func cornerSliderChange(sender: UISlider) {
        if CGFloat(sender.value) <= 0 {
            cornerSlider.value = 0
        }
        
        cornerStrengthBlock?(CGFloat(sender.value))
    }
}



extension TOolBGcolorAndBorderView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == collection_color {
            // color
            let cell = collectionView.dequeueReusableCell(withClass: TOolBGcolorCell.self, for: indexPath)
            let item = CAynARTDataManager.default.bgColorList[indexPath.item]
            if item.thumbName.contains("#") {
                cell.bgColorImgV.image = nil
                cell.bgColorImgV.backgroundColor = UIColor(hexString: item.thumbName)
            } else {
                cell.bgColorImgV.image = UIImage(named: item.thumbName)
            }
            cell.vipImgV.isHidden = !item.isPro
            //
            cell.contentView.layer.cornerRadius = 18
            cell.contentView.layer.masksToBounds = true
            cell.userPhotoImgV.image = userPhotoImg
            return cell
        } else {
            // border
            let cell = collectionView.dequeueReusableCell(withClass: TOolBGBorderCell.self, for: indexPath)
            let item = CAynARTDataManager.default.borderList[indexPath.item]
            cell.bgColorImgV.image = UIImage(named: item.thumbName)
            cell.vipImgV.isHidden = !item.isPro
            //
            cell.contentView.layer.cornerRadius = 18
            cell.contentView.layer.masksToBounds = true
            
            
            if item.thumbName == "ic_cancel" {
                cell.userPhotoImgV.image = nil
            } else {
                cell.userPhotoImgV.image = userPhotoImg
            }
                
            
            return cell
        }
        return UICollectionViewCell()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == collection_color {
            // color
            return CAynARTDataManager.default.bgColorList.count
        } else {
            // border
            return CAynARTDataManager.default.borderList.count
        }
        return 1
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
}

extension TOolBGcolorAndBorderView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == collection_color {
            // color
        } else {
            // border
        }
        return CGSize(width: 72, height: 72)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if collectionView == collection_color {
            // color
        } else {
            // border
        }
        return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == collection_color {
            // color
        } else {
            // border
        }
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 12
    }
    
}

extension TOolBGcolorAndBorderView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == collection_color {
            // color
            let item = CAynARTDataManager.default.bgColorList[indexPath.item]
            bgColorClickBlock?(item)
        } else {
            // border
            let item = CAynARTDataManager.default.borderList[indexPath.item]
            bgBorderClickBlock?(item)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
    }
}

class TOolBGcolorCell: UICollectionViewCell {
    let bgColorImgV = UIImageView()
    let userPhotoImgV = UIImageView()
    
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
        contentView.addSubview(bgColorImgV)
        bgColorImgV.contentMode = .scaleAspectFit
        bgColorImgV.snp.makeConstraints {
            $0.left.top.right.bottom.equalToSuperview()
        }
        //
        userPhotoImgV.backgroundColor = .clear
        userPhotoImgV.contentMode = .scaleAspectFill
        userPhotoImgV.layer.masksToBounds = true
        
        contentView.addSubview(userPhotoImgV)
        userPhotoImgV.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.left.equalTo(15)
            $0.top.equalTo(15)
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



class TOolBGBorderCell: UICollectionViewCell {
    let bgColorImgV = UIImageView()
    let userPhotoImgV = UIImageView()
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
        //
        userPhotoImgV.backgroundColor = .clear
        userPhotoImgV.contentMode = .scaleAspectFill
        contentView.addSubview(userPhotoImgV)
        userPhotoImgV.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.left.equalTo(0)
            $0.top.equalTo(0)
        }
        contentView.addSubview(bgColorImgV)
        bgColorImgV.contentMode = .scaleAspectFit
        bgColorImgV.snp.makeConstraints {
            $0.left.top.right.bottom.equalToSuperview()
        }
        //
        
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


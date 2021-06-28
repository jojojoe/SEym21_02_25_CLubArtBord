//
//  CABymCoinAlertView.swift
//  CABymCLubArtBord
//
//  Created by JOJO on 2021/6/25.
//

import UIKit


class CABymCoinAlertView: UIView {

    var okBtnClickBlock: (()->Void)?
    var cancelBtnClickBlock: (()->Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupView() {
        backgroundColor = UIColor.black.withAlphaComponent(0.85)
        let bgBt = UIButton(type: .custom)
        bgBt.backgroundColor = .clear
        addSubview(bgBt)
        bgBt.snp.makeConstraints {
            $0.left.right.top.bottom.equalToSuperview()
        }
        bgBt.addTarget(self, action: #selector(cancelBtnClick(sender:)), for: .touchUpInside)
       
        //
        let contentImgV = UIImageView(image: UIImage(named: "costcoin_background"))
        addSubview(contentImgV)
        contentImgV.snp.makeConstraints {
            $0.width.equalTo(712/2)
            $0.height.equalTo(638/2)
            $0.centerY.equalToSuperview().offset(-80)
            $0.centerX.equalToSuperview()
        }
        //
        let contentLabel = UILabel()
        contentLabel.numberOfLines = 0
        contentLabel.font = UIFont(name: "Poppins-Bold", size: 20)
        contentLabel.textColor = UIColor(hexString: "#292929")
//        contentLabel.layer.shadowColor = UIColor(hexString: "#FFD667")?.cgColor
//        contentLabel.layer.shadowOffset = CGSize(width: 0, height: 0)
//        contentLabel.layer.shadowOpacity = 0.8
//        contentLabel.layer.shadowRadius = 3
        
        contentLabel.text = "Use paid items will be deducted \(CAymBCartCoinManager.default.coinCostCount) coins."
        
        contentLabel.textAlignment = .center
        addSubview(contentLabel)
        contentLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalTo(contentImgV).offset(60)
            $0.width.equalTo(256)
            $0.height.greaterThanOrEqualTo(30)
        }
        //
        let okBtn = UIButton(type: .custom)
        addSubview(okBtn)
        okBtn.snp.makeConstraints {
            $0.top.equalTo(contentImgV.snp.bottom).offset(32)
            $0.width.equalTo(363)
            $0.height.equalTo(72)
            $0.centerX.equalToSuperview()
        }
        okBtn.addTarget(self, action: #selector(okBtnClick(sender:)), for: .touchUpInside)
        okBtn.setTitle("Continue", for: .normal)
        okBtn.setTitleColor(.white, for: .normal)
        okBtn.setBackgroundImage(UIImage(named: "costcoin_button"), for: .normal)
        okBtn.titleLabel?.font = UIFont(name: "Poppins-Bold", size: 22)
        //
        let cancelBtn = UIButton(type: .custom)
        addSubview(cancelBtn)
        cancelBtn.snp.makeConstraints {
            $0.top.equalTo(contentImgV.snp.top).offset(16)
            $0.height.width.equalTo(44)
            $0.right.equalTo(contentImgV).offset(-16)
        }
        cancelBtn.addTarget(self, action: #selector(cancelBtnClick(sender:)), for: .touchUpInside)
        cancelBtn.setImage(UIImage(named: "costcoin_ic_close"), for: .normal)
        
        
    }
    
    @objc func okBtnClick(sender: UIButton) {
        okBtnClickBlock?()
    }
    @objc func cancelBtnClick(sender: UIButton) {
        cancelBtnClickBlock?()
    }
}

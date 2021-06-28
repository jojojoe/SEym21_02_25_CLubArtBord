//
//  TOolBlueTickView.swift
//  CABymCLubArtBord
//
//  Created by JOJO on 2021/6/24.
//

import UIKit

class TOolBlueTickView: UIView {
    var showTickClickBlock:((_ isShow: Bool)->Void)?
    let emojiSwitch = UISwitch()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateSwitchStatus(isOn: Bool) {
        emojiSwitch.isOn = isOn
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
        emojiKaiguanLabel.text = "Show Blue Tick"
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
         
        
    }
    
    @objc func emojiButtonClick(sender: UISwitch) {
        showTickClickBlock?(sender.isOn)
    }

}

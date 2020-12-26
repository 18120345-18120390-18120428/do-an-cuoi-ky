//
//  PickerTableViewCell.swift
//  DoAnCuoiKy
//
//  Created by Pham Minh Duy on 12/26/20.
//  Copyright © 2020 AnhKiem. All rights reserved.
//

import UIKit

protocol PickerTableViewCellDelegate: class {
    func getCategory(text: String)
}
class PickerTableViewCell: UITableViewCell {
    @IBOutlet weak var tfInfo: UITextField!
    var pickerView = UIPickerView()
    let categories = ["Ngôn Tình", "Kiếm Hiệp", "Truyện Teen", "Truyện Ma", "Quân Sự", "Trinh Thám", "Lịch Sử", "Tiểu Thuyết", "Thiếu Nhi", "Truyện Ngắn", "Truyện Cười", "Cổ Tích", "Nước Ngoài", "Khoa Học","Truyện Voz"]
    weak var delegate: PickerTableViewCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        pickerView.delegate = self
        pickerView.dataSource = self
        tfInfo.inputView = pickerView
        pickerView.layer.backgroundColor = UIColor.white.cgColor
        pickerView.layer.borderWidth = 3.0
        pickerView.layer.borderColor = UIColor.darkGray.cgColor
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

}
extension PickerTableViewCell: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categories.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return categories[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        tfInfo.text = categories[row]
        tfInfo.resignFirstResponder()
        delegate?.getCategory(text: tfInfo.text!)
    }
    
    
}

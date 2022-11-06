//
//  LocationDetailViewController.swift
//  Cochlear-Test-App
//
//  Created by Faraz Ahmed Khan on 05/11/2022.
//

import UIKit

class LocationDetailViewController: BaseViewController {
    
    @IBOutlet weak var locationNameLabel: UILabel!
    @IBOutlet weak var latitudeLabel: UILabel!
    @IBOutlet weak var longitudeLabel: UILabel!
    @IBOutlet weak var notesTextfield: UITextField!
    @IBOutlet weak var saveBtn: UIButton!
    
    var location: Location?
    var notes: String? {
        get {
            return notesTextfield.text
        }
        set {
            self.notes = newValue
            updateButtonState(isEnabled: !(self.notes?.isEmpty ?? false))
        }
    }
    
    //MARK: - VARIABLES
    var viewModel: DefaultLocationDetailViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        notesTextfield.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        updateButtonState(isEnabled: !(self.notes?.isEmpty ?? true))
        viewModel?.locationName = location?.name ?? ""
        viewModel?.getLocationDetails()
        updateUITexts()
    }
    
    private func updateUITexts() {
        self.locationNameLabel.text = viewModel?.location?.locationName ?? "-"
        self.latitudeLabel.text = viewModel?.location?.latitude ?? "-"
        self.longitudeLabel.text = viewModel?.location?.longitude ?? "-"
        self.notesTextfield.text = viewModel?.location?.notes
    }
    
    private func updateButtonState(isEnabled: Bool) {
        self.saveBtn.isEnabled = isEnabled
    }
    
    @IBAction func saveChangesTapped(_ sender: UIButton) {
        guard let notes = notes else {
            return
        }
        viewModel?.addNotes(message: notes)
        self.routeBack(navigation: .pop)
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        updateButtonState(isEnabled: !(textField.text?.isEmpty ?? true))
    }
}

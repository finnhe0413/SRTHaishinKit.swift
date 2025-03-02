import Foundation
import UIKit

final class PreferenceViewController: UIViewController {
    @IBOutlet private weak var urlField: UITextField?
    @IBOutlet private weak var streamNameField: UITextField?

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        urlField?.text = Preference.shared.url.description
        streamNameField?.text = Preference.shared.streamName
    }

    @IBAction func on(open: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller: UIViewController = storyboard.instantiateViewController(withIdentifier: "PopUpLive")
        present(controller, animated: true, completion: nil)
    }
}

extension PreferenceViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if urlField == textField {
            Preference.shared.url = textField.text ?? ""
        }
        if streamNameField == textField {
            Preference.shared.streamName = textField.text ?? ""
        }
        textField.resignFirstResponder()
        return true
    }
}

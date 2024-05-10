import UIKit

class CameraViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var imageViewCapture: UIImageView!
    @IBOutlet weak var captureImageDummyButton: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    var items: [(title: String, time: String)] = [("English paper", "9:04 AM "),
                                                  ("English writing", "9:04 AM"),
                                                  ("Maths Test", "9:04 AM"),
                                                  ("Tenses", "9:04 AM "),
                                                  ("English writing", "9:04 AM")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.reloadData()
        
        // Add tap gesture recognizer to the captureImageDummyButton
//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(openCamera(_:)))
//        captureImageDummyButton.isUserInteractionEnabled = true
//        captureImageDummyButton.addGestureRecognizer(tapGesture)
    }

    @objc func openCamera(_ sender: UITapGestureRecognizer) {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .camera
            imagePicker.allowsEditing = false
            present(imagePicker, animated: true, completion: nil)
        } else {
            print("Camera is not available.")
        }
    }
    
    // MARK: - UIImagePickerControllerDelegate

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imageViewCapture.image = pickedImage // Set the captured image to the imageViewCapture
            
            // Pass the captured image to the next view controller
            performSegue(withIdentifier: "showImageDetail", sender: pickedImage)
            
            // Save the captured image to file
            saveImageToFile(image: pickedImage)
        }
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    // Function to save image to file
    func saveImageToFile(image: UIImage) {
        if let data = image.jpegData(compressionQuality: 1.0) {
            let filename = getDocumentsDirectory().appendingPathComponent("capturedImage.jpg")
            do {
                try data.write(to: filename)
                print("Image saved to: \(filename)")
            } catch {
                print("Error saving image: \(error)")
            }
        }
    }
    
    // Function to get the path of the Documents directory
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "showImageDetail",
////          
//           let pickedImage = sender as? UIImage {
//            imageDetailVC.image = pickedImage
//        }
    }
}

extension CameraViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemTableViewCell", for: indexPath) as! ItemTableViewCell
        
        let item = items[indexPath.row]
        cell.titleLabel.text = item.title
        cell.timeLabel.text = item.time
        
        // Set the description based on the title
        cell.descriptionLabel.text = getDescription(for: item.title)
        
        return cell
    }
    
    // Function to get description based on title
    func getDescription(for title: String) -> String {
        switch title {
        case "English paper":
            return "Description for English paper"
        case "English writing":
            return "Description for English writing"
        case "Maths Test":
            return "Description for Maths Test"
        case "Tenses":
            return "Description for Tenses"
        default:
            return ""
        }
    }
}

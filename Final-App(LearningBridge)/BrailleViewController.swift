import UIKit

class BrailleViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var extractedClassesTextView: UITextView!
    
    var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
    }
    
    @IBAction func detectBraille(_ sender: UIButton) {
        guard let image = imageView.image else { return }
        guard let imageData = image.jpegData(compressionQuality: 1) else { return }
        guard let fileContent = imageData.base64EncodedString().data(using:.utf8) else { return }
        
        var request = URLRequest(url: URL(string: "https://detect.roboflow.com/braille-detection/2?api_key=DxC1TpRZCmwvt98eJe7v&name=YOUR_IMAGE.jpg")!, timeoutInterval: Double.infinity)
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = fileContent
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else {
                print("No data received")
                return
            }
            
            do {
                guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                      let predictions = json["predictions"] as? [[String: Any]] else {
                    print("Invalid JSON format")
                    return
                }
                
                var extractedClasses = ""
                
                for prediction in predictions {
                    if let classLabel = prediction["class"] as? String {
                        extractedClasses += "\(classLabel)"
                    }
                }
                
                if extractedClasses.hasSuffix(", ") {
                    extractedClasses.removeLast(2)
                }
                
                DispatchQueue.main.async {
                    self.extractedClassesTextView.text = extractedClasses
                    self.performSegue(withIdentifier: "ShowSpeechRecogniser", sender: self)
                }
                
                print("Extracted Classes: \(extractedClasses)")
            } catch {
                print("Error parsing JSON: \(error.localizedDescription)")
            }
        }.resume()
    }
    
    @IBAction func selectImage(_ sender: UIButton) {
        let alertController = UIAlertController(title: "Select Image", message: nil, preferredStyle:.actionSheet)
        
        let cameraAction = UIAlertAction(title: "Take Photo", style:.default) { _ in
            self.imagePicker.sourceType = .camera
            self.present(self.imagePicker, animated: true, completion: nil)
        }
        
        let photoLibraryAction = UIAlertAction(title: "Choose from Photo Library", style:.default) { _ in
            self.imagePicker.sourceType = .photoLibrary
            self.present(self.imagePicker, animated: true, completion: nil)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style:.cancel, handler: nil)
        
        alertController.addAction(cameraAction)
        alertController.addAction(photoLibraryAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.originalImage] as? UIImage else { return }
        imageView.image = image
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowSpeechRecogniser" {
            if let speechRecogniserVC = segue.destination as? SpeechRecogniserViewController {
                speechRecogniserVC.extractedText = extractedClassesTextView.text
            }
        }
    }
}

//
//  ViewController.swift
//  Zeus
//
//  Created by osx on 30/07/22.
//

import UIKit
import FirebaseStorage

enum MenuItems {
    
    case textF
    case selfie
    case chart
    case sendImage
}

class ViewController: UIViewController {
    
    var presenter : Presenter?
    var cameraImage : UIImage?
    var table : UITableView?
    
    var items : [MenuItems] = [.textF,.selfie,.chart,.sendImage]
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupUI()
    }
    
    func setupUI(){
        
        let table = UITableView(frame: .zero)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.delegate = self
        table.backgroundColor = .clear
        table.dataSource = self
        self.view.addSubview(table)
        
        NSLayoutConstraint.activate ([
            
            table.topAnchor.constraint(equalTo: self.view.topAnchor),
            table.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            table.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            table.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
            
        ])
        self.table = table
        
        table.register(UINib(nibName: "TextFieldCell", bundle: nil), forCellReuseIdentifier: "TextFieldCell")
        table.register(UINib(nibName: "SelfieCell", bundle: nil), forCellReuseIdentifier: "SelfieCell")
        table.register(UINib(nibName: "ChartCell", bundle: nil), forCellReuseIdentifier: "ChartCell")
        table.register(UINib(nibName: "SubmitImageCell", bundle: nil), forCellReuseIdentifier: "SubmitImageCell")
    }
    
    func sendImage(){
        if let image = cameraImage{
            
            guard let image = image.scaleAndCrop(withAspect: true, to: 200),
                          let imageData = image.pngData() else {
                        return
             }
            // Upload the new profile image to Firebase Storage
            let storageRef = Storage.storage().reference().child("david.jpg")
                    let uploadTask = storageRef.putData(imageData, metadata: nil) { (metadata, error) in
                        guard metadata != nil else {
                            print("Error uploading image to Firebase Storage: \(error?.localizedDescription)")
                            
                            return
                            
                        }
                        self.showAlert(title: "Alerta", message: "Se guardo la imagen", btnOKString: "Aceptar")
                    }
                        
        }else{
            self.showAlert(title: "Alerta", message: "Aun no haz seleccionado una iamgen", btnOKString: "aceptar")
        }
    }
    
}

extension ViewController : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = UITableViewCell()
        
        switch items [indexPath.row]{
            
        case .textF :
             cell = tableView.dequeueReusableCell(withIdentifier: "TextFieldCell") as! TextFieldCell
        case .selfie :
             cell =  tableView.dequeueReusableCell(withIdentifier: "SelfieCell") as! SelfieCell
            (cell as! SelfieCell).camaraImage = self.cameraImage
        case .chart:
             cell =  tableView.dequeueReusableCell(withIdentifier: "ChartCell") as! ChartCell
        case .sendImage:
            cell = tableView.dequeueReusableCell(withIdentifier: "SubmitImageCell") as! SubmitImageCell
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = items[indexPath.row]
        
        switch item {
            
        case .textF :
            return
        case .selfie :
            self.actionCameraCell()
        case .chart:
            self.showChart()
        case .sendImage:
            self.sendImage()
        }
        
        
    }
    
    func showChart(){
        
        self.presenter?.showChart(navegation: self.navigationController!)
    }
    
}
extension ViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            dismiss(animated: true, completion: nil)
        }
        
        func imagePickerController(_ picker: UIImagePickerController,
                                            didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            
          cameraImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
            if let index = items.firstIndex{(item) -> Bool in
                return item == .selfie
            }{
               table?.reloadRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
            }
            dismiss(animated: true, completion: nil)
        }
        
        private func actionCameraCell(){
            
            let alert = UIAlertController(title: "Selecciona una image",
                                           message: "Por favor selecciona una imagen para mostrar.",
                                           preferredStyle: .actionSheet)

            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self

            let cameraAction = UIAlertAction(title: "Camara",
                                             style: .default,
                                             handler: {_ in
                                                imagePicker.sourceType = .camera
                                                self.present(imagePicker, animated: true)
                                             })

            let libraryAction = UIAlertAction(title: "Fotos",
                                              style: .default,
                                              handler: { _ in
                                                imagePicker.sourceType = .photoLibrary
                                                self.present(imagePicker, animated: true)
                                              })
            


            let cancelAction = UIAlertAction(title: "Cancelar",
                                             style: .cancel,
                                             handler: nil)

            alert.addAction(cameraAction)
            alert.addAction(libraryAction)
            alert.addAction(cancelAction)
            self.present(alert, animated: true, completion: nil)
        }
    
}

extension ViewController : ViewProtocol {
    
}

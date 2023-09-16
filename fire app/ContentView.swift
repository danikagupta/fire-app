//
//  ContentView.swift
//  fire app
//
//  Created by Siddhartha on 10/5/22.
//


import SwiftUI
import Alamofire
import SwiftyJSON

struct ContentView: View {
    @State var animalName = " "
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage? = UIImage(named: "smokescene")
    let messages = ["smoke":"Caution: fire detected. Call the Fire Department.","no_smoke":"Good news. No fire smoke has been detected."]
    
    var body: some View {
        HStack {
            VStack (alignment: .center,
                    spacing: 20){
                Text("Fire Fighting System")
                    .font(.system(.largeTitle, design: .rounded))
                    .fontWeight(.bold)
                Text(animalName)
                Image(uiImage: inputImage!).resizable()
                    .aspectRatio(contentMode: .fill)
                //Text(animalName)
                Button("Upload Image"){
                    self.buttonPressed()
                }
                .padding(.all, 14.0)
                .foregroundColor(.white)
                .background(Color.green)
                .cornerRadius(10)
            }
                    .font(.title)
        }.sheet(isPresented: $showingImagePicker, onDismiss: processImage) {
            ImagePicker(image: self.$inputImage)
        }
    }
    
    func buttonPressed() {
        print("Button pressed")
        self.showingImagePicker = true
    }
    
    func processImage() {
        self.showingImagePicker = false
        self.animalName="Checking..."
        guard let inputImage = inputImage else {return}
        print("Processing image due to Button press")
        let imageJPG=inputImage.jpegData(compressionQuality: 0.0034)!
        let imageB64 = Data(imageJPG).base64EncodedData()
        let uploadURL="https://askai.aiclub.world/7c271bc1-fd12-4ef7-828b-dc7e41941400"
        
        AF.upload(imageB64, to: uploadURL).responseJSON { response in
            
            debugPrint(response)
            switch response.result {
               case .success(let responseJsonStr):
                   print("\n\n Success value and JSON: \(responseJsonStr)")
                   let myJson = JSON(responseJsonStr)
                let predictedValue = myJson["predicted_label"].string
                   print("Saw predicted value \(String(describing: predictedValue))")

                let predictionMessage = messages[predictedValue!]
                   self.animalName=predictionMessage!
               case .failure(let error):
                   print("\n\n Request failed with error: \(error)")
               }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct ImagePicker: UIViewControllerRepresentable {
    @Environment(\.presentationMode) var presentationMode
    @Binding var image: UIImage?

    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        //picker.sourceType = .camera
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: ImagePicker

        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                parent.image = uiImage
            }
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}

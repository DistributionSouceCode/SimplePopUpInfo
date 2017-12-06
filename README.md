# SimplePopUpInfo

#Usage

let modalView = PopUpInfo(frame: self.view.bounds)

let downloadImage = UIImage(named: "download") ?? UIImage()

modalView.set(with: downloadImage)

modalView.set(headline: "Downloading.....")

view.addSubview(modalView)

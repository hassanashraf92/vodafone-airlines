# Vodafone Airlines

Vodafone Airlines is an application designed to analyze any recipe and get a detailed nutrition data about it built based on Vodafone Challenge.

### Requirements
* Xcode Version 12.5+ Swift 5.4+

### Design
https://xd.adobe.com/view/0c57cbb0-a790-4f08-a546-e3ef5e10b0b3-5904/

### Layers
- Domain Layer = Entities + Repositories Interfaces
- Data Repositories Layer = Repositories Implementations + API (Network) + Persistence DB
- Presentation Layer (MVVM) = ViewModels + Views

### Architecture concepts
* Clean Architecture.
* MVVM.
* Data Binding using  `Bindable` class.
* Dependency Injection.

### Includes
* CoreData.
* Unit Test for ViewModels.

### Networking
* Alamofire (v5.4.3).

### How to run the example?

1. Clone the project from github `https://github.com/hassanashraf92/vodafone-airlines.git`.
2. Open shell window and navigate to project folder.
3. Run `pod install`.
1. Open `Vodafone Airlines.xcworkspace` and run the project on selected device or simulator.

### How was it created?

1. Open XCode. File->New->Project->Single View App->Project name.
2. Create Podfile with the target name and Particle pods reference (see file).
3. Close XCode Project.
4. Open shell window and navigate to the project folder.
5. Run `pod install` (make sure your have latest [Cocoapods](https://guides.cocoapods.org/using/getting-started.html#installation)  installed), pods will be installed and new XCode workspace file will be created.
6. in XCode open the new `Vodafone Airlines.xcworkspace`
7. Create the source code and storyboard for your app (check  `Main.storyboard` for reference)
8. Build and run - works on simulator and device.


```

For questions - please don't hesitate to contact me at 01113412336 or hassan92ashraf@gmail.com

Thank you!

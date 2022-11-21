# D-Krops

> The is a mobile application developed in flutter for its User Interface.

**D-Krops** is a mobile application designed purely for data collection. The application is made to target small-scale farmers where for their small crops they take care they are able to map their crops where from a machine learning model they are able to predict crop health, yield from the data collected in the mobile appliction.

> The application is linked to a server using php to build the api to send the data to the backend(server).

**Currently available on the Play store.**

*[![Play Store Badge](https://developer.android.com/images/brand/en_app_rgb_wo_60.png)](https://play.google.com/store/apps/details?id=com.emilio.space&hl=en&gl=US)*


**Technologies Used in the Project**
 1. Flutter 3.3.1
 2. Dart


## Documentation

Here we are going to describe how you will set up the project in your local machine to get started

## Creating a new flutter project

To get started, create a `flutter` project from your terminal to your desired location on your machine:

```dart
//paste this in your terminal
flutter create <app-name>
```

## Take an image using the application
The application allows the user to pick an image from the camera inorder to send the image of the crop
### Install Image_picker plugin
> We will be using this package from [pub.dev](https://pub.dev/) to pick an image to send it to firebase

> The package allows to get the image from the camera and the gallery

> You can download the package from this link [image-picker](https://pub.dev/packages/image_picker)

### Using the package in the app
How to install the package in your terminal in your IDE  (vscode or Android Studio) 
```dart
//paste this in the terminal to install the package
flutter pub add image_picker
```
### Creating an instance of the image-Picker
Use this line of code to create an instance of `image-picker`
```dart
// ...
ImagePicker picker = ImagePicker();
// OR
final picker = ImagePicker();
 ```
 ### Get the Image from Camera
 
 My bad i used [fluttertoast](https://pub.dev/packages/fluttertoast) to show a toast if there is an error when getting the image.
 ```dart
   void takePhoto(ImageSource source) async {
    final image = await picker.pickImage(
        source: source, maxHeight: 480, maxWidth: 640, imageQuality: 60);
    try {
      if (image == null) return;

      final imageTempo = File(image.path);
      setState(() {
        this.image = imageTempo;
      });
    } on PlatformException catch (e) {
      Fluttertoast.showToast(
          backgroundColor: Colors.red,
          msg: "Failed to pick image $e",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 1,
          fontSize: 16.0);
    }
  }
  ```
 ###  take photo 
 Using the code above to take photo from either the `Camera` or the `Gallery`
 > The `onTap` can be a button or any widget with [Gesture Detector](https://api.flutter.dev/flutter/widgets/GestureDetector-class.html) or [InkWell](https://api.flutter.dev/flutter/material/InkWell-class.html)
 ### From the Camera
 ```dart
 onTap: () {
        takePhoto(ImageSource.camera);
        Navigator.pop(context);
      }
 ```
 ### From the Gallery
  ```dart
 onTap: () {
        takePhoto(ImageSource.gallery);
        Navigator.pop(context);
      }
 ```
 ## Initialize Google Maps
 > We install the `google_maps_flutter` package to show an image in the app. You can find more details [here](https://pub.dev/packages/google_maps_flutter)
 
 > We use the package as its easier and faster to implement in flutter
 
 > You can check more about it from the [docs](https://github.com/flutter/plugins/tree/main/packages/google_maps_flutter/google_maps_flutter).
 
 ### Add the Google maps Api
 Get the google maps api from the [google cloud console](https://cloud.google.com/) under for the Google maps platoform
 ### Add the api in the Android Manifest File
 ```xml
 //...
  <meta-data android:name="com.google.android.geo.API_KEY"
               android:value= <here> />
 //...
  ```
  
  ### Add permissions to access the location on the phone and internet connection in Android Manifest File
  ```xml
 //...
    <uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION"/>
    <uses-permission android:name="android.permission.ACCESS_FINE_LOCATION"/>
    <uses-permission android:name="android.permission.FOREGROUND_SERVICE" />
    <uses-permission android:name="android.permission.INTERNET"/>
 //...
  ```
  ### Change the SDK version
 In the `build.gradle` change the `minSdkVersion` from 19 to 21 to allow the Google Maps to run 
 ```gradle
 //...
     defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId "com.space.finalspace"
        minSdkVersion 21 //change here in your code
        targetSdkVersion 31
        versionCode 1
        versionName "1.0"
    }
//...
```
## Sending the Data to the server
To get started, install the `http` package which can be found [here](https://pub.dev/packages/http)
> The `http` package allows us to perform all the `CRUD` operations to an api in which it consumes.

> You can also use the `dio` package and you can find more about this package [here](https://pub.dev/packages/dio)

### Configure to send data to server
 > **Note**
 > The code used here are in reference to the code in the project
```dart
_sendData() async {
    final String variety_1 = variety.text
    final String row_1 = row.text;
    final String column_1 = column.text;
    final String location = heights.text;
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String formatted = formatter.format(today!);
    final String date_1 = today.toString();
    final double density_1 = double.parse(row.text) * double.parse(column.text);
    
    // encode the image to a string
    
    final bytes = image?.readAsBytesSync();
    String imageEncoded = base64Encode(bytes!);
    
    // Create a dio instance
    
    var dio = Dio();
    
    // Creating a formDate for the data collected
    
    var formData = FormData.fromMap({
          "variety": variety_1,
          "location": location,
          "crop_density": density_1,
          "plantation_method": selectedMethod,
          "row": row_1,
          "column": column_1,
          "image": imageEncoded,
          "x_coordinate": latitude,
          "y_coordinate": longitude,
          "latitude": latitude,
          "longitude": longitude,
          "type": selectedType,
          "date_of_plantation": formatted,
          "land_cover": unique,
    });
    
    // Send the data using the post method
    
     var response = await dio
        .post('https://iggresapps.dkut.ac.ke/crop_mapping.php', data: formData);
        
 }
 ```

 

 

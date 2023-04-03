
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String? gender;

  int currentStep = 0;
  String? imagePath;
  late ImagePicker picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text(
          "Edit Your Profile",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Stepper(
        currentStep: currentStep,
        onStepTapped: (val) {
          setState(() {
            currentStep = val;
          });
        },
        onStepContinue: () {
          setState(() {
            if (currentStep < 10) currentStep++;
          });
        },
        onStepCancel: () {
          setState(() {
            if (currentStep > 0) currentStep--;
          });
        },
        steps: [
          Step(
            isActive: currentStep >= 0,
            title: const Text(
              "Profile Picture",
            ),
            content: Stack(
              alignment: Alignment.bottomRight,
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage:
                  (imagePath != null) ? FileImage(File(imagePath!)) : null,
                  child: (imagePath != null)
                      ? const Text("")
                      : const Text(
                    "ADD",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    await showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              ),
                            ),
                            title: const Text(
                              "Select image picker type",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            actions: [
                              ElevatedButton(
                                onPressed: () async {
                                  Navigator.of(context).pop();
                                  XFile? pickerFile = await picker.pickImage(
                                      source: ImageSource.gallery);

                                  if (pickerFile != null) {
                                    setState(() {
                                      imagePath = pickerFile.path;
                                    });
                                  }
                                },
                                child: const Text("gallery"),
                              ),
                              ElevatedButton(
                                onPressed: () async {
                                  Navigator.of(context).pop();
                                  XFile? pickerFile = await picker.pickImage(
                                      source: ImageSource.camera);
                                  setState(() {
                                    imagePath = pickerFile!.path;
                                  });
                                },
                                child: const Text("Camera"),
                              ),
                            ],
                          );
                        });
                  },
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                  ),
                  child: const Icon(Icons.add),
                ),
              ],
            ),
          ),
          Step(
            isActive: currentStep >= 1,
            title: const Text(
              "Name",
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            content: TextFormField(
              decoration: const InputDecoration(
                icon: Icon(
                  Icons.approval,
                ),
                hintText: "Full Name",
              ),
            ),
          ),
          Step(
            isActive: currentStep >= 2,
            title: const Text(
              "Phone",
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            content: TextFormField(
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                icon: Icon(Icons.phone),
                hintText: "Phone Number",
              ),
            ),
          ),
          Step(
            isActive: currentStep >= 3,
            title: const Text(
              "Email",
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            content: TextFormField(
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                icon: Icon(Icons.email),
                hintText: "Enter the Email...",
              ),
            ),
          ),
          Step(
            isActive: currentStep >= 4,
            title: const Text(
              "DOB",
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            content: TextFormField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                icon: Icon(Icons.calendar_month_outlined),
                hintText: "Enter the Birth day...",
              ),
            ),
          ),
          Step(
            isActive: currentStep >= 5,
            title: const Text(
              "Gender",
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            content: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Radio(
                      activeColor: Colors.green,
                      value: "Male",
                      groupValue: gender,
                      onChanged: (value) {
                        setState(() {
                          gender = value.toString();
                        });
                      },
                    ),
                    const Text("Male"),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Radio(
                      activeColor: Colors.green,
                      value: "Female",
                      groupValue: gender,
                      onChanged: (value) {
                        setState(() {
                          gender = value.toString();
                        });
                      },
                    ),
                    const Text("Female"),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Radio(
                      activeColor: Colors.green,
                      value: "Others",
                      groupValue: gender,
                      onChanged: (value) {
                        setState(() {
                          gender = value.toString();
                        });
                      },
                    ),
                    const Text("Others"),
                  ],
                ),
              ],
            ),
          ),
          Step(
            isActive: currentStep >= 6,
            title: const Text(
              "Current Location",
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            content: TextFormField(
              decoration: const InputDecoration(
                icon: Icon(Icons.home),
                hintText: "Enter the Address...",
              ),
            ),
          ),
          Step(
            isActive: currentStep >= 7,
            title: const Text(
              "Nationality",
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            content: TextFormField(
              decoration: const InputDecoration(
                icon: Icon(Icons.ac_unit),
                hintText: "Enter the Nationality...",
              ),
            ),
          ),
          Step(
            isActive: currentStep >= 8,
            title: const Text(
              "Religion",
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            content: TextFormField(
              decoration: const InputDecoration(
                icon: Icon(Icons.album),
                hintText: "Enter the Religion...",
              ),
            ),
          ),
          Step(
            isActive: currentStep >= 9,
            title: const Text(
              "Language's",
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            content: TextFormField(
              decoration: const InputDecoration(
                icon: Icon(Icons.language),
                hintText: "Enter the Languages...",
              ),
            ),
          ),
          Step(
            isActive: currentStep >= 10,
            title: const Text(
              "Biography",
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            content: TextFormField(
              decoration: const InputDecoration(
                icon: Icon(Icons.currency_bitcoin_outlined),
                hintText: "Enter the Biography...",
              ),
            ),
          ),
        ],
      ),
    );
  }
}
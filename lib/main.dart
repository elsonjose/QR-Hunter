import 'package:flutter/material.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/services.dart';

void main()
{
  runApp(new MaterialApp(
    debugShowCheckedModeBanner:false ,
  home: MainPage()));
}
  
class MainPage extends StatefulWidget {

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  
  String FinalResult  = "Let's Hunt";
  
  Future _scanQR() async {
    
    try {

      String QRResult = await BarcodeScanner.scan();  
      setState(() {
      FinalResult = "RESULT : "+ QRResult;

      });

    } on PlatformException catch(e)
    {
      if(e.code ==BarcodeScanner.CameraAccessDenied)
      {
        setState(() {
         FinalResult="Camera Permission Denied.";
 
        });
      }
      else{
        setState(() {
          FinalResult="Some Error Occured. { $e }";
 
        });
      }
    }
    on FormatException 
    {
      setState(() {
      FinalResult="Scan Incomplete.";
 
      });
    }
    catch (e)
    {
      setState(() {
      
       FinalResult="Some Error Occured. { $e }";

      });
    }
  }

  @override
  Widget build(BuildContext context) {
   return Scaffold(
     appBar: AppBar(backgroundColor: Color(0xFFF9A825),title: Center(child: Text("QR Hunter")),),
     body: new Center(child: Text(FinalResult),), 
     floatingActionButton: new FloatingActionButton(
      backgroundColor: Color(0xFFF9A825),
      child: Icon(Icons.track_changes), 
      onPressed: ()
      {
        _scanQR();
      }
     ), 
     floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

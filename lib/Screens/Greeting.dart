import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';


class Greeting extends StatefulWidget {
  const Greeting({super.key, this.setFirstTime});
  final setFirstTime;

  @override
  State<Greeting> createState() => _GreetingState();
}

class _GreetingState extends State<Greeting> {
  int _currentPageIndex = 0;
  List<AssetImage> _imageUrls = [AssetImage('assets/Greeting1.png') ,AssetImage('assets/Greeting2.png') , AssetImage('assets/Greeting3.png') ,];
  late Size screenSize = MediaQuery.of(context).size;
  void _nextPage() {
    setState(() {
      _currentPageIndex++;
      if (_currentPageIndex >= _imageUrls.length) {
        // Reset to first page if we've gone through all pages
        widget.setFirstTime();
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: WillPopScope(
          onWillPop: () async {
              if (_currentPageIndex > 0) {
                setState(() {
                  _currentPageIndex--;
                });
                return false;
              }
              return true;
            },
          child: SafeArea(
            child: Container(
              width: screenSize.width,
              height: screenSize.height,
              color: Color.fromARGB(255, 244, 244, 244),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: 20,),
                  // Page indicator
                 ImageIndicator(count: _imageUrls.length, currentIndex: _currentPageIndex),
                    SizedBox(height: 7,),
                  // Image
                  
                 Visibility(
                  visible: _currentPageIndex == 0,
                  child: Column1()),
                 Visibility(
                  visible: _currentPageIndex == 1,
                  child: Column2()),
                 Visibility(
                  visible: _currentPageIndex == 2,
                  child: Column3()),
                  // Buttons
                
                  
                  Column(
                    //crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        child: Container(
                          decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10))),
                          height: 50,
                          width: screenSize.width - 20,
                          
                          child: ElevatedButton(
                            
                            onPressed: _nextPage,
                            child: Text('NEXT'),
                            
                            style: ButtonStyle(
                              
                              backgroundColor: MaterialStatePropertyAll(Colors.black)),
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                           widget.setFirstTime();
                        },
                        child: Text('SKIP', style: TextStyle(color: Colors.black)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
  }
}


class ImageIndicator extends StatelessWidget {
  final int count;
  final int currentIndex;

  const ImageIndicator({
    Key? key,
    required this.count,
    required this.currentIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children:[SizedBox(width: 7,) ,...List.generate(
        count,
        (index) => Container(
          width: 128.0,
          height: 5.0,
          margin: EdgeInsets.fromLTRB(0, 0, 6.8, 0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(50)),
           // shape: BoxShape.circle,
            color: currentIndex >= index ? Colors.black : Colors.grey,
          ),
        ),
      )],
    );
  }
}

class Column1 extends StatelessWidget {
  const Column1({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [Container(
                  height: 380
                  ,
                   decoration: BoxDecoration(image: DecorationImage(
      image: AssetImage('assets/Greeting1.png'),
      fit: BoxFit.fitWidth,
    ),),
                ),
                // Text
            
             Padding(
              padding: EdgeInsets.fromLTRB(35, 0, 35, 0),
              child: Text("Save Money And Support Lebanese Businesses With Fimetlo. Join Now!", style: TextStyle(fontSize: 30 ,fontWeight: FontWeight.bold,color: Colors.black),)),
              SizedBox(height: 10,),
              Text("Saving Made Fun with Fimetlo!", style: TextStyle(fontSize: 16, color: Colors.black),),
              SizedBox(height: 15,)
              ],);
              
  }
}

class Column2 extends StatelessWidget {
  const Column2({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
       Padding(
              padding: EdgeInsets.fromLTRB(35, 5, 35, 5),
              child: Text("With Fimetlo, you can shop with peace of mind knowing that your safety is our top priority!", style: TextStyle(fontSize: 30 ,fontWeight: FontWeight.bold,color: Colors.black),)),
              SizedBox(height: 0,),
              Text("Safety First, Savings Second with Fimetlo!", style: TextStyle(fontSize: 16, color: Colors.black),),
              SizedBox(height: 0,),
      Container(
                  height: 360
                  ,
                   decoration: BoxDecoration(image: DecorationImage(
      image: AssetImage('assets/Greeting2.png'),
      fit: BoxFit.fitWidth,
    ),),
                ),
                // Text
            
                ],);
  }
}
class Column3 extends StatelessWidget {
  const Column3({super.key});

  @override
  Widget build(BuildContext context) {
     return Column(children: [
      SizedBox(height: 10,),
      Container(
                  height: 370
                  ,
                   decoration: BoxDecoration(image: DecorationImage(
      image: AssetImage('assets/Greeting3.png'),
      fit: BoxFit.fitWidth,
    ),),
                ),
                // Text
            Padding(
              padding: EdgeInsets.fromLTRB(35, 0, 35, 0),
              child: Text("Earn Rewards, Support Local with Fimetlo Loyalty Program!", style: TextStyle(fontSize: 30 ,fontWeight: FontWeight.bold,color: Colors.black),)),
              SizedBox(height: 12,),
              Text(" Let's Make A Difference Together!", style: TextStyle(fontSize: 16, color: Colors.black),),
              SizedBox(height: 13,)],);
  }
}
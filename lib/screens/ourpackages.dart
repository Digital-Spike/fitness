import 'package:flutter/material.dart';
class OurPackages extends StatefulWidget {
  const OurPackages({super.key});

  @override
  State<OurPackages> createState() => _OurPackagesState();
}

class _OurPackagesState extends State<OurPackages> {
  List<Widget> plans = <Widget>[
  Text('Single',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),),
  Text('Buddy',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600)),
  
];
  final List<bool> _selectedPlans = <bool>[true, false];
   bool vertical = false;

  


String? value;
  final items = [
   'Standard Plan', 'Special Plan'
  ];
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5E6C2),
      appBar: AppBar(
       backgroundColor: Color(0xffF5E6C2),
        title: const Text('Our Packages',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600,color: Colors.black),),
        leading: const BackButton(color: Colors.black),
        elevation: 0,
        centerTitle: true,
        bottom: PreferredSize(preferredSize: const Size.fromHeight(1.0), child: Container(height: 1.0,color: Colors.black,)),
      ),
      body: Column(
              children: [
                SizedBox(height: 10),
              DropdownButtonFormField(
                
           borderRadius: BorderRadius.circular(10),
                isDense: true,
                style: TextStyle(fontSize: 24,fontWeight: FontWeight.w600,color: Colors.black),
                
                padding: EdgeInsets.all(10),
               decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),fillColor: Colors.white,filled: true),
                items: items.map(buildMenuItem).toList(), onChanged: (value){
                setState(() {
                  this.value = value;
                });
              }),
                SizedBox(height: 10),
                ToggleButtons(
                direction: vertical ? Axis.vertical : Axis.horizontal,
                onPressed: (int index) {
                  setState(() {
                    // The button that is tapped is set to true, and the others to false.
                    for (int i = 0; i < _selectedPlans.length; i++) {
                      _selectedPlans[i] = i == index;
                    }
                  });
                },
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                selectedBorderColor: Colors.red[700],
                selectedColor: Colors.white,
              borderColor: Colors.red,
                fillColor: Color(0xff50E3C2),
                color: Colors.red[400],
                constraints: const BoxConstraints(
                  minHeight: 50.0,
                  minWidth: 180.0,
                ),
                isSelected: _selectedPlans,
                children: plans,
              ),
               SizedBox(height: 10),
      Expanded(
        
        child: ListView.builder(
          
          itemCount: 2,
          itemBuilder: (context, index){
          return  Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.deepOrange[400],),
            
            margin: EdgeInsets.all(10),
            child: ExpansionTile(
              collapsedShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              childrenPadding: EdgeInsets.only(left: 15,right: 15,bottom: 10),
             
              trailing: Text('Price:',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    backgroundColor: Colors.deepOrange[400],
                    collapsedBackgroundColor: Colors.deepOrange[400],
                    title: Row(
                    children: [
                       Text('Number of Sessions:',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),),
                            Text('100',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),)
                    ],
                  ),
                  children: [
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Per Session:',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),),
                            Text('Validity:',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),),
                            
                          ],
                        ),
                        MaterialButton(onPressed: (){},child: Text('Subscription',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600,color: Colors.white),),color: Colors.deepOrange,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),)
                      ],
                    )
                  ],
                  ),
          );
        }),
      ),
     
         ]));
  }
  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
        value: item,
        child: Text(
          item,
          style: const TextStyle(fontWeight: FontWeight.normal, fontSize: 15),
        ),
      );
    
}
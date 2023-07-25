import 'package:fitness/screens/packages.dart';
import 'package:flutter/material.dart';
class OurPackages extends StatefulWidget {
  const OurPackages({super.key});

  @override
  State<OurPackages> createState() => _OurPackagesState();
}

class _OurPackagesState extends State<OurPackages> {
  
 
  List<Widget> plans = <Widget>[
  const Text('Single',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),),
  const Text('Buddy',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600)),
  
];
  final List<bool> _selectedPlans = <bool>[true, false];
   bool vertical = false;
bool isSelectedPlans=false;
  bool single=false;


String? value;
  final items = [
   'Standard Plan', 'Special Plan'
  ];
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5E6C2),
      appBar: AppBar(
       backgroundColor: const Color(0xffF5E6C2),
        title: const Text('Our Packages',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600,color: Colors.black),),
        leading: const BackButton(color: Colors.black),
        elevation: 0,
        centerTitle: true,
        bottom: PreferredSize(preferredSize: const Size.fromHeight(1.0), child: Container(height: 1.0,color: Colors.black,)),
      ),
      body: Column(
              children: [
                const SizedBox(height: 10),
              DropdownButtonFormField(
                hint: const Text('Select Plan'),
           borderRadius: BorderRadius.circular(10),
                isDense: true,
                style: const TextStyle(fontSize: 20,fontWeight: FontWeight.w600,color: Colors.black),
                
                padding: const EdgeInsets.all(10),
               decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),fillColor: Colors.white,filled: true),
                items: items.map(buildMenuItem).toList(), onChanged: (value){
                setState(() {
                  this.value = value;
                  isSelectedPlans=isSelectedPlans;
                });
              }),
                const SizedBox(height: 10),
                ToggleButtons(
                direction: vertical ? Axis.vertical : Axis.horizontal,
                onPressed: (int index) {
                  setState(() {
                    // The button that is tapped is set to true, and the others to false.
                    for (int i = 0; i < _selectedPlans.length; i++) {
                      _selectedPlans[i] = i == index;
                      
                    }isSelectedPlans=!isSelectedPlans;
                  });
                },
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                selectedBorderColor: Colors.red[700],
                selectedColor: Colors.white,
              borderColor: Colors.red,
                fillColor: const Color(0xff50E3C2),
                color: Colors.red[400],
                constraints: const BoxConstraints(
                  minHeight: 50.0,
                  minWidth: 180.0,
                ),
                isSelected: _selectedPlans,
                children: plans,
              ),
               const SizedBox(height: 10),
      Visibility(
        visible: !isSelectedPlans,
        child: Expanded(
          
          child: ListView.builder(
            
            itemCount: 7,
            itemBuilder: (context, index){
            return  Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.deepOrange[400],),
              
              margin: const EdgeInsets.all(10),
              child: ExpansionTile(
                collapsedShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                childrenPadding: const EdgeInsets.only(left: 15,right: 15,bottom: 10),
               
                
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      backgroundColor: Colors.deepOrange[100],
                      collapsedBackgroundColor: Colors.deepOrange[300],
                      title: const Row(
                      children: [
                         Text('Number of Sessions:',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),),
                              Text('2',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),)
                      ],
                    ),
                    children: [
                      Column(
                        children: [
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Price: 359',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),
                             
                              Text('Validity: 15 days',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),),
                              
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                               const Text('Per Session: 169',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),),
                              MaterialButton(onPressed: (){},child: const Text('Subscribe',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600,color: Colors.white),),color: Colors.deepOrange,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),),
                            ],
                          )
                        ],
                      )
                    ],
                    ),
            );
          }),
        ),
      ),
       Visibility(
        visible: isSelectedPlans,
        child: Expanded(
          
          child: ListView.builder(
            
            itemCount: session.length,
            itemBuilder: (context, index){
            return  Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.deepOrange[400],),
              
              margin: const EdgeInsets.all(10),
              child: ExpansionTile(
                collapsedShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                childrenPadding: const EdgeInsets.only(left: 15,right: 15,bottom: 10),
               
                
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      backgroundColor: Colors.deepOrange[400],
                      collapsedBackgroundColor: Colors.deepOrange[400],
                      title: const Row(
                      children: [
                         Text('Number of Sessions: ',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),),
                              Text('2',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),)
                      ],
                    ),
                    children: [
                      Column(
                        children: [
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Price: 398',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),
                             
                              Text('Validity: 15 days',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),),
                              
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                               const Text('Per Session: 199',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),),
                              MaterialButton(onPressed: (){},child: const Text('Subscribe',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600,color: Colors.white),),color: Colors.deepOrange,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),),
                            ],
                          )
                        ],
                      )
                    ],
                    ),
            );
          }),
        ),
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

     var session=['2','4','8','12','24','48','96'];
     var price=['359','652','1248','1788','3096','4800','7599'];
     var persession=['169','163','156','149','129','100','79'];
     var validity=['15 days','15 days','30 days','30 days','60 days','120 days','365 days'];
}


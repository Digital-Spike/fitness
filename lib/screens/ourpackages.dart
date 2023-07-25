import 'package:flutter/material.dart';

class OurPackages extends StatefulWidget {
  const OurPackages({super.key});

  @override
  State<OurPackages> createState() => _OurPackagesState();
}

class _OurPackagesState extends State<OurPackages> {
  List<Widget> plans = <Widget>[
    const Text(
      'Single',
      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
    ),
    const Text('Buddy',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
  ];
  final List<bool> _selectedPlans = <bool>[true, false];
  bool vertical = false;
  bool isSelectedPlans = false;
  bool single = false;

  String? value;
  final items = ['Standard Plan', 'Special Plan'];
  List<String> session = ['2', '4', '8', '12', '24', '48', '96'];
  List<String> price = ['359', '652', '1248', '1788', '3096', '4800', '7599'];
  List<String> persession = ['169', '163', '156', '149', '129', '100', '79'];
  List<String> validity = [
    '15 days',
    '15 days',
    '30 days',
    '30 days',
    '60 days',
    '120 days',
    '365 days'
  ];
  List<String> session1 = ['2', '4', '8', '12', '24', '48', '96'];
  List<String> price1 = ['398', '796', '1552', '2328', '4296', '6240', '9600'];
  List<String> persession1 = ['199', '199', '194', '194', '179', '130', '100'];
  List<String> validity1 = [
    '15 days',
    '30 days',
    '60 days',
    '90 days',
    '160 days',
    '180 days',
    '365 days'
  ];
  var colors = [
    Colors.deepOrange[300],
    Colors.yellow[300],
    Colors.red[200],
    Colors.blue[300],
    Colors.green[300],
    Colors.amber[300],
    Colors.purple[200]
  ];
  var colors1 = [
    Colors.deepOrange[100],
    Colors.yellow[100],
    Colors.redAccent[100],
    Colors.blue[100],
    Colors.green[100],
    Colors.amberAccent[100],
    Colors.purple[100]
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xffF5E6C2),
        appBar: AppBar(
          backgroundColor: const Color(0xffF5E6C2),
          title: const Text(
            'Our Packages',
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.w600, color: Colors.black),
          ),
          leading: const BackButton(color: Colors.black),
          elevation: 0,
          centerTitle: true,
          bottom: PreferredSize(
              preferredSize: const Size.fromHeight(1.0),
              child: Container(
                height: 1.0,
                color: Colors.black,
              )),
        ),
        body: Column(children: [
          const SizedBox(height: 10),
          DropdownButtonFormField(
              hint: const Text('Select Plan'),
              borderRadius: BorderRadius.circular(10),
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black),
              decoration: InputDecoration(
                  isDense: true,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  fillColor: Colors.white,
                  filled: true),
              items: items.map(buildMenuItem).toList(),
              onChanged: (value) {
                setState(() {
                  this.value = value;
                  isSelectedPlans = isSelectedPlans;
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
                }
                isSelectedPlans = !isSelectedPlans;
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
                  itemCount: session.length,
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.deepOrange[400],
                      ),
                      margin: const EdgeInsets.all(10),
                      child: ExpansionTile(
                        collapsedShape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        childrenPadding: const EdgeInsets.only(
                            left: 15, right: 15, bottom: 10),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        backgroundColor: colors1[index],
                        collapsedBackgroundColor: colors[index],
                        title: Row(
                          children: [
                            const Text(
                              'Number of Sessions: ',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w600),
                            ),
                            Text(
                              session[index],
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600),
                            )
                          ],
                        ),
                        children: [
                          Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      const Text(
                                        'Price: ',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Text(
                                        price[index],
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      const Text(
                                        'Validity: ',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Text(validity[index])
                                    ],
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      const Text(
                                        'Per Session: ',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Text(persession[index])
                                    ],
                                  ),
                                  MaterialButton(
                                    onPressed: () {},
                                    color: Colors.deepOrange,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: const Text(
                                      'Subscribe',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white),
                                    ),
                                  ),
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
                  itemCount: session1.length,
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.deepOrange[400],
                      ),
                      margin: const EdgeInsets.all(10),
                      child: ExpansionTile(
                        collapsedShape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        childrenPadding: const EdgeInsets.only(
                            left: 15, right: 15, bottom: 10),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        backgroundColor: colors1[index],
                        collapsedBackgroundColor: colors[index],
                        title: Row(
                          children: [
                            const Text(
                              'Number of Sessions: ',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w600),
                            ),
                            Text(
                              session1[index],
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600),
                            )
                          ],
                        ),
                        children: [
                          Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      const Text(
                                        'Price: ',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Text(price1[index])
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      const Text(
                                        'Validity: ',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Text(validity1[index])
                                    ],
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      const Text(
                                        'Per Session: ',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Text(persession1[index])
                                    ],
                                  ),
                                  MaterialButton(
                                    onPressed: () {},
                                    color: Colors.deepOrange,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: const Text(
                                      'Subscribe',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white),
                                    ),
                                  ),
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
}

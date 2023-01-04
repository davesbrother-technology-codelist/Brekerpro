import 'package:breaker_pro/dataclass/parts_list.dart';
import 'package:breaker_pro/screens/addPart.dart';
import 'package:breaker_pro/screens/customise_parts_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bottom_drawer/bottom_drawer.dart';
import '../dataclass/part.dart';
import '../my_theme.dart';
import 'main_dashboard.dart';

class AllocatePartsScreen extends StatefulWidget {
  const AllocatePartsScreen({Key? key}) : super(key: key);

  @override
  State<AllocatePartsScreen> createState() => _AllocatePartsScreenState();
}

class _AllocatePartsScreenState extends State<AllocatePartsScreen> {
  OutlineInputBorder border = OutlineInputBorder(
      borderRadius: BorderRadius.zero,
      borderSide: BorderSide(width: 2, color: MyTheme.materialColor));
  OutlineInputBorder focusedBorder = OutlineInputBorder(
      borderRadius: BorderRadius.zero,
      borderSide: BorderSide(width: 2, color: MyTheme.blue));
  late List<Part> partsList;
  List<Part> selectedPartsList = [];
  bool selectAll = false;
  String _button = 'None';
  double _headerHeight = 60.0;
  double _bodyHeight = 180.0;
  BottomDrawerController _controller = BottomDrawerController();
  @override
  void initState() {
    partsList = Provider.of<PartsList>(context, listen: false).partList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children:[
        Scaffold(
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          floatingActionButton: Container(
            color: MyTheme.materialColor,
            width: MediaQuery.of(context).size.width,
            child: TextButton(
              onPressed: () {
                PartsList partsList = PartsList();
                partsList.partList = selectedPartsList;
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => MultiProvider(
                      providers: [
                        ChangeNotifierProvider<PartsList>(
                            create: (context) => partsList)
                      ],
                      child: const CustomisePartsScreen(),
                    )));
              },
              child: Text(
                "Customise Parts",
                style: TextStyle(color: MyTheme.white),
              ),
            ),
          ),
          appBar: AppBar(
            title: Text(
              'Allocate Parts',
              style: TextStyle(color: MyTheme.white),
            ),
            elevation: 0,
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: MyTheme.white),
              onPressed: () {
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (ctx) => MainDashboard()));          },
            ),
            actions: [
              IconButton(
                  onPressed: () => {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>AddPart()))
                  },
                  icon: Icon(Icons.add_circle, color: MyTheme.white)),
              IconButton(
                  onPressed: () => {
                    // _controller.open()

                  },
                  icon: Icon(
                    Icons.filter_list,
                    color: MyTheme.white,
                  )),
            ],
          ),
          body:
          Column(
            children: [
              Container(
                color: MyTheme.materialColor,
                padding: EdgeInsets.all(5),
                child: TextField(
                  style: TextStyle(color: MyTheme.materialColor),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: MyTheme.white,
                    border: border,
                    focusedBorder: focusedBorder,
                    enabledBorder: border,
                    prefixIcon: Icon(
                      Icons.search,
                      color: MyTheme.black54,
                    ),
                    labelText: 'Type your keyword here',
                    labelStyle: TextStyle(color: MyTheme.black54),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(bottom: 10),
                child: CheckboxListTile(
                  tileColor: MyTheme.black12,
                  contentPadding: EdgeInsets.zero,
                  controlAffinity: ListTileControlAffinity.leading,
                  value: selectAll,
                  title: const Text(
                    "Select All",
                    textAlign: TextAlign.left,
                  ),
                  onChanged: (bool? value) {
                    setState(() {
                      for (Part part in partsList) {
                        part.isSelected = value!;
                        selectAll = value;
                      }
                    });
                  },
                ),
              ),
              Expanded(
                child: ListView.separated(
                  itemCount: partsList.length,
                  controller: ScrollController(),
                  separatorBuilder: (_, __) => const SizedBox(height: 5),
                  itemBuilder: (context, index) => Container(
                    height: 50,
                    color: Colors.white,
                    child: CheckboxListTile(
                      controlAffinity: ListTileControlAffinity.leading,
                      value: partsList[index].isSelected,
                      secondary: Text(partsList[index].id.toString()),
                      title: Text(partsList[index].partName),
                      onChanged: (bool? value) {
                        partsList[index].isSelected = value!;
                        if (value == true) {
                          selectedPartsList.add(partsList[index]);
                        } else {
                          selectedPartsList.remove(partsList[index]);
                        }
                        setState(() {});
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),


        ),
        // _buildBottomDrawer(context)
      ]
    );
  }
  Widget _buildBottomDrawer(BuildContext context) {
    return BottomDrawer(
      header: _buildBottomDrawerHead(context),
      body: _buildBottomDrawerBody(context),
      headerHeight:0,
      drawerHeight: _bodyHeight,
      color: MyTheme.materialColor,
      controller: _controller,
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.15),
          blurRadius: 60,
          spreadRadius: 0,
          offset: const Offset(0, 0), // changes position of shadow
        ),
      ],
    );
  }

  Widget _buildBottomDrawerHead(BuildContext context) {
    return Container(
      height: _headerHeight,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: 10.0,
              right: 10.0,
              top: 10.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

              ],
            ),
          ),
          Spacer(),
          Divider(
            height: 1.0,
            color: Colors.grey,
          ),
        ],
      ),
    );
  }
  Widget _buildBottomDrawerBody(BuildContext context) {
    return Container(
      width: double.infinity,
      height: _bodyHeight,
      child: SingleChildScrollView(
        child: Column(
          children: [

          ],
        ),
      ),
    );
  }
}

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tigwaal_driver/functions/functions.dart';
import 'package:tigwaal_driver/pages/noInternet/nointernet.dart';
import 'package:tigwaal_driver/pages/vehicleInformations/vehicle_number.dart';
import 'package:tigwaal_driver/styles/styles.dart';
import 'package:tigwaal_driver/translation/translation.dart';
import 'package:tigwaal_driver/widgets/widgets.dart';

class VehicleYear extends StatefulWidget {
  const VehicleYear({Key? key}) : super(key: key);

  @override
  State<VehicleYear> createState() => _VehicleYearState();
}

dynamic modelYear;

class _VehicleYearState extends State<VehicleYear> {
  String dateError = '';
  bool isYear = false;
  var dateTime = DateTime.now().year;
  String? year;
  TextEditingController controller = TextEditingController();
  List<String> years = [
    '2000',
    '2001',
    '2002',
    '2003',
    '2004',
    '2005',
    '2006',
    '2007',
    '2008',
    '2009',
    '2010',
    '2011',
    '2012',
    '2013',
    '2014',
    '2015',
    '2016',
    '2017',
    '2018',
    '2019',
    '2020',
    '2021',
    '2022',
    '2023',
    '2024'
  ];
  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Material(
      child: Directionality(
          textDirection: (languageDirection == 'rtl')
              ? TextDirection.rtl
              : TextDirection.ltr,
          child: Stack(
            children: [
              Stack(
                children: [
                  Container(
                      height: media.height * 1,
                      width: media.width * 1,
                      color: page,
                      child: Column(children: [
                        Container(
                          padding: EdgeInsets.only(
                              left: media.width * 0.08,
                              right: media.width * 0.08,
                              top: media.width * 0.05 +
                                  MediaQuery.of(context).padding.top),
                          color: page,
                          height: media.height * 1,
                          width: media.width * 1,
                          child: Column(
                            children: [
                              Container(
                                  width: media.width * 1,
                                  color: topBar,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      InkWell(
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Icon(Icons.arrow_back)),
                                    ],
                                  )),
                              SizedBox(
                                height: media.height * 0.04,
                              ),
                              SizedBox(
                                  width: media.width * 1,
                                  child: Text(
                                    languages[choosenLanguage]
                                        ['text_vehicle_model_year'],
                                    style: GoogleFonts.roboto(
                                        fontSize: media.width * twenty,
                                        color: textColor,
                                        fontWeight: FontWeight.bold),
                                  )),
                              const SizedBox(
                                height: 10,
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    isYear = true;
                                  });
                                },
                                child: Container(
                                  height: 45,
                                  width: 340,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(width: .2),
                                  ),
                                  child: Center(
                                    child: Text(
                                      year == null
                                          ? languages[choosenLanguage]
                                              ['text_enter_vehicle_model_year']
                                          : year.toString(),
                                      style: TextStyle(
                                          color: Colors.black54,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w800),
                                    ),
                                  ),
                                ),
                              ),
                              // InputField(
                              //   text: languages[choosenLanguage]
                              //       ['text_enter_vehicle_model_year'],
                              //   textController: controller,
                              //   onTap: (val) {
                              //     setState(() {
                              //       modelYear = controller.text;
                              //     });
                              //     if (controller.text.length == 4 &&
                              //         int.parse(modelYear) <=
                              //             int.parse(
                              //                 DateTime.now().year.toString())) {
                              //       setState(() {
                              //         dateError = '';
                              //       });
                              //       FocusManager.instance.primaryFocus?.unfocus();
                              //     } else if (controller.text.length == 4 &&
                              //         int.parse(modelYear) >
                              //             int.parse(
                              //                 DateTime.now().year.toString())) {
                              //       setState(() {
                              //         dateError = 'Please Enter Valid Date';
                              //       });
                              //     }
                              //   },
                              //   color: (dateError == '') ? null : Colors.red,
                              //   inputType: TextInputType.number,
                              //   maxLength: 4,
                              // ),
                              // (dateError != '')
                              //     ? Container(
                              //         margin: const EdgeInsets.only(top: 20),
                              //         child: Text(
                              //           dateError,
                              //           style: GoogleFonts.roboto(
                              //               fontSize: media.width * sixteen,
                              //               color: Colors.red),
                              //         ),
                              //       )
                              //     : Container(),
                              const SizedBox(
                                height: 40,
                              ),
                              // (controller.text.length == 4)
                              //     ? (int.parse(modelYear) <=
                              //             int.parse(DateTime.now().year.toString()))
                              //         ?
                              Button(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const VehicleNumber()));
                                  // setState(() {
                                  //   modelYear = year;
                                  // });
                                  // Timer(Duration(seconds: 1), () {

                                  // });
                                },
                                text: languages[choosenLanguage]['text_next'],
                              )
                              //     : Container()
                              // : Container()
                            ],
                          ),
                        ),
                      ])),

                  //no internet
                  (internet == false)
                      ? Positioned(
                          top: 0,
                          child: NoInternet(
                            onTap: () {
                              setState(() {
                                internetTrue();
                                getUserDetails();
                              });
                            },
                          ))
                      : Container(),
                ],
              ),
              if (isYear == true)
                Padding(
                  padding: EdgeInsets.only(top: 160, left: 30, right: 30),
                  child: Container(
                    height: 260,
                    width: 220,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(width: .2)),
                    child: ListView.separated(
                        itemBuilder: (context, index) => InkWell(
                              onTap: () {
                                setState(() {
                                  year = years[index];
                                  modelYear = year;
                                  isYear = false;
                                });
                                print(year);
                              },
                              child: Container(
                                height: 36,
                                child: Center(
                                  child: Text(
                                    years[index],
                                    style: TextStyle(
                                        color: Colors.black54,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                              ),
                            ),
                        separatorBuilder: (context, index) => SizedBox(
                              height: 10,
                              child: Divider(),
                            ),
                        itemCount: years.length),
                  ),
                )
            ],
          )),
    );
  }
}

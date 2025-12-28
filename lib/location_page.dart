import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math';
import 'child.dart';

enum Gender { male, female}

class LocationPage extends StatefulWidget {
  const LocationPage({super.key});
  @override
  _LocationPageState createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  final TextEditingController _yrController = TextEditingController();  // for year of birth
  final TextEditingController _mnController = TextEditingController();  // for month of birth
  final TextEditingController _dyController = TextEditingController();  // for birth day
  final TextEditingController _wtController = TextEditingController();  // for weight of child kg
  final TextEditingController _lnController = TextEditingController();  // for length of child cm
  final TextEditingController _hcController = TextEditingController();  // for head circumference cm


// Variables to store calculated growth indices
String _Wt_age = ' ';
String _Ln_age = ' ';
String _Hc_age = ' ';
String _BMI_age = ' ';
String _Wt_len = '';
// variables for child's gender, birth date, weight, length, head
 Gender? _gender = Gender.male;
String _yrinit =" السنة";
String _moninit=" الشهر";
String _dayinit=" اليوم";
String _wtinit = ' الوزن كغم';
String _lninit = ' الطول سم';
String _hcinit = ' محيط الرأس';
String _sex = 'M';

//  variables for the age of the child
int _years = 0;
int _months = 0;
int _weeks = 0;
int _days = 0;

// variables for colors of indices
Color cl_wa = Colors.white;
Color cl_la = Colors.white;
Color cl_ba = Colors.white;
Color cl_ca = Colors.white;
Color cl_wl = Colors.white;

@override
void initState() {
  super.initState();
  DateTime _now = DateTime.now();
  int y = _now.year - 1;
  int m = _now.month;
  int d = 15;
  _yrController.text = y.toString();
  _mnController.text = m.toString();
  _dyController.text = d.toString();
  _yrinit = 'السنة'; _moninit='الشهر'; _dayinit = 'اليوم';
  _wtController.text = 9.5.toString();
  _lnController.text = 75.toString();
  _hcController.text = 45.toString();

 _child(y, m, d, 9.5, 75.0, 44.0, _gender!);
    
  } 
  

  // get date year month and day and calculate
  void _getdata(){

    int y = int.tryParse(_yrController.text) ?? 0 ;
    int m = int.tryParse(_mnController.text) ?? 0;
    int d = int.tryParse(_dyController.text) ?? 0;
    double wt = double.tryParse(_wtController.text) ?? 0;
    double ln = double.tryParse(_lnController.text) ?? 0;
    double hc = double.tryParse(_hcController.text) ?? 0;
    _yrinit = 'ادخل السنة'; _moninit='ادخل الشهر'; _dayinit = 'ادخل اليوم';
    _wtinit = 'الوزن كغم'; _lninit = 'الطول سم'; _hcinit = 'محيط الرأس سم ';
    _child(y, m, d, wt, ln, hc, _gender!);
  }      // end of getdata

void _closeApp(){
  if(Platform.isAndroid){
    SystemNavigator.pop();    // android exit
  } else if(Platform.isIOS)  {
    exit(0);
  }
}

// ------------------------------------------------------------------
// BUIL UI 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(title: Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: Colors.greenAccent, // background color for the title box
              borderRadius: BorderRadius.circular(8), // rounded corners
            ),
            child: const Text(' مؤشرات النمو للاطفال (0 الى 61 شهر) اعداد د. محمود خالد',
              style: TextStyle(
                color: Colors.black, // text color
                fontSize: 12, fontWeight: FontWeight.bold,
              ),
            ),
          ),
          centerTitle: true, // optional
          backgroundColor: Colors.blue, // color of the AppBar itself
         actions: [
            IconButton(
             icon: const Icon(Icons.close),
             tooltip: 'خروج',
             onPressed: _closeApp,
            ),
         ],
        ),      // end of AppBar

    body: SingleChildScrollView(
      padding: const EdgeInsets.all(6),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          // =========================
          // Select gender
          // =========================
          const Text(
            '     الجنس  ؟',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 2),

          Row(
            children: [
              Expanded(
                child: RadioListTile<Gender>(
                  title: const Text('ذكر'),
                  value: Gender.male,
                  groupValue: _gender,
                  onChanged: (v) => setState(() => _gender = v),
                ),
             ),

              Expanded(
                 child: RadioListTile<Gender>(
                  title: const Text('أنثى'),
                  value: Gender.female,
                  groupValue: _gender,
                  onChanged: (v) => setState(() => _gender = v),
                ),
              ),
            ],
          ),

          const SizedBox(height: 2),

          // =========================
          // Input info
          // =========================
          const Text(
            '     أدخل تاريخ الولادة الوزن الطول و محيط الرأس في الحقول الزرقاء ',
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          // 6 side-by-side input fields
          Row(
            children: [
              _inputBox('السنة', _yrController, 55.0),
              _inputBox('الشهر', _mnController, 50.0),
              _inputBox('اليوم',_dyController, 50.0),
            ],
          ),
          const SizedBox(height: 8), 
          Row(
            children: [
              _inputBox('الوزن (كغم)',_wtController, 55.0),
              _inputBox('الطول/القامة (سم)',_lnController, 55.0),
              _inputBox('محيط الرأس (سم)',_hcController, 55.0),
            ],
          ),




          const SizedBox(height: 8),

          // =========================
          // Age output
          // =========================
          ElevatedButton(
          onPressed:  _getdata,
          style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.teal) ),
          child: Text("احسب العمر والمؤشرات  ", 
                  style: TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.bold),
           ),
          ),

//          const Text(
//            'Calculated Age',
//            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//          ),

          const SizedBox(height: 4),

          Row(
            children: [
              _outputBox('$_years  سنة'),
              _outputBox('$_months  شهر'),
              _outputBox('$_weeks  اسبوع'),
              _outputBox('$_days  يوم'),
            ],
          ),

          const SizedBox(height: 8),

          // =========================
          // Results + Legend
          // =========================
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // LEFT: Growth indices
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _coloredResult(_Ln_age, cl_la),
                    _coloredResult(_Wt_age, cl_wa),
                    _coloredResult(_Wt_len, cl_wl),
                    _coloredResult(_BMI_age, cl_ba),
                    _coloredResult(_Hc_age, cl_ca),
                  ],
                ),
              ),

              const SizedBox(width: 4),

              // RIGHT: Legend
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'تفسير الالوان',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    _LegendRow(color: Colors.green.withOpacity(1.0), text: 'طبيعي - مثالي'),
                    _LegendRow(color: Colors.green.withOpacity(0.7), text: 'طبيعي - معتدل'),
                    _LegendRow(color: Colors.orange, text: 'فوق او دون الطبيعي '),
                    _LegendRow(color: Colors.red.withOpacity(0.7), text: ' مقلق'),
                    _LegendRow(color: Colors.red.withOpacity(1.0), text: 'فرط او هوان شديد'),                    
                  ],
                ),
              ),
            ],
          ),

          //const SizedBox(height: 32),

        /*  const Center(
            child: Text(
              'Thank you',
              style: TextStyle(fontSize: 16),
            ),
          ),*/
        ],
      ),
    ),
  );
}
 // end of build Widget

Widget _inputBox2(String label,TextEditingController controller, double w ) {
  return Expanded(
    child: Padding(
     padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 4),
      child: TextField(
        style: TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.bold),
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(fontSize:13, fontWeight: FontWeight.bold),
          border: const OutlineInputBorder(),
        ),
        keyboardType: TextInputType.number,
      ),
    ),
  );
}

Widget _inputBox(String label, TextEditingController controller, double w) {
  return Expanded(
    child: SizedBox(
 //       width: w, // 65,
        height: 30,
        child: TextField(
        textAlign: TextAlign.center,
        textAlignVertical: TextAlignVertical.center,
         
        style: TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.bold),
        controller: controller,
        decoration: InputDecoration(filled: true, fillColor: Colors.lightBlue[200],
          labelText: label,
          floatingLabelAlignment: FloatingLabelAlignment.center,
          labelStyle: TextStyle(fontSize:13, fontWeight: FontWeight.bold),
          border: OutlineInputBorder(),
          contentPadding: EdgeInsets.symmetric(horizontal: 2, vertical: 2),
        ),
        keyboardType: TextInputType.numberWithOptions(decimal: true),
        ),
    ),
  );
  }

Widget _outputBox(String value) {
  return Expanded(
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Container(
        height: 30,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.2),
          border: Border.all(color: Colors.blue),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(value, textDirection: TextDirection.rtl,
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
             ),
      ),
    ),
  );
}

Widget _coloredResult(String text, Color color) {
  return Container(
    height: 40,
    width: double.infinity,
    margin: const EdgeInsets.only(bottom: 4),
    padding: const EdgeInsets.all(2),
    decoration: BoxDecoration(
      color: color, 
      border: Border.all(color: Colors.blue),  
      borderRadius: BorderRadius.circular(6),
    ),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(text,
               style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
          ],
      ),
    );
}



  // Helper function to build Result Boxes
  Widget _buildResultBox(String title, String value, Color fill ) {
    return Container(
      //margin: EdgeInsets.only(left:100),
      //width: double.infinity,
      width: double.infinity,
      height:45,
      padding: EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: fill, //grey[100],
        border: Border.all(color: Colors.blue),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          /*Text(
            title,
            //style: TextStyle(fontSize:10),
            textDirection: TextDirection.ltr,
          ),*/
          SizedBox(height: 8),
          Text(value.isNotEmpty ? value : 'No result calculated yet',
            textDirection: TextDirection.rtl,
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

// Helper function to build input boxes for prayer times
  // Helper function to create input fields for
  Widget _buildInputField(String label, TextEditingController controller) {
    return 
      SizedBox(
       
        width: 70,
        height: 40,
        
          child: TextField(
          style: TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.bold),
          controller: controller,
          decoration: InputDecoration(filled: true, fillColor:
                                                      Colors.lightGreen[200],
          labelText: label,
          labelStyle: TextStyle(fontSize:13, fontWeight: FontWeight.bold),
          border: OutlineInputBorder(),
          contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          ),
          keyboardType: TextInputType.numberWithOptions(decimal: true),
        ),
      
      );
    
  }
// ----------------------------------Calculations Start Here

// Function to calculculate prayer times
  
void _child(int year, int month, int day, double weight, double length, double head, Gender gender){

setState((){
List<int> maxdays = [31,28,31,30,31,30,31,31,30,31,30,31];
if(year % 4 == 0){maxdays[1]=29;}

DateTime now = DateTime.now();
int year1 = now.year;
int month1 = now.month;
int day1 = now.day;
double jd1 = julian(year1, month1, day1);
double jd2 = julian(year, month, day);
int age = (jd1 - jd2).toInt();
double diff = jd1 - jd2;
int _year = (diff/365).toInt(); // no. of years
int _month = ((diff - 365*_year)/30.4).toInt(); // no. of months
int _week = ((diff - _year*365 - _month*30.4)/7).toInt(); // no. of weeks
int _day = (diff - _year*365 - _month*30.4 - _week*7).toInt(); // no. of days
if(age>=0 && age<=1856 && month<=12 && month>0 && day>0 && day <=maxdays[month-1] 
         && weight>=1.5 && length>=35 && head>20 ){ 
  _years = _year; _months = _month; _weeks = _week; _days = _day;
  double L = 0.0; double M = 0.0; double S = 0.0; double z = 0.0;
  if (gender == Gender.male) {
      _sex = 'M';
    } else {
      _sex = 'F';
    }
  bool boy = false;
  bool girl = false;
  if(_sex == 'M' || _sex == 'm'){boy = true;}
  if(_sex == 'F' || _sex == 'f'){girl = true;}
  // ------------------------------- BOYS --------------------------
  if(boy){
      // wt-age z- score
      L = boys(age, length, 'waL'); //wfa_boys_L[age];
      M = boys(age, length, 'waM'); //wfa_boys_M[age];
      S = boys(age, length, 'waS'); //wfa_boys_S[days];
      z = Zscore(weight, L, M, S);
      cl_wa = col(z);
      _Wt_age = '  الوزن/العمر ${z.toStringAsFixed(2)}';

      // BMI-age 
      L = boys(age, length, 'baL'); 
      M = boys(age, length, 'baM'); 
      S = boys(age, length, 'baS');
      double BMI = weight/(length*length*1.0e-4);
      z = Zscore(BMI, L, M, S);
      cl_ba = col(z);
      _BMI_age = '  كتلة الجسم/العمر ${z.toStringAsFixed(2)}';

      // Length/Height - age
      L = 1.0; 
      M = boys(age, length, 'laM'); 
      S = boys(age, length, 'laS');
      z = Zscore(length, L, M, S);
      _Ln_age = '  الطول(قامة)/العمر ${z.toStringAsFixed(2)}';
      cl_la = col(z);

      // Head Circumference - age
      L = 1.0; 
      M = boys(age, length, 'hcaM'); 
      S = boys(age, length, 'hcaS');
      z = Zscore(head, L, M, S);
      _Hc_age = "  محيط الراس/العمر ${z.toStringAsFixed(2)}";
      cl_ca = col(z);

      // Weight - length(height)
      double diff = length - length.toInt();
      if(diff<0.25){length = length.floor().toDouble();}
      if(diff>= 0.25 && diff<0.75){length = length.floor() + 0.5;}
      if(diff>= 0.75){length = length.round().toDouble();}
      L = -0.3521;
      M = boys(age, length,'wlM');
      S = boys(age, length,'wlS');
      z = Zscore(weight, L, M, S);
      _Wt_len = '  الوزن/الطول(قامة) ${z.toStringAsFixed(2)}';
      cl_wl = col(z);
  } // end of boy function
  // --------------------------------- GIRLS ------------------------------
  if(girl){
      // wt-age z- score
      L = girls(age, length, 'waL'); //wfa_girls_L[age];
      M = girls(age, length, 'waM'); //wfa_girls_M[age];
      S = girls(age, length, 'waS'); //wfa_girls_S[days];
      z = Zscore(weight, L, M, S);
      _Wt_age = '  الوزن/العمر ${z.toStringAsFixed(2)}';
      cl_wa = col(z);

      // BMI-age 
      L = girls(age, length, 'baL'); 
      M = girls(age, length, 'baM'); 
      S = girls(age, length, 'baS');
      double BMI = weight/(length*length*1.0e-4);
      z = Zscore(BMI, L, M, S);
      _BMI_age = '  كتلة الجسم/العمر ${z.toStringAsFixed(2)}';
      cl_ba = col(z);

      // Length/Height - age
      L = 1.0; 
      M = girls(age, length, 'laM'); 
      S = girls(age, length, 'laS');
      z = Zscore(length, L, M, S);
      _Ln_age = '  الطول(قامة)/العمر ${z.toStringAsFixed(2)}';
      cl_la = col(z);
    
      // Head Circumference - age
      L = 1.0; 
      M = girls(age, length, 'hcaM'); 
      S = girls(age, length, 'hcaS');
      z = Zscore(head, L, M, S);
      _Hc_age = "  محيط الراس/العمر ${z.toStringAsFixed(2)}";
      cl_ca = col(z);
    
      // Weight - length(height)
      double diff = length - length.toInt();
      if(diff<0.25){length = length.floor().toDouble();}
      if(diff>= 0.25 && diff<0.75){length = length.floor() + 0.5;}
      if(diff>= 0.75){length = length.round().toDouble();}
      L = -0.3833;
      M = girls(age, length,'wlM');
      S = girls(age, length,'wlS');
      z = Zscore(weight, L, M, S);
      _Wt_len = '  الوزن/الطول(قامة) ${z.toStringAsFixed(2)}';
      cl_wl = col(z);
      }
    }  else {
      _Ln_age = ' ';
      if(head<=20){_Ln_age = 'محيط الرأس ؟؟';}
      if(weight<1.5){_Ln_age = 'الوزن ؟؟';}
      if(length<40){_Ln_age = 'الطول ؟؟';}
      if(age<0 || age>1856 || month>12 || month<=0 || day<=0 || day>maxdays[month-1]){_Ln_age ='خطأ في التاريخ';}
      if(gender == null){_Ln_age = 'لم يتم اختيار الجنس';}
      _BMI_age = ' ';
      _Wt_len = ' ';
      _Hc_age = ' ';
      _Wt_age = ' ';
          }
  });  // end of setState

  }  // end of  function
// function color of indices
  Color col(double z){
     Color ca = Colors.grey;  // to avoid null
      if(z>= -0.25 && z<= 0.25){ca = Colors.green.withOpacity(1.0);}
      if((z<-0.25 && z>=-1.0) || (z>0.25 && z<=1.0) ){ca = Colors.green.withOpacity(0.7);}
      if((z<-1.0 && z>-2.0 ||(z>1.0 && z<2.0))){ca = Colors.orange;}
      if((z<=-2) && z>-3.0 ||(z>=2.0 && z<3.0)){ca = Colors.red.withOpacity(0.7);}
      if((z<=-3.0) || z>=3.0){ca = Colors.red.withOpacity(1.0);}
      return ca;
  }

                            


} // END OF WIDGET build


//       This legend constructor does not accept colors with
//          variable intensity (i.e. using Color.red.withOpacity for example)
class _LegendRow extends StatelessWidget {
   final Color color;
   final String text;

  const _LegendRow({required this.color, required this.text, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          Container(width: 30, height: 18, color: color),
          const SizedBox(width: 8),
          Text(text, 
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
        ],
      ),
    );
  }
}       

// This legend constructor accepts variable intensity colors !!!! good
/*class _LegendRow extends StatelessWidget {
  final Color color;
  final String text;

  const _LegendRow({
    required this.color,
    required this.text,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          Container(
            width: 16,
            height: 16,
            decoration: BoxDecoration(
              color: color, // 👈 opacity preserved
              border: Border.all(color: Colors.black26),
            ),
          ),
          const SizedBox(width: 8),
          Text(text),
        ],
      ),
    );
  }
}
*/
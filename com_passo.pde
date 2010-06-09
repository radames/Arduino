#define NM 100 //maximum number for simple average
#define NP 10 //number of possibilities
#define err 5 //error number
#define NL 4 //line numbers

//float vals[NP]={171, 215, 293, 321, 417, 456, 484, 591, 655, 693}; // possible values
//int keys[NP]={B0001,B0011,B0101,B0010,B0110, B1001, B0100, B1010,B1100, B1000};

float vals[NP]={
  161,  210,  290,  320,  410,   452,   480,   590,  655,   693}; // possible values
int keys[NP]=  {
  B0001,B0011,B0101,B0010,B0110, B1001, B0100, B1010,B1100, B1000};

int anPort[NL]={
  5,4,3,2}; //portas analogicas onde os pads estao conectos ao arduino
// onde a prta 5 é o primeiro pad em relacao ao arduino, os mais perto

float an[NL]={
  0,0,0,0}; //analog port reading
float cal[NL]={
  0,0,0,0}; //calibration

void setup(){
  for(int p=0; p < NL ; p++){
    for(int i=0;i<NM;i++){
      cal[p]+=analogRead(anPort[p]);
    }
    cal[p]=cal[p]/NM;
  }
  // calibration factor afeter NM measurements

  Serial.begin(19200); //Serial port for debuging
}


void loop(){


  for(int p=0; p < NL ; p++){
    for(int i=0;i<NM;i++){
      an[p]+=analogRead(anPort[p]);
    }

    an[p]=abs(an[p]/NM-cal[p]); //NM measurements less calibration factor
  }

  /*for(int p=0; p < NL ; p++){
   Serial.print(an[p]); 
   Serial.print(" ");
   
   }*/



  for(int p=0; p < NL ; p++){
    int idx = search(an[p]); //idx index result where is the number in the array
    // Serial.print(an0); //print analog value
    // Serial.print(" ");
    if(idx==-1){
      Serial.print(0,BIN); //print 0 if idx is -1, it means not found
      Serial.print(",");
    }
    else{
      Serial.print(keys[idx],BIN); //print the corresponding value
      Serial.print(",");
    }
  }
  Serial.println();
  delay(10);

}


/* binary search non exact */

int search(float value){
  int low = 0;
  int high = NP;

  while (low <= high) {
    int mid =low + (high-low) / 2;
    if (value < vals[mid]-err){ //here a trick for the unstable number value, so there is a error possibility
      high = mid - 1;
    }
    else if(value >vals[mid]+err){
      low = mid +1;
    }
    else{
      return mid;
    }
  }
  return -1;


}





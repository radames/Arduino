#define NM 100 //maximum number for simple average
#define NP 10 //number of possibilities
#define err 3 //error number

float vals[NP]={
  171,  215,  293,  321,  417,   456,   484,   591,  655,   693}; // possible values
int keys[NP]={
  B0001,B0011,B0101,B0010,B0110, B1001, B0100, B1010,B1100, B1000};


float an0=0; //analog port reading
float cal=0; // calibration

void setup(){

  for(int i=0;i<NM;i++){
    cal+=analogRead(0);
  }
  cal=cal/NM;  // calibration factor afeter NM measurements 

  Serial.begin(19200); //Serial port for debuging
}


void loop(){
  for(int i=0;i<NM;i++){
    an0+=analogRead(0);
  }
  an0=abs(an0/NM-cal); //NM measurements less calibration factor

  int idx = search(an0); //idx index result where is the number in the array

  //  Serial.print(an0); print analog value
  // Serial.print(" "); 

  if(idx==-1){
    Serial.print(0,BIN); //print  0 if idx is -1, it means not found

  }
  else{ 
    Serial.print(keys[idx],BIN); //print the corresponding value
  }
  Serial.println();
  delay(10);

}




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




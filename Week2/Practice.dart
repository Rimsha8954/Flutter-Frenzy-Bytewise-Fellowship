/// dart:core
import 'dart:io';

main() {
  var firstName = 'Rimsha';
  var lastName = 'Ashraf';

  print(firstName + ' ' + lastName);

  stdout.writeln('Whats your name?');
  var name = stdin.readLineSync();

  print('My name is $name');

  var s1 = 'Here you go xyz';
  var s2 = "Start learning dart concepts";
  var s3 = 'It\'s an amzaing language';
  var s4 = 'It is very easy language';

  print(s1);
  print(s2);
  print(s3);
  print(s4);
  print('');

  // convert string -> integer

  var one = int.parse('1');
  assert(one == 1);
  var onepointone = double.parse('1.1');
  assert(onepointone == 1.1);

  // convert integer -> string

  String oneAsString = 1.toString();
  assert(oneAsString == '1');

  const aConstNum = 0;
  const aConstbool = true;
  const aConstString = 'Hello';

  print(aConstNum);
  print(aConstbool);
  print(aConstString);

  print(aConstNum.runtimeType);
  print(aConstbool.runtimeType);
  print(aConstString.runtimeType);

  /*class Num {
  var num = 10;
}

main() {
  var n = Num();
  var number = n?.num;

  print(number);
}

 class Num{
  var num = 10;
  
}
main()
{
  var n;
  var number = n?.num ?? 0;
  
  print(number);
  
} */

/*
//Ternary Operator

void main(){
  int x = 45;
  var result = x%2==0 ? 'Even' : 'Odd';
  print(result);
}


//Type Test Operator

void main(){
  
  var x = 20;
   if(x is int);
     print('integer');
  
}
//if else statement

void main(){
  
  
  int number = 45;
  
  if(number%2==0){
    print('Even');
  }
  else if(number%3==0){
    print('Odd');
  }
  else{
    print('Undefined');
  }
}

//Standard for loop

void main(){
  
  for(int i=10;i>=1;i--){
    print(i);
  }
  
  print('\n\n');
 
  
  //for-in loop
  var number = [1,2,3];
  
  for(var n in number){
    print(n);
  }
  print('\n\n');
  
  //for-each loop
  var nums = [1,2,3,4,5,6];
  
  nums.forEach((n) => print(n));
}

//Do-While loop

void main(){
  
  int num = 15;
  do{
    print(num);
    num-=1;
  }while(num>=1);
}

// break and continue statement

void main(){
  
  for(var x=1;x<25;x++){
    if(x%2==0) continue;
    print('Odd: $x');
  }
}

// list, set and map

void main(){
  
  
  List names = const['John', 'Nathmie','Tania','Jorge','Genifar'];
  
  
  for(var n in names){
  print(n);}
  print(names.length);
  
  print('\n\n');
  
  
  //set
  
  var names2 = {'florine','chlorine','nitrogen','nitrogen','oxygen'};
  for(var n in names2){
      print(n);

  }
  
    print('\n\n');

  //Map is a collection of key value pair of items and in python it is called dictonary
  
  var gifts = {
    // keys:   Values
    1:     'Watch',
    2:     'Ring',
    3:     'Necklace',
    4:     'Perfume'
  };
  
  print(gifts[3]);
  
} */

// Function

/* void main(){
  showOutput(square(2));
  showOutput(square(2.5));
}

dynamic square(var num){
  return num*num;
}

// instead of this we can also write like this using arrow function

// dynamic square(var num) => num*num;

void showOutput(var msg){
  print(msg);
} 

void main(){
  
  var list = ['chris','alexendra','john','abraham'];
  
  // Anonymus Function
  
  list.forEach((item){
     print(item);
  });
} 

/* There are two types of parameters in dart programming language one type of parameter 
 is called positional parameter and other is called named parameter*/ 


// Positional Parameter
void main(){
  
  print(sum(56,14));
}

dynamic sum(num1 , num2) => num1 + num2; 

// Named Parameters
  void main(){
  
  print(sum(num1: 36));
  Print(sum(num1:10, num2: 5));
}

dynamic sum({var num1 ,var num2=0}) => num1 + num2;

//Classes
// In dart Programming Language we can create a custom type using a class keyword.
//Basically class is a blueprint for actual object

class person{
  
  String name = 'Rimsha';
  int age = 22;
  
  void showOutput(){
    print(name);
    print(age);
  }
}

void main(){
  
  person person1 = person();
  person1.showOutput();
  
}

// Using Constructor

class person{
  
  String name;
  int age;
  
  person(this.name, [this.age=18]);
  
  void showOutput(){
    print(name);
    print(age);
  }
}

void main(){
  
  person person1 = person('Rimsha');
  person1.showOutput();
  
}



class vehicle{
  
  String model;
  int year;
  
  vehicle(this.model , this.year){
    print(this.model);
    print(this.year);
  }
  
  void showOutput(){
    print(model);
    print(year);
  }
}

class car extends vehicle{
  
  double price;
  
  car(String model, int year, this.price) : super(model,year);
  
  void showOutput(){
    
    super.showOutput();
    print(price);
  }
}

void main(){
  var car1 = car('TOYOTA',2015,7500000);
  car1.showOutput();
}
 */
}

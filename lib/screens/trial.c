#include<stdio.h>
int main(){
      int  num1, num2, result;
      char oper;
      printf("Key in num1\n");
      scanf("%d", &num1);
      printf("Key in num2\n");
      scanf("%d", &num2);
      printf("Arithmetic operator\n");
      scanf("%d", oper);

      switch (oper)
      {
        case'+':{printf("Result: %d\n", num1+num2);}
          break;
        case'-':{printf("Result: %d\n", num1-num2);}
          break;
        case'*':{printf("Result: %d\n", num1*num2);}
          break;
        case'/':{printf("Result: %d\n", num1/num2);}
          break;
        case'%':{printf("Result: %d\n", num1%num2);}
          break;
        
      
      default:{printf("Wrong operator:\n");}
          break;
      }

}
//https://stackoverflow.com/questions/24566232/computing-fractional-exponents-in-c
//Thanks David!
#include <stdio.h>
#include <iostream>
using namespace std;

int main(){
	int i;
	int temp;
	int j = 1;
	int k = 1;
	for (i = 0; i < 10; i ++){
		cout << j << endl;
		temp = j;
		j = j + k;
		k = temp;
	}
}

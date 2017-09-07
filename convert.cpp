/*************************************************************************
	> File Name: convert.cpp
	> Author: 
	> Mail: 
	> Created Time: 2017年09月06日 星期三 08时45分07秒
 ************************************************************************/

#include <cmath>
#include <sstream>
#include <iterator>
#include <iostream>
#include <algorithm>
using namespace std;


int main(int argc, char** argv)
{
    cout<<"test int convert"<<endl;
	cout<<pow(10, 0)<<endl;
	int arrs[25] = {0};
	
	long value = 34598238409523;
	int index = 0;
	int total = 0;
	int rem = 0;
	do
	{
		int temp = pow(10, 1);
		arrs[index++] = value % temp;
		cout<<"rem = "<<arrs[index - 1]<<endl;
		value /= temp;
		cout<<"value = "<<value<<endl;
	}while(value > 9);
	arrs[index++] = value;
	copy(arrs, arrs + index, ostream_iterator<int>(cout, "  "));
	cout<<endl;
	//cout<<value<<" / 10 = "<< (value / 10)<<endl;
	//cout<<value<<" % 10 = "<< (value % 10)<<endl;
    return 0;
}

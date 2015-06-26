//
//  strauoDe.cpp
//  partLoadImage
//
//  Created by cts on 09/06/15.
//  Copyright (c) 2015 asdasdsd. All rights reserved.
//

#include "strauoDe.h"

#include <iostream>


void callee (void)
{
    unsigned char cOne = 64;
    
    //Implementtaion defined: truncation if  achar has only 8 bits
    unsigned char cTwo = 1256;//Implicit conversion from "int" to "unsigned char" changes value from 1256 to 232
    
    std::cout << "cOne" << cOne << std::endl;
    std::cout << "cTwo" << cTwo << std::endl;
}


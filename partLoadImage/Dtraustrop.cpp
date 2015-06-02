//
//  Dtraustrop.cpp
//  partLoadImage
//
//  Created by cts on 19/05/15.
//  Copyright (c) 2015 asdasdsd. All rights reserved.
//

#include "Dtraustrop.h"
#include <iostream>
#include <list>
#include <vector>
#include <list>
#include <map>
#include <unordered_map>
#include <algorithm>
#include <iosfwd>
#include <ios>
#include <thread>
#include <libkern/OSAtomic.h>
#include <dispatch/dispatch.h>
#include <exception>


class Vector
{
private:
    double* elem;
    int sz;
    
public:
    Vector(int s):elem{new double[s]},sz{s}
    {
        for(int i; i != s; ++i)
        {
            this->elem[i] = 0;
        }
    
    }
    
    Vector(std::initializer_list<double> lst):
    elem{new double[lst.size()]},
    sz{static_cast<int>(lst.size())}
    {
        std::copy(lst.begin(),lst.end(),this->elem);
    }
    
    ~Vector()
    {
        delete [] this->elem;
    }
    
    //COPY CONSTRUCTOR
    Vector(const Vector& a)
    :elem{new double[a.sz]},
    sz{a.sz}
    {
        for(int i = 0; i!= this->sz ; ++i)
        {
            this->elem[i] = a.elem[i];
        }
    }
    
    //OVERLOAD ==
    Vector& operator=(const Vector& a)
    {
        double* p = new double[a.sz];
        
        for(int i = 0; i != a.sz; ++i)
        {
            p[i] = a.elem[i];
        }
        
        delete [] this->elem;
        
        this->elem = p;
        this->sz = a.sz;
        
        return *this;
    }
    
    double& operator[](int i)
    {
        return this->elem[i];
    }
    int size() const
    {
        return this->sz;
    }
};

class Container
{
public:
    //pure virtual function
    virtual double& operator[](int) = 0;
    
    virtual int size() const = 0;
    
    virtual ~Container(){}
};

void use (Container& c)
{
    const int sz = c.size();
    
    for(int i; i != sz; ++i)
    {
        std::cout << c[i] << std::endl;
    }
}

class Vector_Container : public Container
{
    Vector v;
    
public:
    Vector_Container(int s):v(s){};
    
    Vector_Container
    (std::initializer_list<double> lst):
    v({static_cast<double>(lst.size())})
    {
        this->v = lst;
    }
    
    ~Vector_Container(){};
    
    double& operator[](int i)
    {
        return v[i];
    }
    
    int size() const
    {
        return v.size();
    }
    
};

void g()
{
    Vector_Container vc{10,9,8,7,6,5,4,3,2,1,0};
    
    use(vc);
}

class List_Container: public Container
{
    std::list<double> ld; //list of doubles
    
public:
    List_Container(){};
    List_Container
    (std::initializer_list<double> il):ld{il}{};
    
    ~List_Container(){};
    
    double& operator[](int i);
    
    int size(void) const
    {
        return static_cast<int>(this->ld.size());
    }
};

double& List_Container::operator[](int i)
{
    for(auto& x: this->ld)
    {
        if(i==0)
        {
            return x;
        }
        
        --i;
    }
    
    throw std::out_of_range("List_Container");
}

void h(void)
{
    List_Container lc = {10,9,8,7,6,5,4,3,2,1,0};
    
    use(lc);
}

///VARIADIC TEMPLATES

template <typename T>
void g(T x)
{
    std::cout << x << " ";
}

template <typename T, typename... Tail>
void f(T head,Tail... tail);
template <typename T, typename... Tail>
void f(T head,Tail... tail)
{
    g(head); // do something
    
    //f(tail...);
    
    std::cout << head << std::endl;
    
}

void f() {} // do nothing
std::string compose (const std::string& name,
                     const std::string& domain);


#pragma mark
#pragma mark Strings

using namespace std;

#include <string>

std::string compose (const std::string& name,
                     const std::string& domain)
{
    return name + "@" + domain;
}

void m3(string& s1, string& s2)
{
    
    s1 = s1 +"\n";
    
    s2 += "\n";
    
    std::string name = "Niels Stroustrup";
    
    //s = "Stroustrup"
    std::string s = name.substr(6,10);
    
    //name becomes "NICHOLAS Stroustrup"
    name.replace(0,5,"NICHOLAS");
    
    name[0] = std::toupper(name[0]);
}

struct Entry
{
    string name;
    int number;
};

ostream& operator<<(ostream& os, const Entry& e)
{
    return os << "{\"" << e.name << "\"" <<
    e.number <<"}";
}

istream& operator>>(istream& is , Entry& e)
{
    char c, c2;
    
    if (is >> c &&
        c ==
        '{' && is >> c2 && c2=='"'
        
        )
    {
        string name;
        
        while (is.get(c) && c!= '"')
        {
            name += c;
        }
        
        if (is >> c && c==',')
        {
            int number = 0;
            
            if (is >> number >> c && c=='}')
            {
                e = {name,number};
                return is;
            }
        }
    }
    
    is.setf(ios_base::failbit);
    
    return is;
}

/**
 *  STL Containers
 */
std::vector<Entry> phone_book =
{
    {"David hume", 123456},
    {"Karl Popper",2345667},
    {"Bertrand Arthur William Russell",3441323}
};

void print_book(const vector<Entry>& book)
{
    for (int i = 0; i != book.size(); ++i)
    {
        std::cout << book[i] << std::endl;
    }
}

/**
 *  LINKED LIST
 */
std::list<Entry>phone_list =
{
    {"David hume", 123456},
    {"Karl Popper",2345667},
    {"Bertrand Arthur William Russell",3441323}
};

//travel the tree
int get_number(const string& s)
{
    for (const auto& x : phone_list)
    {
        if (x.name == s)
        {
            return x.number;
        }
    }
    
    return 0;
}

//iterators
int get_number_iterator(const string& s)
{
   
    for (auto p = phone_list.begin();
         p != phone_list.end();
         ++p)
    {
        if (p->name == s)
        {
            return p->number;
        }
    }
    
    return 0;
}

///**
// *  MAP
// */
//std::map<string, int> phone_book_map =
//{
//    {"David Hume",123456},
//    {"Karl Popper",234567},
//    {"Bertrand Arthur William Russell",345678}
//};
//
//int get_number_from_map(const string& s)
//{
//    return  phone_book_map[s];
//}
//
//
///**
// *  unordered_map
// *
// * hashed contaners
// */
//std::unordered_map<string, int>phone_book_unordered_map =
//{
//    {"David Hume",123456},
//    {"Karl Popper",234567},
//    {"Bertrand Arthur William Russell",345678}
//};
//
//int
//get_number_from_unordered_map
//(const string& s)
//{
//    return  phone_book_map[s];
//}
//
//
//void f_
//(std::vector<Entry>& vec,std::list<Entry&> lst)
//{
//    std::sort(vec.begin(), vec.end());
//    std::unique_copy(vec.begin(),
//                     vec.end(),
//                     lst.begin);
//}
//
//
///**
// *  find all
// */
//std::vector<string::iterator>
//find_all(string& s, char c)
//{
//    std::vector<string::iterator> res;
//    
//    for (auto p = s.begin(); p != s.end(); ++p)
//    {
//        if (*p == c)
//        {
//            res.push_back(p);
//        }
//    }
//    
//    return res;
//}
//

void readWrite (void)
{
    string from, to;
    std::cin >> from >> to;
    
    //std::ifstream is {from};
    //istream_iterator<string> ii{is};
    istream_iterator<string> eos {};
//
//    ofstream os{to};
//    std::ostream_iterator<string> oo {os ,"\n"};
//    
//    std::vector<string> b = {ii,eos};
//    
//    sort(b.begin(), b.end());
//    
//    unique_copy(b.begin(),
//                b.end(),
//                oo);
//    
//    return !is.eof() || !os;
}

void _f_(void)
{
    std::cout << "Hello\n";
}

struct FF
{
    void operator()(void)
    {
        std::cout << "Paralle World! \n";
    }
};



void f_to_passing_arg(std::vector<double>& v);

struct F_arg_pass
{
    //instance var
    vector<double>& v;
    
    //constructor
    F_arg_pass(vector<double>& vv) : v{vv}{};
    
    //function object
    void operator()(void);
};


//void threadCall (void)
//{
//    vector<double> some_vec = {1,2,3,4,5,6,7,8,9};
//    vector<double> vec2 =   {10,11,12,13,14};
//    
//    thread t1 {f_to_passing_arg,(some_vec)};
//    thread t2 {F_arg_pass(vec2)};
//    
//    t1.join();
//    t2.join();
//}





int mainCall (void)
{
    
    
//    std::thread t1 {_f_};
//    
//    std::thread t2 {FF()};
//    
//    t1.join();
//    t2.join();
    
    
    
    readWrite();
    
    std::cout << "first: ";
    
    f(1,2.2,"hello");
    
    std::cout << "\nsecond: ";
    
    f(0.2,'c',"yuck!",0,1,2);
    
    std::cout << "\n";
    
    /**
     *  STRING
     */
    auto addr = compose("dmr", "bell-labs.com");
    
    std::string str1 = "anger";
    std::string str2 = "management";
    
    m3(str1, str2);
    
    /**
     *  vector
     */
    phone_book.push_back({"Gbni Popper",123133});
    
    //index check does not throw out of range exception
    //at() - does
    int i = 0;
    i =
    phone_book[phone_book.size()].number;
    
    try
    {
        int j = 0;
        j =
        phone_book.at(phone_book.size()).number;
    }
    catch (std::out_of_range)
    {
        std::cout << "range error\n";
        
    }
    catch (std::exception& exp)
    {
        std::cout << exp.what();
    }
    catch (...)
    {
         std::current_exception();
    }
    
    
    
    return 0;
}




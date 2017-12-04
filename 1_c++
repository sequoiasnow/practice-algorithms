//
//  main.cpp
//  practoce
//
//  Created by Alden Perrine on 10/20/17.
//  Copyright © 2017 Alden Perrine. All rights reserved.
//

#include <iostream>
#include <vector>
#include <iterator>
#include <stack>
#include <queue>
#include <unordered_set>
#include <map>

using namespace std;

class avt_node
{
public:
    avt_node* right;
    avt_node* left;
    int key;
    int val;
    int weight;
};

class avt_tree
{
public:
    avt_tree();
    avt_tree(const avt_tree& other);
    avt_tree& operator=(const avt_tree& other);
    ~avt_tree();
    int find(int key);
    void insert(int key, int val);
    void del(int val);
    void print_tree();
private:
    avt_node* delete_val(avt_node* p, int val);
    avt_node* insert_pair(avt_node* p, int key, int val);
    avt_node* left_rotate(avt_node* p);
    avt_node* right_rotate(avt_node* p);
    int calculate_weight(avt_node* p);
    int search_tree(avt_node* p, int key);
    void remove_tree(avt_node* p);
    avt_node* copy_tree(avt_node* p);
    void tree_out(avt_node* p);
    
    avt_node* root;
};

void dykstra(int a[][4], int n, int s);

int partition(int* a, int n);
void quicksort(int* a, int n);

void merge(int* a1, int n1, int* a2, int n2);
void mergesort(int* a, int n);

void heapsort(int* a, int n);

int max(int a, int b);

int main(int argc, const char * argv[]) {
    
    /*
    int n = 12;
    int a[] = {12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1};
    for(int i = 0; i < n; ++i)
        std::cout << a[i] << " ";
    std::cout << "\n";
    mergesort(a, n);
    for(int i = 0; i < n; ++i)
        std::cout << a[i] << " ";
    std::cout << "\n";
    */
    
    avt_tree tree;
    tree.insert(3, 7);
    tree.insert(6, 4);
    tree.insert(9, 1);
    tree.insert(4, 6);
    tree.insert(2, 8);
    tree.insert(1, 9);
    tree.insert(5, 5);
    tree.insert(8, 2);
    tree.insert(7, 3);
    tree.print_tree();
    
    /*
    double x = 4.35;
    int n = x * 100;
    cout << n << endl;
    */
    /*
    int a[4][4] = {{0, 10, 2, 7}, {10, 0, 0, 2}, {2, 0, 0, 2}, {7, 2, 2, 0}};
    dykstra(a, 4, 0);
    int n;
    cin >> n;
    int b[n];
    for(int i = 0; i < n; ++i)
        b[i] = i;
     */
    return 0;
}

void dykstra(int a[][4], int n, int s)
{
    int* o = new int[n];
    unordered_set<int> nodes;
    for(int i = 0; i < n; ++i)
        nodes.insert(i);
    for(int i = 0; i < n; ++i)
        o[i] = INT32_MAX;
    o[s] = 0;
    while(!nodes.empty())
    {
        int node = 0;
        int dist = INT32_MAX;
        unordered_set<int> :: iterator it;
        for(it = nodes.begin(); it != nodes.end(); it++)
            if(o[(*it)] < dist)
            {
                node = *it;
                dist = o[(*it)];
            }
        nodes.erase(node);
        for(it = nodes.begin(); it != nodes.end(); it++)
        {
            int proc = (*it);
            if(a[node][proc] > 0)
            {
                if(o[proc] > dist + a[node][proc])
                    o[proc] = dist + a[node][proc];
            }
        }
    }
    for(int i = 0; i < n; ++i)
        cout << "(" << i << " : " << o[i] << ") ";
    cout << endl;
    delete [] o;
}

void avt_tree::print_tree()
{
    tree_out(root);
    cout << endl;
}

void avt_tree::tree_out(avt_node* p)
{
    if(p==nullptr)
        return;
    tree_out(p->left);
    cout << "(" << p->key << ", " << p->val<< ") ";
    tree_out(p->right);
}

void avt_tree::insert(int key, int val)
{
    root = insert_pair(root, key, val);
}

avt_node* avt_tree::insert_pair(avt_node* p, int key, int val)
{
    if(p==nullptr)
    {
        avt_node* n = new avt_node;
        n->key = key;
        n->val = val;
        n->right = nullptr;
        n->left = nullptr;
        n->weight = 0;
        return n;
    }
    else if(p->key == key)
    {
        p->val = val;
    }
    else if(key < p->key)
    {
        p->left = insert_pair(p->left, key, val);
        int w = calculate_weight(p);
        if(w > -2)
        {
            p->weight = w;
        }
        else
        {
            int lw = calculate_weight(p->left);
            if(lw > 0)
                p->left = left_rotate(p->left);
            p = right_rotate(p);
        }
    }
    else
    {
        p->right = insert_pair(p->right, key, val);
        int w = calculate_weight(p);
        if(w < 2)
        {
            p->weight = w;
        }
        else
        {
            int rw = calculate_weight(p->right);
            if(rw < 0)
                p->right = right_rotate(p->right);
            p = left_rotate(p);
        }
    }
    return p;
}

avt_node* avt_tree::left_rotate(avt_node* p)
{
    avt_node* n = p->right;
    avt_node* t = (n!=nullptr) ? n->left : nullptr;
    p->right = t;
    n->left = p;
    calculate_weight(p);
    calculate_weight(n);
    return n;
}

avt_node* avt_tree::right_rotate(avt_node* p)
{
    avt_node* n = p->left;
    avt_node* t = (n != nullptr) ? n->right : nullptr;
    p->left = t;
    n->right = p;
    calculate_weight(p);
    calculate_weight(n);
    return n;
}


int avt_tree::calculate_weight(avt_node* p)
{
    int lw, rw;
    lw = (p->left != nullptr) ? (((p->left->weight > 0) ? p->left->weight : p->left->weight*-1)+1) : 0;
    rw = (p->right != nullptr) ? (((p->right->weight > 0) ? p->right->weight : p->right->weight*-1)+1) : 0;
    return rw-lw;
}

int avt_tree::find(int key)
{
    return search_tree(root, key);
}

int avt_tree::search_tree(avt_node* p, int key)
{
    if(p == nullptr)
        return -1;
    else if(p->key == key)
        return p->val;
    else if(key < p->key)
        return search_tree(p->left, key);
    else
        return search_tree(p->right, key);
}

avt_tree :: ~avt_tree()
{
    remove_tree(root);
}

void avt_tree :: remove_tree(avt_node* p)
{
    if(p==nullptr)
        return;
    remove_tree(p->left);
    remove_tree(p->right);
    delete p;
}

avt_tree& avt_tree :: operator=(const avt_tree& other)
{
    root = copy_tree(other.root);
    return (*this);
}

avt_tree :: avt_tree(const avt_tree& other)
{
    root = copy_tree(other.root);
}

avt_node* avt_tree :: copy_tree(avt_node* p)
{
    if(p == nullptr)
        return nullptr;
    avt_node* n = new avt_node;
    n->key = p->key;
    n->val = p->val;
    n->left = copy_tree(p->left);
    n->right = copy_tree(p->right);
    return n;
}

avt_tree :: avt_tree()
{
    root = nullptr;
}

void heapsort(int* a, int n)
{
    int start = (n-1)/2;
    int temp;
    while(start>-1)
    {
        if((2*start+2) < n)
        {
            if(a[start] < a[2*start+2])
            {
                if(a[start] < a[2*start+1])
                {
                    if(a[2*start+2] < a[2*start+1])
                    {
                        temp = a[start];
                        a[start] = a[2*start+2];
                        a[2*start+2] = temp;
                    }
                    else
                    {
                        temp = a[start];
                        a[start] = a[2*start+1];
                        a[2*start+1] = temp;
                    }
                }
                else
                {
                    temp = a[start];
                    a[start] = a[2*start+2];
                    a[2*start+2] = temp;
                }
                    
            }
        }
        else if(((2*start+1)<n) && a[start] < a[2*start+1])
        {
            temp = a[start];
            a[start] = a[2*start+1];
            a[2*start+1] = temp;
        }
        --start;
    }
   
    start = n;
    int loc;
    while(start > 1)
    {
        --start;
        temp = a[0];
        a[0] = a[start];
        a[start] = temp;
        
        loc = 0;
        
        while((2*loc+1 < start))
        {
            if(2*loc+2 < start)
            {
                if(a[2*loc+1] > a[loc] && a[2*loc+2] > a[loc])
                {
                    if(a[2*loc+1] < a[2*loc+2])
                    {
                        temp = a[loc];
                        a[loc] = a[2*loc+2];
                        a[2*loc+2] = temp;
                        loc = 2*loc+2;
                    }
                    else
                    {
                        temp = a[loc];
                        a[loc] = a[2*loc+1];
                        a[2*loc+1] = temp;
                        loc = 2*loc+1;
                    }
                }
                else if(a[2*loc+1] > a[loc])
                {
                    temp = a[loc];
                    a[loc] = a[2*loc+1];
                    a[2*loc+1] = temp;
                    loc = 2*loc+1;
                }
                else if(a[2*loc+2] > a[loc])
                {
                    temp = a[loc];
                    a[loc] = a[2*loc+2];
                    a[2*loc+2] = temp;
                    loc = 2*loc+2;
                }
                else
                    break;
            }
            else if(a[2*loc+1] > a[loc])
            {
                temp = a[loc];
                a[loc] = a[2*loc+1];
                a[2*loc+1] = temp;
                loc = 2*loc+1;
            }
            else
                break;
        }
    }
}

void quicksort(int* a, int n)
{
    if(n == 0 || n == 1)
        return;
    int part = partition(a, n);
    quicksort(a, part);
    quicksort(a+part+1, n-part-1);
}

int partition(int* a, int n)
{
    int part = a[0];
    int i = 0;
    int j = n-1;
    int temp;
    while(i < j)
    {
        while(i < j && a[i] <= part)
            ++i;
        while(a[j] > part)
            --j;
        if(i < j)
        {
            temp = a[i];
            a[i] = a[j];
            a[j] = temp;
        }
    }
    a[0] = a[j];
    a[j] = part;
    return j;
}

void mergesort(int* a, int n)
{
    if(n==0 || n ==1)
        return;
    int halfway = n/2;
    mergesort(a, halfway);
    mergesort(a+halfway, n-halfway);
    merge(a, halfway, a+halfway, n-halfway);
}

void merge(int* a1, int n1, int* a2, int n2)
{
    int i, j, k;
    i=j=k=0;
    int* helper = new int[n1+n2];
    while(i!=n1 && j!=n2)
    {
        if(a2[j] < a1[i])
            helper[k++] = a2[j++];
        else
            helper[k++] = a1[i++];
    }
    while(i != n1)
        helper[k++] = a1[i++];
    while(j != n2)
        helper[k++] = a2[j++];
    for(i = 0; i < k; ++i)
        a1[i] = helper[i];
    free(helper);
}

inline int max(int a, int b)
{
    return a < b ? b : a;
}

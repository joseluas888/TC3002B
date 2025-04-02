#include <iostream>
#include <vector>

const int MAX_SIZE=100;

class Stack {

private:
    std::vector<int> vect;
    int top;

public:

    Stack() : top(-1) {}
    bool isEmpty() const {
        return (top == -1);
    }
    void push(int element) {
        vect.push_back(element);
        top++;
    }
    void pop() {
        if (isEmpty()) {
            return;
        }
        vect.pop_back();
        top--;
    }
    int topElement() const {
        if(isEmpty()) {
            return -1;
        }
        return vect[top];
    }
};

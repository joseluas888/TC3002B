#include <iostream>
#include "Stack.h"
#include "Queue.h"
#include "Hash.h"

int main () {

    //##############################################################
    //STACK!!!
    
    Stack Mystack;

    std::cout<<"Is the stack Empty? "<<Mystack.isEmpty()<<std::endl;

    // Push until full
    for (int i = 1; i <= 10; ++i) {
        std::cout << "Pushed element: " << i << std::endl;
        Mystack.push(i);
    }

    // pop one element
    std::cout<<"Pop one element"<<std::endl;
    Mystack.pop();

    std::cout<<"Top element: "<<Mystack.topElement()<<std::endl;

    // pop everything from the stack
    std::cout<<"Pop everything from the Stack"<<std::endl;
    while (!Mystack.isEmpty()) {
        std::cout << "Popped element: " << Mystack.topElement() << std::endl;
        Mystack.pop();        
    }

    std::cout<<"Top element: "<<Mystack.topElement()<<std::endl;
    std::cout<<"Is the Stack Empty? "<<Mystack.isEmpty()<<std::endl;
    //##############################################################

    //QUEUE!!!
    
    Queue q;
    q.enqueue(10);
    q.enqueue(20);
    q.enqueue(30);

    std::cout << "Front: " << q.front() << std::endl;
    std::cout << "Back: " << q.back() << std::endl;
    std::cout << "Size: " << q.size() << std::endl;

    q.dequeue();
    std::cout << "Front after dequeue: " << q.front() << std::endl;
    std::cout << "Size before dequeue: " << q.size() << std::endl;

    q.clear();
    std::cout << "Size after clear: " << q.size() << std::endl;
    //##############################################################
    // Hash Map!!!
    HashMap<std::string, int> hashMap;
    hashMap.insert("One", 1);
    hashMap.insert("Two", 2);
    hashMap.insert("Three", 3);

    int value;
    if (hashMap.get("Two", value)) {
        std::cout << "Value of 'Two': " << value << std::endl;
    }

    hashMap.display();
    hashMap.remove("Two");
    //##############################################################

    return 0;
}
#include <iostream>
#include <stdexcept>  // Para manejar excepciones

class Node {
public:
    int data;
    Node* next;

    Node(int val) : data(val), next(nullptr) {}
};

class Queue {
private:
    Node* frontNode;
    Node* backNode;
    int length;

public:
    Queue() : frontNode(nullptr), backNode(nullptr), length(0) {}

    ~Queue() {
        while (!isEmpty()) {
            dequeue();
        }
    }

    bool isEmpty() const {
        return length == 0;
    }

    void enqueue(int element) {
        Node* newNode = new Node(element);
        if (isEmpty()) {
            frontNode = backNode = newNode;
        } else {
            backNode->next = newNode;
            backNode = newNode;
        }
        length++;
    }

    void dequeue() {
        if (isEmpty()) {
            throw std::runtime_error("Queue underflow");
        }
        Node* temp = frontNode;
        frontNode = frontNode->next;
        delete temp;
        length--;
        if (isEmpty()) {
            backNode = nullptr;
        }
    }

    int front() const {
        if (isEmpty()) {
            throw std::runtime_error("Queue empty");
        }
        return frontNode->data;
    }

    int back() const {
        if (isEmpty()) {
            throw std::runtime_error("Queue empty");
        }
        return backNode->data;
    }

    int size() const {
        return length;
    }

    void clear() {
        while (!isEmpty()) {
            dequeue();
        }
    }
};

#include <iostream>
#include <vector>
#include <list>

template <typename K, typename V>
class HashMap {
private:
    static const int INITIAL_CAPACITY = 10;
    static constexpr float LOAD_FACTOR = 0.7;  // if load > 70%, grow

    std::vector<std::list<std::pair<K, V>>> table;
    int size;
    int capacity;

    size_t hashFunction(const K& key) const {
        return std::hash<K>{}(key) % capacity;
    }

    // Grow table when load is high
    void rehash() {
        if ((float)size / capacity <= LOAD_FACTOR) return;

        int newCapacity = capacity * 2;
        std::vector<std::list<std::pair<K, V>>> newTable(newCapacity);

        for (auto& bucket : table) {
            for (auto& pair : bucket) {
                size_t newIndex = std::hash<K>{}(pair.first) % newCapacity;
                newTable[newIndex].push_back(pair);
            }
        }

        table = std::move(newTable);
        capacity = newCapacity;
    }

public:
    HashMap() : size(0), capacity(INITIAL_CAPACITY) {
        table.resize(capacity);
    }

    void insert(const K& key, const V& value) {
        size_t index = hashFunction(key);

        // Check if the key already exists and update it
        for (auto& pair : table[index]) {
            if (pair.first == key) {
                pair.second = value;  
                return;
            }
        }

        table[index].push_back({key, value});
        size++;

        rehash();
    }

    bool get(const K& key, V& value) const {
        size_t index = hashFunction(key);
        for (const auto& pair : table[index]) {
            if (pair.first == key) {
                value = pair.second;
                return true;
            }
        }
        return false;  
    }

    bool remove(const K& key) {
        size_t index = hashFunction(key);
        auto& bucket = table[index];

        for (auto it = bucket.begin(); it != bucket.end(); ++it) {
            if (it->first == key) {
                bucket.erase(it);
                size--;
                return true;
            }
        }
        return false;
    }

    void display() const {
        for (int i = 0; i < capacity; i++) {
            std::cout << i << "p: ";
            for (const auto& pair : table[i]) {
                std::cout << "[" << pair.first << " -> " << pair.second << "] ";
            }
            std::cout << std::endl;
        }
    }
};


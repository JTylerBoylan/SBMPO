#ifndef SBMPO_QUEUE_HPP
#define SBMPO_QUEUE_HPP

#include <sbmpo/types.hpp>

namespace sbmpo {

    class Queue {

        public:

            std::vector<int> heap;

            Graph * graph;

            Queue() : graph(NULL) {}

            Queue(Graph * grph, int size) : graph(grph) {
                heap.reserve(size);
            }

            bool compare (int a, int b) {
                return graph->vertices[a].f < graph->vertices[b].f;
            }

            void swap(int *a, int *b) {
                int temp = *b;
                *b = *a;
                *a = temp;
            }

            void heapify(int i) {

                int size = heap.size();
                
                int min = i;
                int l = 2 * i + 1;
                int r = 2 * i + 2;
                if (l < size && compare(heap[l], heap[min]))
                    min = l;
                if (r < size && compare(heap[r], heap[min]))
                    min = r;

                if (min != i) {
                    swap(&heap[i], &heap[min]);
                    heapify(min);
                }
            }

            void insert(int idx) {
                int size = heap.size();
                if (size == 0) {
                    heap.push_back(idx);
                } else {
                    heap.push_back(idx);
                    for (int i = size / 2 - 1; i >= 0; i--) {
                        heapify(i);
                    }
                }
            }

            void remove(int idx) {

                int size = heap.size();

                int i;
                bool found = false;
                for (i = 0; i < size; i++) {
                    if (idx == heap[i]) {
                        found = true;
                        break;
                    }
                }

                if (!found)
                    return;
                
                swap(&heap[i], &heap[size - 1]);

                heap.pop_back();
                for (int i = size / 2 - 1; i >= 0; i--) {
                    heapify(i);
                }
            }

            int pop() {
                int top = heap[0];
                heap[0] = heap[heap.size() - 1];
                heap.pop_back();
                heapify(0);
                return top;
            }

            bool empty() {
                return heap.size() == 0;
            }

    };

}


#endif
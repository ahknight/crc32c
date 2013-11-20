CXXFLAGS = -O3 -DNDEBUG -msse4.2 -I. -Wall -Wextra -Wno-sign-compare
CC = c++

PRODUCTS=crc32c_test crc32c_bench

all: $(PRODUCTS)

crc32c_test: test/crc32c_test.o test/stupidunit.o logging/crc32ctables.o logging/crc32c.o
	$(CC) -o $@ $^ $(CFLAGS)

crc32c_bench: bench/crc32cbench.o logging/crc32ctables.o logging/crc32c.o
	$(CC) -o $@ $^ $(CFLAGS)

clean:
	$(RM) $(PRODUCTS) */*.o

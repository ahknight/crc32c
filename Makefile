CFLAGS = -O3 -DNDEBUG -msse4.2 -I. -Wall -Wextra -Wno-sign-compare
CXXFLAGS = $(CFLAGS)

PRODUCTS=crc32c_test crc32c_bench c_test

all: $(PRODUCTS)

crc32c_test: test/crc32c_test.o test/stupidunit.o logging/crc32c_tables.o logging/crc32c.o
	c++ -o $@ $^

crc32c_bench: bench/crc32c_bench.o logging/crc32c_tables.o logging/crc32c.o
	c++ -o $@ $^

c_test: main.o crc32c/crc32c.o crc32c/crc32c_tables.o
	$(CC) -o $@ $^

clean:
	$(RM) $(PRODUCTS) */*.o *.o

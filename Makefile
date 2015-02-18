CFLAGS = -O3 -DNDEBUG -msse4.2 -I. -Wall -Wextra -Wno-sign-compare
CXXFLAGS = $(CFLAGS)

PRODUCTS=crc32c_test crc32c_bench c_test

all: $(PRODUCTS)

crc32c_test: tests/crc32c_test.o tests/stupidunit.o tests/crc32c_tables.o tests/crc32c.o
	c++ -o $@ $^

crc32c_bench: tests/crc32c_bench.o tests/crc32c_tables.o tests/crc32c.o
	c++ -o $@ $^

c_test: tests/c_test.o crc32c.o crc32c_tables.o
	$(CC) -o $@ $^

clean:
	$(RM) $(PRODUCTS) */*.o *.o

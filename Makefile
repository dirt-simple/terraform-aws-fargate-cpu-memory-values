main.tf:
	./generate.sh

clean:
	rm -f main.tf

all: clean main.tf

.PHONY: clean all

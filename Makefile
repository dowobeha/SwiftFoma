all: test run

demo.bin:
	foma -e "regex c:d a:o t:g;" -e "save stack demo.bin" -s

run: demo.bin
	swift run   -Xlinker -lz -Xlinker -lreadline 


test:
	swift test  -Xlinker -lz -Xlinker -lreadline 



clean:
	rm -rf demo.bin .build *~

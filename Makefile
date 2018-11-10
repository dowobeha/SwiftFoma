all: test run

demo.bin:
	foma -e "regex c:d a:o t:g;" -e "save stack demo.bin" -s

run: demo.bin
	swift run   -Xlinker -lz -Xlinker -lreadline --verbose


test: demo.bin
	swift test  -Xlinker -lz -Xlinker -lreadline --verbose

xcode: demo.bin
	swift package -Xlinker -lz -Xlinker -lreadline generate-xcodeproj
	open Foma.xcodeproj



clean:
	rm -rf demo.bin .build *.xcodeproj Package.resolved *~

app_title = Hello World
app_filename = HelloWorld

macos_required = 10.6

app_bundle = build/$(app_filename).app
app_contents = $(app_bundle)/Contents
app_macos =  $(app_contents)/MacOS

built_exe = build/code/$(app_filename)

$(app_bundle): $(built_exe) res/Info.plist
	mkdir -p $(app_macos)
	cp $(built_exe) $(app_macos)
	cat res/Info.plist \
	    | sed "s/APP_FILENAME/$(app_filename)/" \
	    | sed "s/APP_TITLE/$(app_title)/" \
	    | sed "s/MACOS_REQUIRED/$(macos_required)/" \
	    > $(app_contents)/Info.plist

$(built_exe): src/*.mm
	mkdir -p build/code
	clang -framework Cocoa \
	    -mmacosx-version-min=$(macos_required) \
	    -o $@ $^

run:
	open -W $(app_bundle)

clean:
	rm -rf build

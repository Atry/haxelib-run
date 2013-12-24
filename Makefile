all release.zip: \
haxelib-release/run.n \
haxelib-release/haxelib.xml \
haxelib-release/haxelib.json \
haxelib-release/haxedoc.xml \
haxelib-release/LICENSE \
haxelib-release/com/dongxiguo/utils/HaxelibRun.hx


haxelib-release/haxelib.json: haxelib-release/haxelib.xml
	cd haxelib-release && haxelib convertxml

release.zip:
	cd haxelib-release && zip --filesync ../$@ $(subst haxelib-release/,,$^)

install: release.zip
	haxelib local release.zip

haxelib-release/run.n: \
haxelib-release/com/dongxiguo/utils/HaxelibRun.hx
	haxe -cp haxelib-release -main com.dongxiguo.utils.HaxelibRun -neko $@

haxelib-release/haxedoc.xml: \
haxelib-release/com/dongxiguo/utils/HaxelibRun.hx
	haxe -cp haxelib-release -main com.dongxiguo.utils.HaxelibRun -xml $@

clean:
	-$(RM) release.zip haxelib-release/run.n

.PHONY: all clean install

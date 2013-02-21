all: release.zip

install: release.zip
	haxelib test release.zip

release.zip: \
haxelib-release/run.n \
haxelib-release/haxelib.xml \
haxelib-release/haxedoc.xml \
haxelib-release/LICENSE \
haxelib-release/com/dongxiguo/utils/HaxelibRun.hx
	cd haxelib-release && zip --filesync ../$@ $(subst haxelib-release/,,$^)

haxelib-release/run.n: \
haxelib-release/com/dongxiguo/utils/HaxelibRun.hx
	haxe -cp haxelib-release -main com.dongxiguo.utils.HaxelibRun -neko $@

haxelib-release/haxedoc.xml: \
haxelib-release/com/dongxiguo/utils/HaxelibRun.hx
	haxe -cp haxelib-release -main com.dongxiguo.utils.HaxelibRun -xml $@

clean:
	-$(RM) release.zip

.PHONY: all clean install
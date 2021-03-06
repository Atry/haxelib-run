// Copyright (c) Copyright 2013 深圳市葡萄藤网络科技有限公司 (Shenzhen Putaoteng Network Technology Co., Ltd.)
// All rights reserved.
//
// Author: 杨博 (Yang Bo) <pop.atry@gmail.com>
//
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions are met:
//
// * Redistributions of source code must retain the above copyright notice,
//   this list of conditions and the following disclaimer.
// * Redistributions in binary form must reproduce the above copyright notice,
//   this list of conditions and the following disclaimer in the documentation
//   and/or other materials provided with the distribution.
// * Neither the name of the <ORGANIZATION> nor the names of its contributors
//   may be used to endorse or promote products derived from this software
//   without specific prior written permission.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
// AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
// IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
// ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
// LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
// CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
// SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
// INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
// CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
// ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
// POSSIBILITY OF SUCH DAMAGE.

package com.dongxiguo.utils;

import haxe.Json;

class HaxelibRun
{
	public static function haxelibXml():Xml
	{
		return Xml.parse(sys.io.File.getContent(Sys.getCwd()+"haxelib.xml"));
	}

	public static function haxelibJson():Dynamic
	{

		return Json.parse(sys.io.File.getContent(Sys.getCwd()+"haxelib.json"));
	}

	public static function libraryName():String
	{
		return
      try
      {
        haxelibXml().elementsNamed("project").next().get("name");
      }
      catch (e:Dynamic)
      {
        haxelibJson().name;
      }
	}

	public static function run(args:Array<String>):Null<Int>
	{
		switch (args)
		{
			case [ "print-lib-path", _ ]:
				Sys.print(Sys.getCwd());
				return 0;
			case [ "print-lib-version", _ ]:
				Sys.print(haxelibXml().elementsNamed("project").next().elementsNamed("version").next().get("name"));
				return 0;
			case [ "print-lib-name", _ ]:
				Sys.print(libraryName());
				return 0;
			default:
				return null;
		}
	}

	public static function usage()
	{
		return 'Usage: haxelib run ${libraryName()} print-lib-path|print-lib-version|print-lib-name';
	}

	public static function main()
	{
		var returnValue = run(Sys.args());
		if (returnValue == null)
		{
			Sys.print(usage());
			Sys.exit(-1);
		}
		else
		{
			Sys.exit(returnValue);
		}
	}
}

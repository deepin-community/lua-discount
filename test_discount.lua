luaunit = require("luaunit")
discount = require("discount")

function test_basic_conversion()
  luaunit.assertEquals("<p>Hello World.</p>", discount("Hello World."))
end

function test_relaxed_emphasis()
  luaunit.assertEquals("<p><em>Hello World</em>!</p>", discount("_Hello World_!"))
  luaunit.assertEquals("<p>under_score this_stuff</p>", discount("under_score this_stuff"))

  local input = "_start _ foo_bar bar_baz _ end_ *italic* **bold** <a>_blah_</a>"
  local expected_out = "<p><em>start _ foo_bar bar_baz _ end</em> <em>italic</em> <strong>bold</strong> <a><em>blah</em></a></p>"
  luaunit.assertEquals(expected_out, discount(input))
end

function test_nolinks()
  luaunit.assertEquals("<p>[example](http://example.com)</p>", discount("[example](http://example.com)", "nolinks"))
  luaunit.assertEquals('<p>&lt;a href=&ldquo;http://example.com&rdquo;>example</a></p>',
      discount('<a href="http://example.com">example</a>', "nolinks"))
end

function test_noimages()
  luaunit.assertEquals("<p>![example](example.png)</p>", discount("![example](example.png)", "noimage"))
  luaunit.assertEquals('<p>&lt;img src=&ldquo;example.png&rdquo;/></p>', discount('<img src="example.png"/>', "noimage"))
end

function test_nopants()
  luaunit.assertEquals('<p>&ldquo;quote&rdquo;</p>', discount('"quote"'))
  luaunit.assertEquals('<p>"quote"</p>', discount('"quote"', "nopants"))
end

function test_nohtml()
  local expected = "<p>This should &lt;em>not&lt;/em> be allowed</p>"
  luaunit.assertEquals(expected, discount("This should <em>not</em> be allowed", "nohtml"))
end

--function test_cdata()
--  luaunit.assertEquals("&lt;p&gt;foo&lt;/p&gt;", discount("foo", "cdata"))
--end

function test_toc()
  local expected_out = '<a name="Level.1\"></a>\n<h1>Level 1</h1>\n\n<a name="Level.2\"></a>\n<h2>Level 2</h2>'
  local input = "# Level 1\n\n## Level 2\n\n"
  luaunit.assertEquals(expected_out, discount(input, "toc"))
end

os.exit(luaunit.LuaUnit.run())

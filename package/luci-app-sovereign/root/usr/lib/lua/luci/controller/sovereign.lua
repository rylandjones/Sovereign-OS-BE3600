module("luci.controller.sovereign", package.seeall)
function index()
  entry({"admin","sovereign"}, firstchild(), _("Sovereign"), 10).dependent=false
  entry({"admin","sovereign","overview"}, template("sovereign/overview"), _("Overview"), 1)
  entry({"admin","sovereign","advanced"}, template("sovereign/advanced"), 99)
end

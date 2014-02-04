using Gee;
namespace PluginService.Entity {
	public class Search : Object {
		public int result_count { get { return plugins.size; } }
		public string error  { get; set; default = ""; }
		public ArrayList<Plugin> plugins { get; set; default = new ArrayList<Plugin>(); }
	}
}
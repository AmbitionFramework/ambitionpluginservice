using Ambition;
using PluginService.Model;
using PluginService.View;
namespace PluginService.Controller.Service {
	public class Search : Object {

		public Object search( State state ) {
			var search_entity = new Entity.Search();
			var search_results = DB.Plugin.do_search("a");
			foreach ( var plugin in search_results ) {
				search_entity.plugins.add(
					new Entity.Plugin( plugin.name, plugin.version, plugin.description )
				);
			}
			return search_entity;
		}

	}
}

using Ambition;
using PluginService.Model;
using PluginService.View;
namespace PluginService.Controller.Service {
	public class Search : Object {

		public static Object? search( State state, Object? o ) {
			string? query = state.request.params["q"];
			if ( query == null ) {
				state.response.status = 400;
				return new Entity.Error("Missing query");
			}

			var search_entity = new Entity.Search();
			var search_results = DB.Plugin.do_search(query);
			foreach ( var plugin in search_results ) {
				search_entity.plugins.add(
					new Entity.Plugin( plugin.name, plugin.version, plugin.description )
				);
			}
			return search_entity;
		}

	}
}

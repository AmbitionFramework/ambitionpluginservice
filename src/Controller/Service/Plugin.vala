using Ambition;
using PluginService.Model;
using PluginService.View;
namespace PluginService.Controller.Service {
	public class Plugin : Object {

		public Result retrieve( State state ) {
			return new CoreView.None();
		}

		public Object versions( State state ) {
			string? list = state.request.params["l"];
			if ( list == null ) {
				state.response.status = 400;
				return new Entity.Error("Missing list");
			}

			var results = new Entity.Search();
			var parser = new Json.Parser();
			try {
				parser.load_from_data( list, -1 );
			} catch (Error e) {
				results.error = "Malformed list";
				return results;
			}
			if ( parser.get_root() == null ) {
				results.error = "Malformed list";
				return results;
			}
			var root_object = parser.get_root().get_object();
			foreach ( var plugin_node in root_object.get_array_member("plugins").get_elements() ) {
				var plugin_result = (Entity.Plugin) Json.gobject_deserialize( typeof(Entity.Plugin), plugin_node );
				var newer = DB.Plugin.get_newer ( plugin_result.name, plugin_result.version );
				if ( newer != null ) {
					results.plugins.add(
						new Entity.Plugin( newer.name, newer.version, newer.description )
					);
				}
			}
			return results;
		}

	}
}

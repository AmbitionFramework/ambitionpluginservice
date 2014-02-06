using Ambition;
using Ambition.Plugin;
using PluginService.Model;
using PluginService.View;
namespace PluginService.Controller.Service {
	public class Plugin : Object {

		public Result retrieve( State state ) {
			return new CoreView.None();
		}

		public Object manifest( State state ) {
			string? plugin_name = state.request.params["n"];
			if ( plugin_name == null ) {
				state.response.status = 400;
				return new Entity.Error("Missing name");
			}

			var plugin = DB.Plugin.get_latest(plugin_name);
			if ( plugin == null ) {
				state.response.status = 404;
				return new Entity.Error("Not found");
			}

			var parser = new Json.Parser();
			var plugin_dir = Config.lookup("file_directory");
			try {
				if ( parser.load_from_file( "%s/%s-%s.manifest.json".printf( plugin_dir, plugin.name, plugin.version ) ) ) {
					var manifest = (PluginManifest) Json.gobject_deserialize( typeof(PluginManifest), parser.get_root() );
					var author = new Almanna.Search<DB.Author>().lookup( plugin.author_id );
					manifest.author = "%s <%s>".printf( author.name, author.sanitized_email() );
					return manifest;
				}
			} catch ( Error e ) {
				state.response.status = 404;
				return new Entity.Error("Not found");
			}

			state.response.status = 404;
			return new Entity.Error("Not found");
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

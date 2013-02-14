using Ambition;
using PluginService.View;
namespace PluginService.Controller {

	/**
	 * Plugins Controller.
	 */
	public class Plugins : Object {

		public Result list ( State state ) {
			var plugins = new Almanna.Search<PluginService.Model.DB.Plugin>()
				.order_by( "name" )
				.list();
			return new Template.Plugins.list(plugins);
		}

		public Result view ( State state ) {
			string? plugin_id = state.request.get_capture("plugin_id");
			Logger.warn(plugin_id);
			var plugin = new Almanna.Search<PluginService.Model.DB.Plugin>()
				.eq( "plugin_id", int.parse(plugin_id) )
				.single();
			return new Template.Plugins.view(plugin);
		}

	}
}

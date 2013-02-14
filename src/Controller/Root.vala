using Ambition;
using PluginService.View;
namespace PluginService.Controller {
	public class Root : Object {

		public Result index( State state ) {
			var recent_plugins = new Almanna.Search<PluginService.Model.DB.Plugin>()
				.gt( "plugin_id", 0 )
				.order_by("date_modified")
				.page(1)
				.rows(5)
				.list();
			return new Template.Root.index(recent_plugins);
		}

	}
}

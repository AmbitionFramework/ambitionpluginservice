using Ambition;
using PluginService.View;
using Gee;
namespace PluginService.Controller {
	public class Root : Object {

		public static Result index( State state ) {
			var recent_plugins = new Almanna.Search<PluginService.Model.DB.Implementation.Plugin>()
				.order_by( "date_modified", true )
				.page(1)
				.rows(5)
				.list();
			return new Template.Root.index(recent_plugins);
		}

		public static Result about( State state ) {
			return new Template.Root.about();
		}

	}
}

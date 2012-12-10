using Ambition;
using PluginService.View;
namespace PluginService.Controller {
	public class Root : Object {

		public Result index( State state ) {
			return new Template.Root.index( "PluginService", state.request.headers );
		}

	}
}

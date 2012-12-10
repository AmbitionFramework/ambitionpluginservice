using Ambition;
using PluginService.View;
namespace PluginService.Controller {
	public class Plugin : Object {

		public Result retrieve( State state ) {
			return new Template.Root.index( "PluginService", state.request.headers );
		}

	}
}

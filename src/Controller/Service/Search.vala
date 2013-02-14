using Ambition;
using PluginService.View;
namespace PluginService.Controller.Service {
	public class Search : Object {

		public Result index( State state ) {
			var search = new JSON.Search();
			search.plugins.add( new JSON.Plugin( "SCGI", "1.0", "SCGI Engine" ) );
			search.plugins.add( new JSON.Plugin( "Almanna", "1.0", "Enable Almanna ORM support in Ambition" ) );
			return new JsonView(search);
		}

	}
}

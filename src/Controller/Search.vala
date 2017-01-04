using Ambition;
using PluginService.View;
namespace PluginService.Controller {

	/**
	 * Search Controller.
	 */
	public class Search : Object {

		/**
		 * Get search results.
		 * @param state State object.
		 */
		public static Result search( State state ) {
			string? query = state.request.params["q"];
			if ( query == null ) {
				return new CoreView.Redirect("/");
			}
			var results = PluginService.Model.DB.Implementation.Plugin.do_search(query);
			return new Template.Search.search(results);
		}

	}
}

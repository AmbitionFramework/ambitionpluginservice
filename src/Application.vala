using Ambition;
namespace PluginService {
	/**
	 * Class containing bootstrap code for this application.
	 */
	public class Application : Ambition.Application {
		public override void create_routes() {
			add_route()
				.path("/")
				.method( HttpMethod.GET )
				.target( Controller.Root.index );
			add_route()
				.path("/about")
				.method( HttpMethod.GET )
				.target( Controller.Root.about );
			add_route()
				.path("/search")
				.method( HttpMethod.GET )
				.method( HttpMethod.POST )
				.target( Controller.Search.search );
			add_route()
				.path("/plugins")
				.method( HttpMethod.GET )
				.target( Controller.Plugins.list );
			add_route()
				.path("/plugins/[plugin_id]")
				.method( HttpMethod.GET )
				.target( Controller.Plugins.view );
			add_route()
				.path("/generate/[file]")
				.method( HttpMethod.GET )
				.target( Controller.Plugins.generate );
			add_route()
				.path("/service/search")
				.method( HttpMethod.GET )
				.marshal_json( typeof(Object) )
				.target_object_object( Controller.Service.Search.search );
			add_route()
				.path("/service/versions")
				.method( HttpMethod.GET )
				.marshal_json( typeof(Object) )
				.target_object_object( Controller.Service.Plugin.versions );
			add_route()
				.path("/service/manifest")
				.method( HttpMethod.GET )
				.marshal_json( typeof(Object) )
				.target_object_object( Controller.Service.Plugin.manifest );
			add_route()
				.path("/service/retrieve")
				.method( HttpMethod.GET )
				.target( Controller.Service.Plugin.retrieve );
		}

		/**
		 * Initialize Almanna ORM.
		 */
		public override bool init( string[] args ) {
			Almanna.Repo.from_loader( new PluginService.Model.DB.AlmannaLoader() );
			Ambition.Config.set_value( "default_accept_type", "application/json" );
			return true;
		}
	}
}

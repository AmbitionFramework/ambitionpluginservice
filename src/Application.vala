namespace PluginService {
	/**
	 * Class containing bootstrap code for this application.
	 */
	public class Application : Ambition.Application {
		public override Ambition.Actions get_actions() {
			return new Actions();
		}

		/**
		 * Initialize Almanna ORM.
		 */
		public override bool init( string[] args ) {
			Almanna.Repo.from_loader( new PluginService.Model.DB.AlmannaLoader() );
			return true;
		}
	}
}

using Ambition;
using Ambition.PluginSupport;

public static int main( string[] args ) {
	var app = new PluginService.Application();
	app.run(args);
	return 0;
}

namespace PluginService {
	/**
	 * Class containing bootstrap code for this application.
	 */
	public class Application : Object {
		private Dispatcher dispatcher;

		public void run( string[] args ) {
			// Initialize the application's dispatcher
			this.dispatcher = new Dispatcher(args);

			// Import actions
			dispatcher.add_actions_class( new Actions() );

			// Start the application
			dispatcher.run();
		}
	}
}

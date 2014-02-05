namespace PluginService.Entity {
	public class Error : Object {
		public string error { get; set; }

		public Error( string error ) {
			this.error = error;
		}
	}
}
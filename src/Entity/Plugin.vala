namespace PluginService.Entity {
	public class Plugin : Object {
		public string name { get; set; }
		public string version { get; set; }
		public string description { get; set; }

		public Plugin( string name, string version, string description ) {
			this.name = name;
			this.version = version;
			this.description = description;
		}
	}
}
using Almanna;
namespace PluginService.Model.DB {
	public class PluginInstall : Almanna.Entity {
		public override string entity_name { owned get { return "plugin_install"; } }
		public int plugin_install_id { get; set; }
		public int plugin_id { get; set; }
		public string version { get; set; }
		public string ip_address { get; set; }
		public DateTime date_created { get; set; }
		
		public override void register_entity() {
			add_column( new Column<int>.with_name_type( "plugin_install_id", "integer" ) );
			columns["plugin_install_id"].size = 4;

			add_column( new Column<int>.with_name_type( "plugin_id", "integer" ) );
			columns["plugin_id"].size = 4;
			
			add_column( new Column<string>.with_name_type( "version", "varchar" ) );
			columns["version"].size = 16;
			
			add_column( new Column<string>.with_name_type( "ip_address", "varchar" ) );
			columns["ip_address"].size = 15;
			
			add_column( new Column<DateTime>.with_name_type( "date_created", "timestamp without time zone" ) );
			columns["date_created"].size = 8;
			columns["date_created"].is_nullable = true;
			
			try {
				set_primary_key("plugin_install_id");
			} catch (EntityError e) {
				stderr.printf( "Error adding primary key to entity: %s\n", e.message );
			}
		}

		public override void save() {
			base.save();
			var plugin = new Search<Plugin>().eq( "plugin_id", this.plugin_id ).single();
			if ( plugin != null ) {
				plugin.installs++;
				plugin.save();
			}
		}
	}
}


using Almanna;
namespace PluginService.Model.DB {
	/**
	 * Almanna Entity for table "plugin_documentation".
	 * Generated by generate-schema.pl.
	 */
	public class PluginDocumentation : Almanna.Entity {
		public override string entity_name { owned get { return "plugin_documentation"; } }
		public int plugin_id { get; set; }
		public string format { get; set; }
		public string documentation { get; set; }
		
		public override void register_entity() {
			add_column( new Column<int>.with_name_type( "plugin_id", "integer" ) );
			columns["plugin_id"].size = 4;
			
			add_column( new Column<string>.with_name_type( "format", "varchar" ) );
			columns["format"].size = 4;
			
			add_column( new Column<string>.with_name_type( "documentation", "text" ) );
			columns["documentation"].is_nullable = true;
			
			try {
				set_primary_key("plugin_id");
			} catch (EntityError e) {
				stderr.printf( "Error adding primary key to entity: %s\n", e.message );
			}
		}
	}
}


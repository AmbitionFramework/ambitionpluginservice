using Almanna;
namespace PluginService.Model.DB {
	/**
	 * Almanna Entity for table "plugin_history".
	 * Generated by generate-schema.pl.
	 */
	public class PluginHistory : Almanna.Entity {
		public override string entity_name { owned get { return "plugin_history"; } }
		public int plugin_history_id { get; set; }
		public int plugin_id { get; set; }
		public int size_k { get; set; }
		public string version { get; set; }
		public string filename { get; set; }
		public DateTime date_uploaded { get; set; }
		
		public override void register_entity() {
			add_column( new Column<int>.with_name_type( "plugin_history_id", "integer" ) );
			columns["plugin_history_id"].size = 4;
			
			add_column( new Column<int>.with_name_type( "plugin_id", "integer" ) );
			columns["plugin_id"].size = 4;
			
			add_column( new Column<int>.with_name_type( "size_k", "integer" ) );
			columns["size_k"].size = 4;
			columns["size_k"].is_nullable = true;
			
			add_column( new Column<string>.with_name_type( "version", "character varying" ) );
			columns["version"].size = 16;
			columns["version"].is_nullable = true;
			
			add_column( new Column<string>.with_name_type( "filename", "character varying" ) );
			columns["filename"].size = 16;
			columns["filename"].is_nullable = true;
			
			add_column( new Column<DateTime>.with_name_type( "date_uploaded", "timestamp without time zone" ) );
			columns["date_uploaded"].size = 8;
			columns["date_uploaded"].is_nullable = true;
			
			try {
				set_primary_key("plugin_history_id");
			} catch (EntityError e) {
				stderr.printf( "Error adding primary key to entity: %s\n", e.message );
			}
		}
	}
}

using Almanna;

namespace PluginService.Model.DB.Implementation {
	
	/**
	 * Almanna Implementation for class "PluginHistory".
	 * Generated by almanna-generate.
	 */
	public class PluginHistory : PluginService.Model.DB.Entity.PluginHistory {
		public override void register_entity() {
			base.register_entity();
		}

		/**
		 * Create a PluginHistory entry from an existing plugin.
		 * @param plugin Plugin instance
		 */
		public static PluginHistory create_from_plugin( Plugin plugin ) {
			var history = new PluginHistory();
			history.plugin_id = plugin.plugin_id;
			history.size_k = plugin.size_k;
			history.version = plugin.version;
			history.filename = plugin.filename;
			history.date_uploaded = plugin.date_modified;
			history.save();

			return history;
		}
	}
}
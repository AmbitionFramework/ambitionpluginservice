using Gee;
namespace PluginService.View.JSON {
	public class Search : Object,Json.Serializable {
		public int result_count { get; set; default = 0; }
		public string error  { get; set; default = ""; }
		public ArrayList<Plugin> plugins { get; set; default = new ArrayList<Plugin>(); }

		public bool deserialize_property( string property_name, out Value value, ParamSpec pspec, Json.Node property_node ) {
			return true;
		}

		public Json.Node serialize_property( string property_name, Value value, ParamSpec pspec ) {
			switch (property_name) {
				case "plugins":
					var node = new Json.Node( Json.NodeType.ARRAY );
					var array = new Json.Array();
					foreach ( Plugin plugin in plugins ) {
						var plugin_object = new Json.Object();
						plugin_object.set_string_member( "name", plugin.name );
						plugin_object.set_string_member( "version", plugin.version );
						plugin_object.set_string_member( "description", plugin.description );
						array.add_object_element(plugin_object);
						result_count = result_count + 1;
					}
					node.set_array(array);
					return node;
				case "error":
					var node = new Json.Node( Json.NodeType.VALUE );
					node.set_string(error);
					return node;
				case "result-count":
					var node = new Json.Node( Json.NodeType.VALUE );
					node.set_int( plugins.size );
					return node;
			}

			return null;
		}

		public new unowned ParamSpec find_property( string name ) {
			return this.get_class().find_property(name);
		}
	}

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
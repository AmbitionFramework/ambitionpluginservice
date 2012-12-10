namespace PluginService.View {
	public class JsonView : Ambition.CoreView.JSON {
		public JsonView( Object object ) {
			try {
				this.with_object(object);
			} catch (Error e) {}
		}
	}
}
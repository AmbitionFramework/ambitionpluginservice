using Ambition;
namespace PluginService.Model {
	/**
	 * Interface to the markdown library
	 */
	public class WikiMarkdown : Object {
		/**
		 * Given content in a string, parse into HTML and return
		 * @param markdown_content Source content
		 * @return string
		 */
		public static string process( string markdown_content ) {

			// Process markdown content
			string result = Markdown.to_string( markdown_content, 0, Markdown.Formats.HTML );
			return result;
		}
	}
}

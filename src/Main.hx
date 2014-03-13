package ;

import beluga.core.Beluga;
import beluga.core.api.BelugaApi;
import beluga.core.Widget;
import beluga.core.BelugaException;
import haxe.web.Dispatch;
import php.Web;
import haxe.Resource;
import haxe.crypto.Md5;
import beluga.module.account.model.User;
import AccountDemo;

/**
 * Beluga #1
 * Load the account class
 * Use it to generate login form, subscribe form, logged homepage
 * @author Masadow
 */

class Main 
{
	public static var beluga : Beluga;


	static function main()
	{
		try {
			beluga = Beluga.getInstance();
			Dispatch.run(Web.getURI(), Web.getParams(), new Main());
		} catch (e : BelugaException) {
			trace(e);
		}
	}

	public function new() {

	}

	public function doBeluga(d : Dispatch) {
		d.dispatch(beluga.api);
	}

	public function doDebug(d : Dispatch) {
		//Fonction test things
		trace(d.parts);
	}

	public function doDefault(d : Dispatch) {
		if (d.parts.length > 0) {
			d.dispatch(beluga.api);
		} else {
			doAccueil();
		}
		d.dispatch(beluga.api);
	}
	
	public function doAccueil() {
			var accueil = (new haxe.Template(Resource.getString("page_accueil"))).execute({});
			var templatelayout = (new haxe.Template(Resource.getString("template_default_layout"))).execute( {
				content: accueil
			});
			var bodyhtml = (new haxe.Template(Resource.getString("html_body"))).execute( {
				content: templatelayout,
				title: "Accueil"
			});
			Sys.print(bodyhtml);
	}

}
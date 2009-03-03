package vau3.as3arabic {
	
	/**
	* @author vauthree@gmail.com
	* @link http://code.google.com/p/as3arabic/
	* @version 0.8
	* 
	* Static class for changing direction of arabic text from ltr to rtl. 
	* Includes multiline and ltr text detection (numbers).
	* Created with MIT license.
	* Have Fun!
	*/
	public class Arabic {
		
		/**
		 * Convert string from ltr to rtl
		 * @param	sourceTextField (TextField)
		 * @param	destTextField (TextField)
		 * @param	doubleSpaces (when trying to separate words - use only with letterspacing < 1)
		 */
		public static function flipArTxt (sourceTextField, destTextField, doubleSpaces:Boolean = false):void {
			var newStr:String = '';
			
			// first line convertion
			for (var r:uint = 0; r < sourceTextField.numLines; r++) {
				var str:String = sourceTextField.getLineText(r);
				
				var liczba:String = '';
				
				if (r == 0) {
					for (var u:uint = 0; u < str.length; u++) {
						var s:String = (str.substring(str.length - u, str.length - 1 - u));
						
						// checking if a string is a number, if so - put it into a container and wait
						// for last digit, then replace digits to original order
						if (checkNaN (s)) {
							liczba += s;
							s = '';
						} else {
							if (liczba != '') {
								for (var l1:uint = 0; l1 < liczba.length; l1++) {
									s += liczba.substring(liczba.length - l1, liczba.length - 1 - l1);
								}
								s += ' ';
								liczba = '';
							}
							 else {
								// double spacing (use only with letterspacing < 1)
								if (doubleSpaces && s.charCodeAt (0) == 32) {
									s = '  ';
								}
							}
						}
						
						newStr += s;
					} 
				}
				// other lines convertion
				else {
					for (var u1:uint = 0; u1 < str.length; u1++) {
						var s2:String = (str.substring(str.length - u1, str.length - 1 - u1))
						
						// checking if a string is a number, if so - put it into a container and wait
						// for last digit, then replace digits to original order
						if (checkNaN (s2)) {
							liczba += s2;
							s2 = '';
						} else {
							if (liczba != '') {
								for (var l2:uint = 0; l2 < liczba.length; l2++) {
									s2 += liczba.substring(liczba.length - l2, liczba.length - 1 - l2);
								}
								s2 += ' ';
								liczba = '';
							} else {
								// double spacing (use only with letterspacing < 1)
								if (doubleSpaces && s2.charCodeAt (0) == 32) {
									s2 = '  ';
								}
							}
						}
						newStr += s2;
					}
				}
			}
			destTextField.text = newStr;
		}
		
		/**
		 * Check if string is a number
		 * @param	str
		 * @return
		 */
		private static function checkNaN (str):Boolean {
			var res:Boolean = false;
			if (str.charCodeAt(0) != 10 && str.charCodeAt(0) != 13 && str.charCodeAt(0) != 32) {
				
				var nan = Number (str);
				if (!isNaN (nan)) {
					res = true;
				}
			}
			return res;
		}	
	}
}
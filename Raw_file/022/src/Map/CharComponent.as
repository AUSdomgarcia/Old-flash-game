package Map 
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	/**
	 * ...
	 * @author dHOMZKIe
	 */
	public class CharComponent extends Sprite
	{
		public var charNum:Number = 0;
		private var _charMc:CharVariation;
		
		public function CharComponent( numChar:Number, diplayStr:String, _x:Number, _y:Number )
		{
			_charMc = new CharVariation();
			_charMc.gotoAndStop( diplayStr );
			_charMc.squareBox.qty.text = Number( numChar );
			
			_charMc.x = _x;
			_charMc.y = _y;
		}
		public function addMe():void {
			addChild( _charMc );
		}
		public function removeMe():void {
			if ( _charMc != null ) {
				removeChild( _charMc );
			}
		}
	//end
	}
}
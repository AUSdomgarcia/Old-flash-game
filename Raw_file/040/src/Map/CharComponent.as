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
		
		public var heldStr:String;
		public var numChar:Number = 0;
		
		public function CharComponent( _numChar:Number, diplayStr:String, _x:Number, _y:Number )
		{
			numChar = _numChar;
			heldStr = diplayStr;
			_charMc = new CharVariation();
			_charMc.gotoAndStop( diplayStr );
			_charMc.squareBox.qty.text = Number( numChar );
			
			_charMc.x = _x;
			_charMc.y = _y;
		}
		public function addAvatar():void {
			addChild( _charMc );
		}
		public function removeAvatar():void {
			if ( _charMc != null ) {
				removeChild( _charMc );
				_charMc = null
			}
		}
	//end
	}
}
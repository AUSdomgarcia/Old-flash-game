package Map 
{
	import flash.display.Sprite;
	/**
	 * ...
	 * @author dHOMZKIe
	 */
	public class CharHintManager extends Sprite
	{
		private var spt:Sprite = new Sprite();
		private var _charComp:CharComponent;
		public var charRefArr:Array = [];
		public var arrHolder:Array = [];
		public var charMcHolder:Array = [];
		
		public function CharHintManager() 
		{

		}
		
		public function set setCharRefArr( charRef:Array ):void {
			removeChar();
			charRefArr = charRef;
			arrHolder = new Array();
			
			for (var i:int = 0; i < charRefArr.length; i++)
			{
				if (charRefArr[i].state == 1 ) 
				{
					if (arrHolder.length == 0) {
						arrHolder.push( charRefArr[i].label );
					} else {
						var isValid:Boolean = false;
						for (var j:int = 0; j < arrHolder.length; j++) 
						{
							if (arrHolder[j] == charRefArr[i].label) {
								isValid = true;
							}
						}
						if ( !isValid ) {
							arrHolder.push( charRefArr[i].label );
						}
					}
				}
			}
			addChar();
		}
		
		private function addChar():void 
		{
			var arrPostion:Array = [ { x:10, y:10 },
									{ x:80, y:60 },
									{ x:-70, y:115 },
									{ x:30, y:140 }];
			
			
			
			charMcHolder = new Array();
			for (var i:int = 0; i < arrHolder.length; i++) 
			{
				_charComp = new CharComponent(1, String(arrHolder[i]), 470 + (arrPostion[i].x) , 100+ (arrPostion[i].y ));
				charMcHolder[i] = _charComp;
				charMcHolder[i].addAvatar();
				addChild(charMcHolder[i]);
			}
		}
		
		public function removeChar():void {
			if ( _charComp != null ) {
				for (var i:int = 0; i < charMcHolder.length; i++) 
				{
					charMcHolder[i].removeAvatar();
					removeChild(charMcHolder[i]);
				}
			}
		}
	//end
	}
}
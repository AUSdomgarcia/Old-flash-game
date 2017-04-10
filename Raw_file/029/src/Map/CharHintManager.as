package Map 
{
	import flash.display.Sprite;
	import flash.events.Event;
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
		
		public var maxNumref:Number = 0;
		public var numOfAvatarArrHolder:Array = [];
		private var _isAllhaveValue:Boolean = false;
		
		public function CharHintManager() 
		{

		}
		public function removeChar():void {
			removeChars();
		}
		public function set setCharRefArr( charRef:Array ):void {
			
			charRefArr = charRef;
			arrHolder = new Array();
			
			maxNumref = charRefArr[0].maxNum;
			
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
			resetDataofDistributionOfChar();
		}
		
		private function resetDataofDistributionOfChar():void 
		{
			numOfAvatarArrHolder = [];
			_isAllhaveValue = false;
			calculate();
		}
		
		private function calculate():void 
		{	
			var rand:Number = 0;
		
			if (numOfAvatarArrHolder.length == 0 ) {
				for (var i:int = 0; i < arrHolder.length; i++) 
				{
					maxNumref--;
					if ( maxNumref >=0 ) {
						numOfAvatarArrHolder[i] = 1;
					} else {
						numOfAvatarArrHolder[i] = 0;
					}
				}
			} 	
				var len:Number = maxNumref;
				
				for (var j:int = 0; j < len; j++)
				{
					if ( numOfAvatarArrHolder[j] == 1) {
							_isAllhaveValue = true;
					}
					if (_isAllhaveValue) {
						maxNumref--;
						rand = Math.floor(Math.random() * numOfAvatarArrHolder.length);
						numOfAvatarArrHolder[rand]++;
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
				_charComp = new CharComponent(numOfAvatarArrHolder[i], String(arrHolder[i]), 470 + (arrPostion[i].x) , 100+ (arrPostion[i].y ));
				charMcHolder[i] = _charComp;
				charMcHolder[i].addAvatar();
				addChild(charMcHolder[i]);
			}
		}
		
		public function removeChars():void {
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
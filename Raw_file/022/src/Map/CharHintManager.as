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
		
		public function CharHintManager() 
		{
		
		}
		public function set setCharRefArr( charRef:Array ):void {
			charRefArr = charRef;
			var arrHolder:Array = [];
			var isValid:Boolean = false;
			
			for (var i:int = 0; i < charRefArr.length; i++)
			{
				if (charRefArr[i].state == 1) {
					if (arrHolder.length < 0) {
						arrHolder.push( charRefArr[i] );
						isValid = true;
					}
					if ( !isValid ) {
					arrHolder.push( arrHolder[i] );
					trace("arrLen:", arrHolder.length);
					}
				}
			}
			
			/*if (refArr.length == 0) {
				refArr.push(_obj);
			} else {
				var isValid:Boolean = false;
				for (var i:int = 0; i < refArr.length; i++) 
				{
					if ( refArr[i] == _obj ) {
						isValid = true;
					}
				}
					
				if ( !isValid ) {
					if( refArr.length != limitHolderArr ){
					refArr.push( _obj);
					trace("arrLen:", refArr.length);
					} */
			//_charComp = new CharComponent( 1, "girly", 60, 10 );
			//_charComp.addMe();
			//addChild( _charComp ); 
		}
	//end
	}
}
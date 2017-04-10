package House 
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	/**
	 * ...
	 * @author dHOMZKIe
	 */
	public class HouseComponent extends Sprite
	{
		private var houseMc:HouseMc;
		public var isChimneyOn:Boolean = false;
		public var isLightOn:Boolean = false;
		public var hasSanta:Boolean = false;
		public var houseIndex:Number = 0;
		public var heldDreamListArr:Array = [];
		
		public var chimney:MovieClip;
		
		public function HouseComponent( _isChimneyOn:Boolean, _isLightOn:Boolean ) 
		{
			houseMc = new HouseMc();
		
			chimney = houseMc.chimney;
			
			if ( _isChimneyOn ) {
				houseMc.chimney.gotoAndStop(2);
				isChimneyOn = _isChimneyOn;
			} else {  houseMc.chimney.gotoAndStop(1); isChimneyOn = _isChimneyOn;}
			if ( _isLightOn ) {
				isLightOn = _isLightOn;
				houseMc.gotoAndStop(2);
			} else { houseMc.gotoAndStop(1); isLightOn = _isLightOn; }
		}
		
		public function isCurrentHouseLightOn( isOn:Boolean ):void {
			if ( isOn ) { houseMc.gotoAndStop(2);  isLightOn = true; } else { houseMc.gotoAndStop(1);  isLightOn = false; } 
		}
		
		public function isCurrentChimneyLightOn( isOn:Boolean ):void {
			if ( isOn ) { houseMc.chimney.gotoAndStop(2); isChimneyOn = true; } else { houseMc.chimney.gotoAndStop(1); isChimneyOn = false; }
		}
		
		public function isCurrentHouseVisibleOff( isVisible:Boolean ):void {
			if ( isVisible ) { houseMc.visible = false; }
		}
		
		public function addHouse():void {
			if ( houseMc != null ) {
				addChild( houseMc );
			}
		}
		
		public function removeSelf():void {
			if ( houseMc.parent != null ) {
				removeChild( houseMc );
				houseMc = null;
			}
		}
	//end
	}
}
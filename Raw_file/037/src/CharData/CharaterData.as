package CharData 
{
	import flash.display.Sprite;
	/**
	 * ...
	 * @author domz
	 */
	public class CharaterData extends Sprite
	{
		public var charLevel:Number = 1;
		public var wastedByBurnt:Number = 0;
		public var highScore:Number = 0;
		public var wastedByLight:Number = 0;
		//MinusPoints
		public var minusPoint:Number = 0;

		public function CharaterData()
		{
			
		}
		public function updateLvl():void {
			charLevel++;
		}
		public function updateMinusPoints():void {
			minusPoint++;
		}
	}
}
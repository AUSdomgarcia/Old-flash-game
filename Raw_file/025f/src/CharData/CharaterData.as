package CharData 
{
	import flash.display.Sprite;
	/**
	 * ...
	 * @author domz
	 */
	public class CharaterData extends Sprite
	{
		public var charLevel:Number = 4;
		public var currBonusPoints:Number = 5;
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
		public function updateAddBonusPoints():void {
			currBonusPoints += 3;
		}
		public function updateMinusBonusPoints():void {
			if ( currBonusPoints > 0) {
				currBonusPoints--;
				trace(this,"CURR BONUS", currBonusPoints );
			} else { trace(this, "NO BONUS TO MINUS"); }
		}
	}
}
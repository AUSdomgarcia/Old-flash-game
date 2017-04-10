package CharData 
{
	import flash.display.Sprite;
	/**
	 * ...
	 * @author domz
	 */
	public class CharaterData extends Sprite
	{
		public var charLevel:Number = 0;
		public var wastedByBurnt:Number = 0;
		public var highScore:Number = 0;
		public var wastedByLight:Number = 0;
		
		public function CharaterData()
		{
			
		}
		public function updateLvl( num:Number ):void {
			charLevel = num;
		}
	}

}
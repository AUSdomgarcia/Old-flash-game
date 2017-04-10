package Interactive 
{
	import flash.display.MovieClip;
	/**
	 * ...
	 * @author dHOMZKIe
	 */
	public class SantaMeter extends MovieClip
	{
		private var meter:FaithMeter;
		public function SantaMeter()
		{
			meter = new FaithMeter();
			addChild(meter);
		}
		public function scoceUp():void {
			meter.SantaFace.gotoAndPlay(2);
		}
		public function animationStop():void {
			meter.SantaFace.gotoAndPlay(1);
		}
	}
}
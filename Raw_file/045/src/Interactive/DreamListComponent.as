package Interactive 
{
	import flash.display.Sprite;
	/**
	 * ...
	 * @author domz
	 */
	public class DreamListComponent extends Sprite
	{
		private var cloud:DreamPopUp;
		
		public function DreamListComponent (str:String, x:Number, y:Number ) 
		{
			cloud = new DreamPopUp();
			cloud.dreamClue(str);
			addChild(cloud);
		}
		public function removeCloud():void {
			if ( cloud.parent != null ) {
				parent.removeChild(cloud);
			}
		}

	//end	
	}
}
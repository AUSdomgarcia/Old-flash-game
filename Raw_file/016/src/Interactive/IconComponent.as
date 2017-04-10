package Interactive 
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	/**
	 * ...
	 * @author domz
	 */
	public class IconComponent extends Sprite
	{
		private var lockIcon:LockMc;
		public var isUnlock:Boolean = true;
		private var iconText:String;
		
		public var addBtnTrigger:Sprite; 
		private var _addBtn:AddBtnMC;
		private var _mc:IconList;
		
		public var label:String;
		public var state:Number;
		
		public function IconComponent( /*str:String*/ mcRef:Sprite, index:Number, _state:Number, _label:String, _name:String )
		{
			_mc = new IconList();
			
			_mc.x = mcRef.width / 2 - _mc.width / 2;
			_mc.y = mcRef.height / 2 - _mc.height / 2;
			
			_mc.gotoAndStop( _name );
			
			
			label = _label;
			state = _state;
			
			switch( state ) {
				case 0:
					lockIcon = new LockMc();
					lockIcon.x = mcRef.x + 1;
					lockIcon.y = mcRef.y + 1;
					isUnlock = true;
					
					addBtnTrigger = new Sprite();
					addItem();
				break;
				case 1:
					isUnlock = false;
					_addBtn = new AddBtnMC();
					_addBtn.indexNum = _name;
					
					addBtnTrigger = _addBtn;
					
					_addBtn.x = ( mcRef.width / 2 - _addBtn.width / 2 ) + 2;
					_addBtn.y = (mcRef.height - _addBtn.height) + 3;
					addItem();	
				break;
			}
		}
		public function addItem():void {
			if ( _mc != null ) {
				addChild(_mc);
			}
			if ( _addBtn != null ) {
				addChild(_addBtn);
			}
			if ( lockIcon != null ) {
				addChild(lockIcon);
			}
			
		}
		public function removeItem():void {
			if ( _mc.parent != null ) {
				removeChild(_mc);
				trace("mc remove");
			}
			if ( _addBtn != null ) {
				trace("btn remove");
				removeChild(_addBtn);
			}
			if ( lockIcon != null ) {
				trace("icon remove");
				removeChild(lockIcon);
			}
		}
		
		
		
		
	//end
	}
}
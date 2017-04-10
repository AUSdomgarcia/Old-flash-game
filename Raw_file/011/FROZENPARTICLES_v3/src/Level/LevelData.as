package Level 
{
	import flash.display.Sprite;
	/**
	 * ...
	 * @author domz
	 */
	public class LevelData extends Sprite
	{
		public var arrData:Array = [];
		public function LevelData() 
		{
			
		}
		public function setLevel( lvl:Number ):Array {
			switch( lvl ) {
				case 1:
					arrData	= [ { state: 1, label: "toy" },
								{ state: 1, label: "food" },
								{ state: 0, label: "extra" },
								{ state: 0, label: "toy" },
								{ state: 0, label: "food" },
								{ state: 0, label: "extra" }
							  ];
				break;
				case 2:
					arrData	= [ { state: 1, label: "toy" },
								{ state: 1, label: "food" },
								{ state: 0, label: "extra" }
							  ];
				break;
			}
			return arrData;
		}
	//end	
	}
}
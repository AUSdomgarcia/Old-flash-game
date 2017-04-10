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
					arrData	= [ { state: 1, label: "toy", name:"toy" },
								{ state: 1, label: "food", name:"2"},
								{ state: 1, label: "extra", name:"3"},
								{ state: 1, label: "toy", name:"4"},
								{ state: 1, label: "food", name:"5"},
								{ state: 1, label: "extra", name:"6"},
								{ state: 0, label: "toy", name:"7"},
								{ state: 0, label: "food", name:"8"},
								{ state: 0, label: "extra", name:"9"},
								{ state: 0, label: "toy", name:"10"},
								{ state: 0, label: "food", name:"11"},
								{ state: 0, label: "extra", name:"12"}
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